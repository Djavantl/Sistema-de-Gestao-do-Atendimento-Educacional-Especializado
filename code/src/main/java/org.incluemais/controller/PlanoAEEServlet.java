package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.*;
import org.incluemais.model.entities.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;
import static org.incluemais.model.connection.DBConnection.getConnection;

/**
 * Servlet para criação, inserção e atualização de planos AEE.
 */
@WebServlet(name = "PlanoAEEServlet", urlPatterns = {
        "/templates/aee/criarPlanoAEE",
        "/templates/aee/planoAEE/inserir",
        "/templates/aee/planoAEE/atualizar"
})
public class PlanoAEEServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(PlanoAEEServlet.class.getName());

    /**
     * Exibe o formulário de criação de novo plano AEE.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        logger.info("Requisição GET recebida: " + path);

        if ("/templates/aee/criarPlanoAEE".equals(path)) {
            try (Connection conn = getConnection()) {
                AlunoDAO alunoDAO = new AlunoDAO(conn);
                ProfessorAEEDAO professorAEEDAO = new ProfessorAEEDAO(conn);
                request.setAttribute("alunos", alunoDAO.buscarTodos());
                request.setAttribute("professores", professorAEEDAO.getAll());
                request.getRequestDispatcher("/templates/aee/CriarPlanoAEE.jsp").forward(request, response);
            } catch (SQLException e) {
                logger.log(Level.SEVERE, "Erro ao carregar dados para criação de plano", e);
                request.setAttribute("erro", "Erro ao carregar dados: " + e.getMessage());
                request.getRequestDispatcher("/templates/aee/planosAEE").forward(request, response);
            }
        }
    }

    /**
     * Encaminha para a inserção ou atualização conforme a URL da requisição.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/templates/aee/planoAEE/inserir".equals(path)) {
            inserirPlano(request, response);
        } else if ("/templates/aee/planoAEE/atualizar".equals(path)) {
            atualizarPlano(request, response);
        }
    }

    /**
     * Processa a criação de um novo plano AEE e persiste no banco.
     */
    private void inserirPlano(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = getConnection();
            PlanoAEEDAO planoDAO = new PlanoAEEDAO(conn);
            AlunoDAO alunoDAO = new AlunoDAO(conn);
            ProfessorAEEDAO professorDAO = new ProfessorAEEDAO(conn);

            String siapeProfessor = request.getParameter("professor_siape");
            String matriculaAluno = request.getParameter("aluno_matricula");
            LocalDate dataInicio = LocalDate.parse(request.getParameter("dataInicio"));
            String recomendacoes = request.getParameter("recomendacoes");
            String observacoes = request.getParameter("observacoes");

            Aluno aluno = alunoDAO.buscarPorMatricula(matriculaAluno);
            ProfessorAEE professor = (siapeProfessor != null && !siapeProfessor.isEmpty())
                    ? professorDAO.buscarPorSiape(siapeProfessor)
                    : null;

            PlanoAEE novoPlano = new PlanoAEE(professor, aluno, dataInicio, recomendacoes, observacoes);
            int planoId = planoDAO.inserir(novoPlano);

            response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId);
        } catch (SQLException | IllegalArgumentException e) {
            logger.log(Level.SEVERE, "Erro ao criar plano", e);
            request.setAttribute("professor_siape", request.getParameter("professor_siape"));
            request.setAttribute("aluno_matricula", request.getParameter("aluno_matricula"));
            request.setAttribute("dataInicio", request.getParameter("dataInicio"));
            request.setAttribute("recomendacoes", request.getParameter("recomendacoes"));
            request.setAttribute("observacoes", request.getParameter("observacoes"));
            request.setAttribute("erro", "Erro ao criar plano: " + e.getMessage());
            try (Connection connReload = getConnection()) {
                AlunoDAO alunoDAO = new AlunoDAO(connReload);
                ProfessorAEEDAO professorAEEDAO = new ProfessorAEEDAO(connReload);
                request.setAttribute("alunos", alunoDAO.buscarTodos());
                request.setAttribute("professores", professorAEEDAO.getAll());
                request.getRequestDispatcher("/templates/aee/CriarPlanoAEE.jsp").forward(request, response);
            } catch (SQLException ex) {
                logger.log(Level.SEVERE, "Erro ao recarregar dados", ex);
                response.sendRedirect(request.getContextPath() + "/templates/aee/planosAEE?erro=Erro+crítico");
            }
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { logger.warning("Erro ao fechar conexão"); }
            }
        }
    }

    /**
     * Atualiza um plano AEE existente com novos dados e persiste no banco.
     */
    private void atualizarPlano(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        try {
            conn = getConnection();
            PlanoAEEDAO planoDAO = new PlanoAEEDAO(conn);
            ProfessorAEEDAO professorDAO = new ProfessorAEEDAO(conn);

            int id = Integer.parseInt(request.getParameter("id"));
            String siapeProfessor = request.getParameter("professor_siape");
            LocalDate dataInicio = LocalDate.parse(request.getParameter("dataInicio"));
            String recomendacoes = request.getParameter("recomendacoes");
            String observacoes = request.getParameter("observacoes");

            PlanoAEE plano = planoDAO.buscarPorId(id);
            if (plano == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Plano não encontrado");
                return;
            }

            if (siapeProfessor != null && !siapeProfessor.isEmpty()) {
                ProfessorAEE prof = professorDAO.buscarPorSiape(siapeProfessor);
                plano.setProfessorAEE(prof);
            } else {
                plano.setProfessorAEE(null);
            }

            plano.setDataInicio(dataInicio);
            plano.setRecomendacoes(recomendacoes);
            plano.setObservacoes(observacoes);

            boolean atualizado = planoDAO.atualizar(plano);
            if (atualizado) {
                response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + id + "&success=Plano+atualizado+com+sucesso");
            } else {
                response.sendRedirect(request.getContextPath() + "/templates/aee/editarPlanoAEE?id=" + id + "&erro=Falha+ao+atualizar+plano");
            }
        } catch (SQLException | IllegalArgumentException e) {
            logger.log(Level.SEVERE, "Erro ao atualizar plano", e);
            String idParam = request.getParameter("id");
            response.sendRedirect(request.getContextPath() + "/templates/aee/editarPlanoAEE?id=" + idParam + "&erro=Erro+ao+atualizar+plano");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { logger.warning("Erro ao fechar conexão"); }
            }
        }
    }
}
