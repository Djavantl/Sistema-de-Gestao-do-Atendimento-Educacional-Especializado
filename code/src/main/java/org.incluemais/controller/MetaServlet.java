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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import static org.incluemais.model.connection.DBConnection.getConnection;

@WebServlet(name = "MetaServlet", urlPatterns = {
        "/metas/form",      // GET - Mostrar formulário de criação
        "/metas/criar",     // POST - Criar nova meta
        "/metas/listar",
        "/metas/editar",
        "/metas/atualizar",
        "/metas/excluir"
})
public class MetaServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(MetaServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getServletPath();

        try {
            switch (action) {
                case "/metas/form":
                    showMetaForm(request, response);
                    break;
                case "/metas/editar":
                    showEditForm(request, response);
                    break;
                case "/metas/listar":
                    listMetasByPlano(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (SQLException ex) {
            handleError(request, response, "Erro ao processar requisição GET", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getServletPath();

        try {
            switch (action) {
                case "/metas/criar":
                    createMeta(request, response);
                    break;
                case "/metas/atualizar":
                    updateMeta(request, response);
                    break;
                case "/metas/excluir":
                    deleteMeta(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    break;
            }
        } catch (SQLException ex) {
            handleError(request, response, "Erro ao processar requisição POST", ex);
        }
    }

    private void showMetaForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String planoId = request.getParameter("planoId");
        request.setAttribute("planoId", planoId);
        request.getRequestDispatcher("/templates/aee/Meta.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        try (Connection conn = getConnection()) {
            int metaId = Integer.parseInt(request.getParameter("id"));
            String planoId = request.getParameter("planoId");

            MetaDAO metaDAO = new MetaDAO(conn);
            // Como seu DAO não tem buscarPorId, vamos buscar todas e filtrar
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(Integer.parseInt(planoId));
            Meta meta = metas.stream().filter(m -> m.getId() == metaId).findFirst().orElse(null);

            if (meta == null) {
                throw new SQLException("Meta não encontrada");
            }

            request.setAttribute("meta", meta);
            request.setAttribute("planoId", planoId);
            request.getRequestDispatcher("/templates/aee/MetaForm.jsp").forward(request, response);
        }
    }

    private void listMetasByPlano(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        try (Connection conn = getConnection()) {
            int planoId = Integer.parseInt(request.getParameter("planoId"));
            MetaDAO metaDAO = new MetaDAO(conn);
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(planoId);

            request.setAttribute("metas", metas);
            request.setAttribute("planoId", planoId);
            request.getRequestDispatcher("/templates/aee/ListaMetas.jsp").forward(request, response);
        }
    }

    private void createMeta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String descricao = request.getParameter("descricao");
        String status = request.getParameter("status");
        int planoId = Integer.parseInt(request.getParameter("planoId"));

        try (Connection conn = getConnection()) {
            MetaDAO metaDAO = new MetaDAO(conn);
            Meta novaMeta = new Meta();
            novaMeta.setDescricao(descricao);
            novaMeta.setStatus(status);

            metaDAO.insert(novaMeta);

            // IMPORTANTE: Aqui você precisaria inserir na tabela PlanoAEE_Meta
            // para relacionar a meta com o plano

            response.sendRedirect(request.getContextPath() + "/metas/listar?planoId=" + planoId);
        }
    }

    private void updateMeta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int id = Integer.parseInt(request.getParameter("id"));
        String descricao = request.getParameter("descricao");
        String status = request.getParameter("status");
        int planoId = Integer.parseInt(request.getParameter("planoId"));

        try (Connection conn = getConnection()) {
            MetaDAO metaDAO = new MetaDAO(conn);
            Meta meta = new Meta();
            meta.setId(id);
            meta.setDescricao(descricao);
            meta.setStatus(status);

            metaDAO.update(meta);

            response.sendRedirect(request.getContextPath() + "/metas/listar?planoId=" + planoId);
        }
    }

    private void deleteMeta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        int id = Integer.parseInt(request.getParameter("id"));
        int planoId = Integer.parseInt(request.getParameter("planoId"));

        try (Connection conn = getConnection()) {
            MetaDAO metaDAO = new MetaDAO(conn);
            metaDAO.delete(id);

            response.sendRedirect(request.getContextPath() + "/metas/listar?planoId=" + planoId);
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String message, Exception ex)
            throws ServletException, IOException {

        logger.log(Level.SEVERE, message, ex);
        request.setAttribute("error", message + ": " + ex.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}