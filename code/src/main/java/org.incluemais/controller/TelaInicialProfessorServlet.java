package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.incluemais.model.dao.ProfessorAEEDAO;
import org.incluemais.model.dao.ProfessorDAO;

import org.incluemais.model.entities.Professor;
import org.incluemais.model.entities.ProfessorAEE;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/telaInicialProfessor")
public class TelaInicialProfessorServlet extends HttpServlet {
    private ProfessorDAO professorDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.professorDAO = new ProfessorDAO(conn);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        System.out.println("aa");
        // Verificar se o usuário está autenticado como professor
        if (session == null || !"professor".equals(session.getAttribute("tipoUsuario"))) {
            System.out.println("Deu ruim");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }


        String siape = (String) session.getAttribute("identificacao");
        System.out.println(siape);

        Professor professor = professorDAO.getBySiape(siape);
        if (professor != null) {
            request.setAttribute("nome", professor.getNome());
        } else {
            // Caso não encontre, define um nome padrão
            request.setAttribute("nome", "Professor");
        }
        request.setAttribute("siape", siape);
        request.getRequestDispatcher("/templates/professor/TelaInicialProfessor.jsp").forward(request, response);
    }
}