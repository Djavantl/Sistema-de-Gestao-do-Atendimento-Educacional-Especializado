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

@WebServlet("/templates/aee/metas/salvar")
public class SalvarMetaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String planoId = request.getParameter("planoId");
        String metaId = request.getParameter("metaId");
        String descricao = request.getParameter("descricao");
        String status = request.getParameter("status");

        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        MetaDAO metaDAO = new MetaDAO(conn);

        try {
            if (metaId == null || metaId.isEmpty()) {
                Meta novaMeta = new Meta();
                novaMeta.setDescricao(descricao);
                novaMeta.setStatus(status);
                metaDAO.insert(Integer.parseInt(planoId), novaMeta);
                response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&success=Meta adicionada com sucesso!");
            } else {
                Meta metaExistente = new Meta();
                metaExistente.setId(Integer.parseInt(metaId));
                metaExistente.setDescricao(descricao);
                metaExistente.setStatus(status);
                metaDAO.update(metaExistente);
                response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&success=Meta atualizada com sucesso!");
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&erro=Erro ao salvar meta: " + e.getMessage());
        }
    }
}