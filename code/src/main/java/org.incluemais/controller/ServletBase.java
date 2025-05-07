package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/")
public class ServletBase extends jakarta.servlet.http.HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Configuração do encoding UTF-8
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Configuração do encoding para métodos POST também
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        // Seu código para processar POST...
    }
}