package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.ProfessorAlunoDAO;
import org.incluemais.model.dao.ProfessorDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Professor;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/templates/aee/professores-aluno")
public class ProfessoresDoAlunoServlet extends HttpServlet {
    private ProfessorAlunoDAO professorAlunoDAO;
    private AlunoDAO alunoDAO;
    private ProfessorDAO professorDAO;

    @Override
    public void init() {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        professorAlunoDAO = new ProfessorAlunoDAO(conn);
        alunoDAO = new AlunoDAO(conn);
        professorDAO = new ProfessorDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String matricula = request.getParameter("matricula");
        try {
            Aluno aluno = alunoDAO.buscar(matricula);
            if (aluno == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }
            System.out.println("Aluno encontrado: " + aluno.getNome()); // Debug
            request.setAttribute("aluno", aluno);

            List<Professor> professores = professorAlunoDAO.buscarProfessoresDoAluno(matricula);
            List<Professor> todosProfessores = professorDAO.getAll();

            request.setAttribute("professoresAluno", professores);
            request.setAttribute("todosProfessores", todosProfessores);
            request.getRequestDispatcher("/templates/aee/ProfessorAluno.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao carregar professores", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        String matricula = request.getParameter("matricula");
        String siape = request.getParameter("siape");

        try {
            if ("vincular".equals(acao)) {
                professorAlunoDAO.vincularProfessor(siape, matricula);
            } else if ("desvincular".equals(acao)) {
                professorAlunoDAO.desvincularProfessor(siape, matricula);
            }

            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/professores-aluno?matricula=" + matricula);

        } catch (SQLException e) {
            throw new ServletException("Erro ao processar ação", e);
        }
    }
}
