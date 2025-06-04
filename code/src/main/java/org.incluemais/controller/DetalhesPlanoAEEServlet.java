package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.*;
import org.incluemais.model.entities.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import static org.incluemais.model.connection.DBConnection.getConnection;

@WebServlet(name = "DetalhesPlanoAEEServlet",
        urlPatterns = {"/templates/aee/detalhes-plano"})
public class DetalhesPlanoAEEServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(DetalhesPlanoAEEServlet.class.getName());

    private PlanoAEEDAO planoAEEDAO;
    private PropostaPedagogicaDAO propostaDAO;
    private MetaDAO metaDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.planoAEEDAO = new PlanoAEEDAO(conn);
        this.propostaDAO = new PropostaPedagogicaDAO(conn);
        this.metaDAO = new MetaDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do plano não fornecido");
            return;
        }

        try {
            int planoId = Integer.parseInt(idParam);
            PlanoAEE plano = planoAEEDAO.buscarPorId(planoId);

            if (plano == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Plano não encontrado");
                return;
            }

            // Buscar proposta e metas associadas ao plano
            PropostaPedagogica proposta = propostaDAO.buscarPorPlanoId(planoId);
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(planoId);

            plano.setProposta(proposta);
            plano.setMetas(metas);

            request.setAttribute("plano", plano);

            // Mensagens de sucesso ou erro, se houver
            if (request.getParameter("success") != null) {
                request.setAttribute("success", request.getParameter("success"));
            }
            if (request.getParameter("erro") != null) {
                request.setAttribute("erro", request.getParameter("erro"));
            }

            request.getRequestDispatcher("/templates/aee/DetalhesPlanoAEE.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException e) {
            logger.log(Level.SEVERE, "Erro ao carregar detalhes do plano", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
        }
    }
}