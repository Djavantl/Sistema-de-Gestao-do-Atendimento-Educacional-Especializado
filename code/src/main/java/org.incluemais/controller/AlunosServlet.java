package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.incluemais.model.dao.ProfessorAlunoDAO;
import org.incluemais.model.entities.Aluno;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/templates/professor/professor-alunos")
public class AlunosServlet extends HttpServlet {
    private ProfessorAlunoDAO professorAlunoDAO;

    @Override
    public void init() {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        professorAlunoDAO = new ProfessorAlunoDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String siape = request.getParameter("siape");

        if (siape == null || siape.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parâmetro SIAPE não fornecido");
            return;
        }

        try {
            List<Aluno> alunosVinculados = professorAlunoDAO.getAlunosByProfessor(siape);
            request.setAttribute("alunosVinculados", alunosVinculados);

            request.getRequestDispatcher("/templates/professor/Alunos.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao carregar alunos vinculados", e);
        }
    }
}
