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

@WebServlet("/templates/aee/metas/excluir")
public class ExcluirMetaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String planoId = request.getParameter("planoId");
        String metaId = request.getParameter("metaId");

        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        PlanoAEEDAO planoDAO = new PlanoAEEDAO(conn);

        try {
            if (planoDAO.excluirMeta(Integer.parseInt(metaId))) {
                response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&success=Meta excluída com sucesso!");
            } else {
                response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&erro=Falha ao excluir meta");
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&erro=Erro ao excluir meta: " + e.getMessage());
        }
    }
}