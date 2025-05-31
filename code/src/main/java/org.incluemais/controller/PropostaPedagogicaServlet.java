package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.PropostaPedagogicaDAO;
import org.incluemais.model.entities.PropostaPedagogica;
import org.incluemais.model.entities.RecursosComunicacaoEInformacao;
import org.incluemais.model.entities.RecursosPedagogicos;
import org.incluemais.model.entities.RecursoFisicoArquitetonico;
import java.util.logging.Level;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;
import static org.incluemais.model.connection.DBConnection.getConnection;

@WebServlet(name = "PropostaPedagogicaServlet", urlPatterns = {
        "/propostas",
        "/excluirProposta",
        "/editarProposta",
        "/atualizarProposta"
})
public class PropostaPedagogicaServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(PropostaPedagogicaServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/editarProposta".equals(path)) {
            carregarPaginaEdicao(request, response);
        } else if ("/propostas".equals(path)) {
            // Passar o planoAEEId para o JSP
            request.setAttribute("planoAEEId", request.getParameter("planoAEEId"));
            request.getRequestDispatcher("/templates/aee/PropostaPedagogica.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/excluirProposta".equals(path)) {
            excluirProposta(request, response);
        } else if ("/atualizarProposta".equals(path)) {
            atualizarProposta(request, response);
        } else {
            criarProposta(request, response);
        }
    }

    private void carregarPaginaEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        try {
            conn = getConnection();
            PropostaPedagogicaDAO propostaDAO = new PropostaPedagogicaDAO(conn);

            String propostaIdParam = request.getParameter("id");
            if (propostaIdParam == null || propostaIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID da proposta não fornecido");
                return;
            }

            int propostaId = Integer.parseInt(propostaIdParam);
            PropostaPedagogica proposta = propostaDAO.buscarPorId(propostaId);

            if (proposta == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Proposta não encontrada");
                return;
            }

            // Obter planoId da proposta
            int planoId = proposta.getPlanoAEEId();

            request.setAttribute("proposta", proposta);
            request.setAttribute("planoId", planoId);

            // Encaminhar para a página de edição
            request.getRequestDispatcher("/templates/aee/EditarPropostaPedagogica.jsp").forward(request, response);

        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao carregar proposta para edição", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    logger.warning("Erro ao fechar conexão");
                }
            }
        }
    }

    private void atualizarProposta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        try {
            conn = getConnection();
            PropostaPedagogicaDAO propostaDAO = new PropostaPedagogicaDAO(conn);

            // Obter IDs
            int propostaId = Integer.parseInt(request.getParameter("propostaId"));
            int planoId = Integer.parseInt(request.getParameter("planoId"));

            // BUSCAR PROPOSTA EXISTENTE (PARA OBTER OS IDs DOS RECURSOS)
            PropostaPedagogica propostaExistente = propostaDAO.buscarPorId(propostaId);
            if (propostaExistente == null) {
                throw new SQLException("Proposta não encontrada para atualização");
            }

            // ATUALIZAR OS RECURSOS EXISTENTES EM VEZ DE CRIAR NOVOS
            atualizarRecursoExistente(propostaExistente.getRecursoP(), request);
            atualizarRecursoExistente(propostaExistente.getRecursoFA(), request);
            atualizarRecursoExistente(propostaExistente.getRecursoCI(), request);

            // Criar proposta atualizada COM OS RECURSOS EXISTENTES (que agora têm valores atualizados)
            PropostaPedagogica proposta = new PropostaPedagogica(
                    propostaId,
                    request.getParameter("objetivos"),
                    request.getParameter("metodologias"),
                    request.getParameter("observacoes"), // NOVO CAMPO
                    propostaExistente.getRecursoP(),
                    propostaExistente.getRecursoFA(),
                    propostaExistente.getRecursoCI(),
                    planoId
            );

            // Atualizar no banco
            propostaDAO.atualizar(proposta);

            // Redirecionar para detalhes do plano com mensagem de sucesso
            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/detalhes-plano?id=" + planoId +
                    "&success=Proposta+atualizada+com+sucesso");

        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao atualizar proposta", e);

            // Tentar manter os dados para nova tentativa
            request.setAttribute("erro", "Erro ao atualizar proposta: " + e.getMessage());

            // Recarregar página de edição
            request.setAttribute("propostaId", request.getParameter("propostaId"));
            carregarPaginaEdicao(request, response);

        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    logger.warning("Erro ao fechar conexão");
                }
            }
        }
    }

    // Método auxiliar para atualizar recursos existentes
    private void atualizarRecursoExistente(Object recurso, HttpServletRequest request) {
        if (recurso == null) return;

        if (recurso instanceof RecursosPedagogicos) {
            RecursosPedagogicos rp = (RecursosPedagogicos) recurso;
            rp.setAdaptacaoDidaticaAulasAvaliacoes(request.getParameter("recursoP_adaptacaoDidaticaAulasAvaliacoes") != null);
            rp.setMaterialDidaticoAdaptado(request.getParameter("recursoP_materialDidaticoAdaptado") != null);
            rp.setUsoTecnologiaAssistiva(request.getParameter("recursoP_usoTecnologiaAssistiva") != null);
            rp.setTempoEmpregadoAtividadesAvaliacoes(request.getParameter("recursoP_tempoEmpregadoAtividadesAvaliacoes") != null);
        }
        else if (recurso instanceof RecursoFisicoArquitetonico) {
            RecursoFisicoArquitetonico rfa = (RecursoFisicoArquitetonico) recurso;
            rfa.setUsoCadeiraDeRodas(request.getParameter("recursoFA_usoCadeiraDeRodas") != null);
            rfa.setAuxilioTranscricaoEscrita(request.getParameter("recursoFA_auxilioTranscricaoEscrita") != null);
            rfa.setMesaAdaptadaCadeiraDeRodas(request.getParameter("recursoFA_mesaAdaptadaCadeiraDeRodas") != null);
            rfa.setUsoDeMuleta(request.getParameter("recursoFA_usoDeMuleta") != null);
            rfa.setOutrosFisicoArquitetonico(request.getParameter("recursoFA_outrosFisicoArquitetonico") != null);
            rfa.setOutrosEspecificado(request.getParameter("recursoFA_outrosEspecificado"));
        }
        else if (recurso instanceof RecursosComunicacaoEInformacao) {
            RecursosComunicacaoEInformacao rci = (RecursosComunicacaoEInformacao) recurso;
            rci.setComunicacaoAlternativa(request.getParameter("recursoCI_comunicacaoAlternativa") != null);
            rci.setTradutorInterprete(request.getParameter("recursoCI_tradutorInterprete") != null);
            rci.setLeitorTranscritor(request.getParameter("recursoCI_leitorTranscritor") != null);
            rci.setInterpreteOralizador(request.getParameter("recursoCI_interpreteOralizador") != null);
            rci.setGuiaInterprete(request.getParameter("recursoCI_guiaInterprete") != null);
            rci.setMaterialDidaticoBraille(request.getParameter("recursoCI_materialDidaticoBraille") != null);
            rci.setMaterialDidaticoTextoAmpliado(request.getParameter("recursoCI_materialDidaticoTextoAmpliado") != null);
            rci.setMaterialDidaticoRelevo(request.getParameter("recursoCI_materialDidaticoRelevo") != null);
            rci.setLeitorDeTela(request.getParameter("recursoCI_leitorDeTela") != null);
            rci.setFonteTamanhoEspecifico(request.getParameter("recursoCI_fonteTamanhoEspecifico") != null);
        }
    }

    private void criarProposta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = getConnection();
            int planoAEEId = Integer.parseInt(request.getParameter("planoAEEId"));

            // Criar DAO primeiro (necessário para persistir recursos)
            PropostaPedagogicaDAO propostaDAO = new PropostaPedagogicaDAO(conn);

            // Construir recursos
            RecursosPedagogicos recursoP = construirRecursoPedagogico(request);
            RecursoFisicoArquitetonico recursoFA = construirRecursoFisico(request);
            RecursosComunicacaoEInformacao recursoCI = construirRecursoComunicacao(request);

            // Criar a proposta COM OS RECURSOS
            PropostaPedagogica proposta = new PropostaPedagogica(
                    request.getParameter("objetivos"),
                    request.getParameter("metodologias"),
                    request.getParameter("observacoes"),
                    recursoP,
                    recursoFA,
                    recursoCI,
                    planoAEEId
            );

            // INSERIR usando o DAO (que cuidará dos recursos)
            propostaDAO.inserir(proposta);

            // Redirecionar para a página de detalhes do plano com mensagem de sucesso
            response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoAEEId + "&success=Proposta+criada+com+sucesso");

        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao criar proposta", e);
            request.setAttribute("erro", "Erro ao salvar proposta: " + e.getMessage());
            request.getRequestDispatcher("/templates/aee/PropostaPedagogica.jsp").forward(request, response);
        } finally {
            if (conn != null) {
                try { conn.close(); }
                catch (SQLException e) { logger.warning("Erro ao fechar conexão"); }
            }
        }
    }

    private void excluirProposta(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Connection conn = null;
        try {
            conn = getConnection();
            String propostaIdParam = request.getParameter("propostaId");
            String planoIdParam = request.getParameter("planoId");

            if (propostaIdParam == null || propostaIdParam.isEmpty() ||
                    planoIdParam == null || planoIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parâmetros inválidos");
                return;
            }

            int propostaId = Integer.parseInt(propostaIdParam);
            int planoId = Integer.parseInt(planoIdParam);

            PropostaPedagogicaDAO propostaDAO = new PropostaPedagogicaDAO(conn);
            propostaDAO.excluirPropostaComRecursos(propostaId);

            // Redirecionar de volta para a página de detalhes do plano com mensagem de sucesso
            response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&success=Proposta+excluída+com+sucesso");

        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao excluir proposta", e);
            String planoId = request.getParameter("planoId");
            response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&erro=Erro+ao+excluir+proposta");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    logger.warning("Erro ao fechar conexão");
                }
            }
        }
    }

    private RecursosPedagogicos construirRecursoPedagogico(HttpServletRequest request) {
        RecursosPedagogicos recurso = new RecursosPedagogicos(
                request.getParameter("recursoP_adaptacaoDidaticaAulasAvaliacoes") != null,
                request.getParameter("recursoP_materialDidaticoAdaptado") != null,
                request.getParameter("recursoP_usoTecnologiaAssistiva") != null,
                request.getParameter("recursoP_tempoEmpregadoAtividadesAvaliacoes") != null
        );
        return recurso.temRecursos() ? recurso : null;
    }

    private RecursoFisicoArquitetonico construirRecursoFisico(HttpServletRequest request) {
        RecursoFisicoArquitetonico recurso = new RecursoFisicoArquitetonico(
                request.getParameter("recursoFA_usoCadeiraDeRodas") != null,
                request.getParameter("recursoFA_auxilioTranscricaoEscrita") != null,
                request.getParameter("recursoFA_mesaAdaptadaCadeiraDeRodas") != null,
                request.getParameter("recursoFA_usoDeMuleta") != null,
                request.getParameter("recursoFA_outrosFisicoArquitetonico") != null,
                request.getParameter("recursoFA_outrosEspecificado")
        );
        return recurso.temRecursos() ? recurso : null;
    }

    private RecursosComunicacaoEInformacao construirRecursoComunicacao(HttpServletRequest request) {
        RecursosComunicacaoEInformacao recurso = new RecursosComunicacaoEInformacao(
                request.getParameter("recursoCI_comunicacaoAlternativa") != null,
                request.getParameter("recursoCI_tradutorInterprete") != null,
                request.getParameter("recursoCI_leitorTranscritor") != null,
                request.getParameter("recursoCI_interpreteOralizador") != null,
                request.getParameter("recursoCI_guiaInterprete") != null,
                request.getParameter("recursoCI_materialDidaticoBraille") != null,
                request.getParameter("recursoCI_materialDidaticoTextoAmpliado") != null,
                request.getParameter("recursoCI_materialDidaticoRelevo") != null,
                request.getParameter("recursoCI_leitorDeTela") != null,
                request.getParameter("recursoCI_fonteTamanhoEspecifico") != null
        );
        return recurso.temRecursos() ? recurso : null;
    }
}