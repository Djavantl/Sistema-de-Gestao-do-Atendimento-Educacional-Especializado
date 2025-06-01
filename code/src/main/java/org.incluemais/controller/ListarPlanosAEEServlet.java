package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.PlanoAEEDAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import static org.incluemais.model.connection.DBConnection.getConnection;

@WebServlet(name = "ListaPlanosAEEServlet", urlPatterns = {"/templates/aee/planosAEE"})
public class ListarPlanosAEEServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(ListarPlanosAEEServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = getConnection()) {
            PlanoAEEDAO planoDAO = new PlanoAEEDAO(conn);
            List<Map<String, Object>> planos = planoDAO.listarTodosComNomes();

            request.setAttribute("planosLista", planos);
            request.getRequestDispatcher("/templates/aee/PlanosAEE.jsp").forward(request, response);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao listar planos", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
        }
    }
}