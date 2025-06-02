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
    private AlunoDAO alunoDAO;
    private ProfessorAEEDAO professorAEEDAO;
    private PropostaPedagogicaDAO propostaDAO;
    private MetaDAO metaDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.planoAEEDAO = new PlanoAEEDAO(conn);
        this.alunoDAO = new AlunoDAO(conn);
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
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

        // Recupera a matrícula do aluno da sessão
        String matricula = request.getParameter("matricula");
        try {
            // Busca o plano do aluno por matrícula
            PlanoAEE plano = planoAEEDAO.buscarPorMatriculaAluno(matricula);

            if (plano == null) {
                // Caso não exista plano para o aluno
                request.setAttribute("semPlano", true);
                request.getRequestDispatcher("/templates/aluno/MeuPlanoAEE.jsp").forward(request, response);
                return;
            }

            // Busca informações complementares
            Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
            ProfessorAEE professor = null;
            if (plano.getProfessorSiape() != null) {
                professor = professorAEEDAO.getBySiape(plano.getProfessorSiape());
            }
            PropostaPedagogica proposta = propostaDAO.buscarPorPlanoId(plano.getId());
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(plano.getId());

            // Atribui as relações ao plano
            plano.setProposta(proposta);
            plano.setMetas(metas);

            // Adiciona atributos para a JSP
            request.setAttribute("plano", plano);
            request.setAttribute("aluno", aluno);
            request.setAttribute("professor", professor);

            request.getRequestDispatcher("/templates/aluno/MeuPlanoAEE.jsp").forward(request, response);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao carregar plano do aluno", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
        }
    }
}