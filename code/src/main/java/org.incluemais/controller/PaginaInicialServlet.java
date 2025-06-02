package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "TelaInicialServlet", urlPatterns = {"/telaInicialAluno"})
public class PaginaInicialServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("identificacao") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String matricula = (String) session.getAttribute("identificacao");
        request.setAttribute("matricula", matricula);
        request.getRequestDispatcher("/templates/aluno/PaginaInicial.jsp").forward(request, response);
    }
}
