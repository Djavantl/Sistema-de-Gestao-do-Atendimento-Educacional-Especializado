package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.ProfessorAEEDAO;
import org.incluemais.model.entities.ProfessorAEE;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/buscarProfessor")
public class BuscarProfessorServlet extends HttpServlet {
    private ProfessorAEEDAO professorAEEDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String siape = request.getParameter("siape");
        if (siape == null || siape.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "SIAPE não informado");
            return;
        }

        try {
            ProfessorAEE professor = professorAEEDAO.getBySiape(siape);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            if (professor != null) {
                // Retorna os dados do professor em JSON
                String json = String.format("{\"nome\":\"%s\", \"siape\":\"%s\"}",
                        professor.getNome(), professor.getSiape());
                response.getWriter().write(json);
            } else {
                response.getWriter().write("{}");
            }
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro no banco de dados");
        }
    }
}
