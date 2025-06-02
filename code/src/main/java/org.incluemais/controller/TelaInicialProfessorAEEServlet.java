package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.incluemais.model.dao.ProfessorAEEDAO;
import org.incluemais.model.entities.ProfessorAEE;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "TelaInicialProfessorAEEServlet", urlPatterns = {"/telaInicialProfessorAEE"})
public class TelaInicialProfessorAEEServlet extends HttpServlet {
    private ProfessorAEEDAO professorAEEDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("identificacao") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String siape = (String) session.getAttribute("identificacao");
        try {
            ProfessorAEE professor = professorAEEDAO.buscarPorSiape(siape);
            if (professor != null) {
                request.setAttribute("nome", professor.getNome());
            } else {
                // Caso não encontre, define um nome padrão
                request.setAttribute("nome", "Professor");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("nome", "Professor");
        }

        request.getRequestDispatcher("/templates/aee/TelaInicial.jsp").forward(request, response);
    }
}