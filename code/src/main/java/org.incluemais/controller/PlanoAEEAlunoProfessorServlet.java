package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.PlanoAEEDAO;
import org.incluemais.model.dao.ProfessorAEEDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.PlanoAEE;
import org.incluemais.model.entities.ProfessorAEE;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import org.incluemais.model.connection.DBConnection;

@WebServlet("/templates/professor/visualizar-plano")
public class PlanoAEEAlunoProfessorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String matricula = request.getParameter("matricula");
        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula do aluno inválida");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            PlanoAEEDAO planoAeeDAO = new PlanoAEEDAO(conn);
            AlunoDAO alunoDAO = new AlunoDAO(conn);
            ProfessorAEEDAO professorDAO = new ProfessorAEEDAO(conn);

            // Buscar aluno pela matrícula
            Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
            if (aluno == null) {
                request.setAttribute("erro", "Aluno não encontrado");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            // Buscar plano do aluno
            PlanoAEE plano = planoAeeDAO.buscarPorAluno(matricula);

            if (plano == null) {
                request.setAttribute("erro", "Nenhum plano encontrado para este aluno");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            // Completar dados do professor se existir
            if (plano.getProfessorAEE() != null && plano.getProfessorAEE().getSiape() != null) {
                ProfessorAEE professor = professorDAO.buscarPorSiape(
                        plano.getProfessorAEE().getSiape()
                );
                plano.setProfessorAEE(professor);
            }

            // Completar dados do aluno
            plano.setAluno(aluno);

            request.setAttribute("plano", plano);
            request.getRequestDispatcher("/templates/professor/PlanoAEEAlunoP.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar plano: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }


}