package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.MetaDAO;
import org.incluemais.model.entities.Meta;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/templates/aee/metas/form")
public class MetaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String planoId = request.getParameter("planoId");
        String metaId = request.getParameter("metaId");
        Meta meta = null;

        if (metaId != null && !metaId.isEmpty()) {
            try {
                Connection conn = (Connection) getServletContext().getAttribute("conexao");
                MetaDAO metaDAO = new MetaDAO(conn);
                meta = metaDAO.find(Integer.parseInt(metaId));
            } catch (SQLException | NumberFormatException e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("planoId", planoId);
        request.setAttribute("meta", meta);
        request.getRequestDispatcher("/templates/aee/Meta.jsp").forward(request, response);
    }
}