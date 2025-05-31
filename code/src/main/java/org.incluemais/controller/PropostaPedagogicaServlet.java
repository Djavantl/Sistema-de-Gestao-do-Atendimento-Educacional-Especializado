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


@WebServlet("/propostas")
public class PropostaPedagogicaServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(PropostaPedagogicaServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/templates/aee/PropostaPedagogica.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                    recursoP,
                    recursoFA,
                    recursoCI,
                    planoAEEId
            );

            // INSERIR usando o DAO (que cuidará dos recursos)
            propostaDAO.inserir(proposta);

            request.setAttribute("propostaId", proposta.getId());
            response.sendRedirect(request.getContextPath() + "/propostas?success=true");

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
