package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.incluemais.model.dao.*;
import org.incluemais.model.entities.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "MeuPlanoAEEServlet", urlPatterns = {"/meu-plano"})
public class MeuPlanoAEEServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(MeuPlanoAEEServlet.class.getName());

    private PlanoAEEDAO planoAEEDAO;
    private PropostaPedagogicaDAO propostaDAO;
    private MetaDAO metaDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.planoAEEDAO = new PlanoAEEDAO(conn);
        this.propostaDAO = new PropostaPedagogicaDAO(conn);
        this.metaDAO = new MetaDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("tipoUsuario") == null ||
                !"aluno".equals(session.getAttribute("tipoUsuario"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Obter matrícula da sessão ao invés de parâmetro
        String matricula = (String) session.getAttribute("identificacao");
        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula não encontrada na sessão");
            return;
        }

        try {
            PlanoAEE plano = planoAEEDAO.buscarPorMatriculaAluno(matricula);

            if (plano == null) {
                request.setAttribute("semPlano", true);
                request.setAttribute("matricula", matricula);
                request.getRequestDispatcher("/templates/aluno/MeuPlanoAEE.jsp").forward(request, response);
                return;
            }

            PropostaPedagogica proposta = propostaDAO.buscarPorPlanoId(plano.getId());
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(plano.getId());

            plano.setProposta(proposta);
            plano.setMetas(metas);

            // Adicionar matrícula como atributo para a JSP
            request.setAttribute("matricula", matricula);
            request.setAttribute("plano", plano);
            request.getRequestDispatcher("/templates/aluno/MeuPlanoAEE.jsp").forward(request, response);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao carregar plano do aluno", e);
            request.setAttribute("erro", "Erro ao carregar plano: " + e.getMessage());
            request.getRequestDispatcher("/templates/aluno/MeuPlanoAEE.jsp").forward(request, response);
        }
    }
}