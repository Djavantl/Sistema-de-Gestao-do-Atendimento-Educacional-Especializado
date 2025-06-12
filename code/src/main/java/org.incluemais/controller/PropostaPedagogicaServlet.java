package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.PropostaPedagogicaDAO;
import org.incluemais.model.dao.RecursoFisicoArquitetonicoDAO;
import org.incluemais.model.dao.RecursosComunicacaoEInformacaoDAO;
import org.incluemais.model.dao.RecursosPedagogicosDAO;
import org.incluemais.model.entities.PlanoAEE;
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
            request.setAttribute("planoAEEId", request.getParameter("planoAEEId"));
            request.getRequestDispatcher("/templates/aee/PropostaPedagogica.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        if ("excluirProposta".equals(path) || "/excluirProposta".equals(path)) {
            excluirProposta(request, response);
        } else if ("/atualizarProposta".equals(path)) {
            atualizarProposta(request, response);
        } else {
            criarProposta(request, response);
        }
    }

    /**
     * Cria uma nova PropostaPedagogica associada a um PlanoAEE existente
     */
    private void criarProposta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = getConnection();
            int planoAEEId = Integer.parseInt(request.getParameter("planoAEEId"));
            PropostaPedagogicaDAO propostaDAO = new PropostaPedagogicaDAO(conn);

            RecursosPedagogicos recursoP = construirRecursoPedagogico(request);
            RecursoFisicoArquitetonico recursoFA = construirRecursoFisico(request);
            RecursosComunicacaoEInformacao recursoCI = construirRecursoComunicacao(request);

            PlanoAEE plano = new PlanoAEE();
            plano.setId(planoAEEId);

            PropostaPedagogica proposta = new PropostaPedagogica(
                    request.getParameter("objetivos"),
                    request.getParameter("metodologias"),
                    request.getParameter("observacoes"),
                    recursoP,
                    recursoFA,
                    recursoCI,
                    plano
            );
            propostaDAO.insert(proposta);
            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/detalhes-plano?id=" + planoAEEId +
                    "&success=Proposta+criada+com+sucesso");
        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao criar proposta", e);
            request.setAttribute("erro", "Erro ao salvar proposta: " + e.getMessage());
            request.getRequestDispatcher("/templates/aee/PropostaPedagogica.jsp").forward(request, response);
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) {
                    logger.warning("Erro ao fechar conexão");
                }
            }
        }
    }

    // Monta objeto RecursosPedagogicos a partir dos parâmetros da requisição
    private RecursosPedagogicos construirRecursoPedagogico(HttpServletRequest request) {
        RecursosPedagogicos recurso = new RecursosPedagogicos(
                request.getParameter("recursoP_adaptacaoDidaticaAulasAvaliacoes") != null,
                request.getParameter("recursoP_materialDidaticoAdaptado") != null,
                request.getParameter("recursoP_usoTecnologiaAssistiva") != null,
                request.getParameter("recursoP_tempoEmpregadoAtividadesAvaliacoes") != null
        );
        return recurso.temRecursos() ? recurso : null;
    }

    // Monta objeto RecursoFisicoArquitetonico a partir dos parâmetros da requisição
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

    // Monta objeto RecursosComunicacaoEInformacao a partir dos parâmetros da requisição
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

    /**
     * Carrega dados de uma proposta existente e encaminha para a página de edição
     */
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
            PropostaPedagogica proposta = propostaDAO.findbyPropostaId(propostaId);
            if (proposta == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Proposta não encontrada");
                return;
            }
            int planoId = proposta.getPlanoAEE().getId();
            request.setAttribute("proposta", proposta);
            request.setAttribute("planoId", planoId);
            request.getRequestDispatcher("/templates/aee/EditarPropostaPedagogica.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao carregar proposta para edição", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) {
                    logger.warning("Erro ao fechar conexão");
                }
            }
        }
    }

    /**
     * Atualiza uma proposta existente com novos dados e recursos
     */
    private void atualizarProposta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = getConnection();
            PropostaPedagogicaDAO propostaDAO = new PropostaPedagogicaDAO(conn);

            int propostaId = Integer.parseInt(request.getParameter("propostaId"));
            int planoId = Integer.parseInt(request.getParameter("planoId"));
            PropostaPedagogica existente = propostaDAO.findbyPropostaId(propostaId);
            if (existente == null) {
                throw new SQLException("Proposta não encontrada para atualização");
            }

            // Verifica e cria novos recursos se necessário
            RecursosPedagogicos recursoP = (existente.getRecursoP() != null) ?
                    existente.getRecursoP() : construirRecursoPedagogico(request);

            RecursoFisicoArquitetonico recursoFA = (existente.getRecursoFA() != null) ?
                    existente.getRecursoFA() : construirRecursoFisico(request);

            RecursosComunicacaoEInformacao recursoCI = (existente.getRecursoCI() != null) ?
                    existente.getRecursoCI() : construirRecursoComunicacao(request);

            // Atualiza os recursos
            atualizarRecursoExistente(recursoP, request);
            atualizarRecursoExistente(recursoFA, request);
            atualizarRecursoExistente(recursoCI, request);

            // Verifica se os recursos estão vazios após atualização
            if (recursoP != null && !recursoP.temRecursos()) {
                if (recursoP.getId() > 0) {
                    new RecursosPedagogicosDAO(conn).delete(recursoP.getId());
                }
                recursoP = null;
            }

            if (recursoFA != null && !recursoFA.temRecursos()) {
                if (recursoFA.getId() > 0) {
                    new RecursoFisicoArquitetonicoDAO(conn).delete(recursoFA.getId());
                }
                recursoFA = null;
            }

            if (recursoCI != null && !recursoCI.temRecursos()) {
                if (recursoCI.getId() > 0) {
                    new RecursosComunicacaoEInformacaoDAO(conn).delete(recursoCI.getId());
                }
                recursoCI = null;
            }

            PlanoAEE plano = new PlanoAEE();
            plano.setId(planoId);

            // Persiste novos recursos antes da proposta
            persistirNovosRecursos(conn, recursoP, recursoFA, recursoCI);

            PropostaPedagogica atualizada = new PropostaPedagogica(
                    propostaId,
                    request.getParameter("objetivos"),
                    request.getParameter("metodologias"),
                    request.getParameter("observacoes"),
                    recursoP,
                    recursoFA,
                    recursoCI,
                    plano
            );

            propostaDAO.update(atualizada);
            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/detalhes-plano?id=" + planoId +
                    "&success=Proposta+atualizada+com+sucesso");
        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao atualizar proposta", e);
            request.setAttribute("erro", "Erro ao atualizar proposta: " + e.getMessage());
            carregarPaginaEdicao(request, response);
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) {
                    logger.warning("Erro ao fechar conexão");
                }
            }
        }
    }

    // Adicione este novo método
    private void persistirNovosRecursos(Connection conn,
                                        RecursosPedagogicos recursoP,
                                        RecursoFisicoArquitetonico recursoFA,
                                        RecursosComunicacaoEInformacao recursoCI)
            throws SQLException {

        // Só persiste novos recursos que não estão vazios
        if (recursoP != null && recursoP.getId() == 0 && recursoP.temRecursos()) {
            new RecursosPedagogicosDAO(conn).insert(recursoP);
        }
        if (recursoFA != null && recursoFA.getId() == 0 && recursoFA.temRecursos()) {
            new RecursoFisicoArquitetonicoDAO(conn).insert(recursoFA);
        }
        if (recursoCI != null && recursoCI.getId() == 0 && recursoCI.temRecursos()) {
            new RecursosComunicacaoEInformacaoDAO(conn).insert(recursoCI);
        }
    }

    // Atualiza campos de um recurso existente com parâmetros da requisição
    private void atualizarRecursoExistente(Object recurso, HttpServletRequest request) {
        if (recurso == null) return;
        if (recurso instanceof RecursosPedagogicos) {
            RecursosPedagogicos rp = (RecursosPedagogicos) recurso;
            rp.setAdaptacaoDidaticaAulasAvaliacoes(request.getParameter("recursoP_adaptacaoDidaticaAulasAvaliacoes") != null);
            rp.setMaterialDidaticoAdaptado(request.getParameter("recursoP_materialDidaticoAdaptado") != null);
            rp.setUsoTecnologiaAssistiva(request.getParameter("recursoP_usoTecnologiaAssistiva") != null);
            rp.setTempoEmpregadoAtividadesAvaliacoes(request.getParameter("recursoP_tempoEmpregadoAtividadesAvaliacoes") != null);
        } else if (recurso instanceof RecursoFisicoArquitetonico) {
            RecursoFisicoArquitetonico rfa = (RecursoFisicoArquitetonico) recurso;
            rfa.setUsoCadeiraDeRodas(request.getParameter("recursoFA_usoCadeiraDeRodas") != null);
            rfa.setAuxilioTranscricaoEscrita(request.getParameter("recursoFA_auxilioTranscricaoEscrita") != null);
            rfa.setMesaAdaptadaCadeiraDeRodas(request.getParameter("recursoFA_mesaAdaptadaCadeiraDeRodas") != null);
            rfa.setUsoDeMuleta(request.getParameter("recursoFA_usoDeMuleta") != null);
            rfa.setOutrosFisicoArquitetonico(request.getParameter("recursoFA_outrosFisicoArquitetonico") != null);
            rfa.setOutrosEspecificado(request.getParameter("recursoFA_outrosEspecificado"));
        } else if (recurso instanceof RecursosComunicacaoEInformacao) {
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

    /**
     * Remove proposta e seus recursos associados de um PlanoAEE
     */
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
            propostaDAO.deletePropostaERecursos(propostaId);
            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/detalhes-plano?id=" + planoId +
                    "&success=Proposta+excluída+com+sucesso");
        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao excluir proposta", e);
            String planoId = request.getParameter("planoId");
            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/detalhes-plano?id=" + planoId +
                    "&erro=Erro+ao+excluir+proposta");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) {
                    logger.warning("Erro ao fechar conexão");
                }
            }
        }
    }
}