package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.incluemais.model.dao.MetaDAO;
import org.incluemais.model.dao.PlanoAEEDAO;
import org.incluemais.model.dao.PropostaPedagogicaDAO;
import org.incluemais.model.entities.Meta;
import org.incluemais.model.entities.PlanoAEE;
import org.incluemais.model.entities.PropostaPedagogica;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet que exibe ao aluno seu Plano AEE, incluindo proposta e metas.
 */
@WebServlet(name = "MeuPlanoAEEServlet", urlPatterns = {"/meu-plano"})
public class MeuPlanoAEEServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(MeuPlanoAEEServlet.class.getName());

    private PlanoAEEDAO planoAEEDAO;
    private PropostaPedagogicaDAO propostaDAO;
    private MetaDAO metaDAO;

    /**
     * Inicializa DAOs usando conexão do contexto.
     */
    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.planoAEEDAO = new PlanoAEEDAO(conn);
        this.propostaDAO = new PropostaPedagogicaDAO(conn);
        this.metaDAO = new MetaDAO(conn);
    }

    /**
     * Trata requisições GET para exibição do plano AEE do aluno autenticado.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Valida sessão e tipo de usuário
        HttpSession session = request.getSession(false);
        if (session == null || !"aluno".equals(session.getAttribute("tipoUsuario"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Obtém matrícula do aluno da sessão
        String matricula = (String) session.getAttribute("identificacao");
        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula não encontrada na sessão");
            return;
        }

        try {
            // Busca o plano do aluno
            PlanoAEE plano = planoAEEDAO.find(matricula);
            if (plano == null) {
                // Nenhum plano existente: sinaliza para a JSP
                request.setAttribute("semPlano", true);
                request.setAttribute("matricula", matricula);
                request.getRequestDispatcher("/templates/aluno/MeuPlanoAEE.jsp").forward(request, response);
                return;
            }

            // Recupera proposta pedagógica associada
            PropostaPedagogica proposta = propostaDAO.findByPlanoAEE(plano.getId());
            // Carrega metas do plano
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(plano.getId());

            plano.setProposta(proposta);
            plano.setMetas(metas);

            // Prepara atributos para a exibição
            request.setAttribute("matricula", matricula);
            request.setAttribute("plano", plano);
            request.setAttribute("metas", metas);
            request.getRequestDispatcher("/templates/aluno/MeuPlanoAEE.jsp").forward(request, response);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao carregar plano do aluno", e);
            request.setAttribute("erro", "Erro ao carregar plano: " + e.getMessage());
            request.getRequestDispatcher("/templates/aluno/MeuPlanoAEE.jsp").forward(request, response);
        }
    }
}
