package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.AvaliacaoDAO;
import org.incluemais.model.entities.Avaliacao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AvaliacaoServlet", urlPatterns = {
        "/avaliacao"
})
public class AvaliacaoServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AvaliacaoServlet.class.getName()); // Declaração correta do logger
    private AvaliacaoDAO avaliacaoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        if (conn == null) {
            throw new ServletException("Conexão não disponível");
        }
        this.avaliacaoDAO = new AvaliacaoDAO(conn);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");
        int relatorioId = 0;

        try {
            relatorioId = Integer.parseInt(request.getParameter("relatorioId"));
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "ID do relatório inválido", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do relatório inválido");
            return;
        }

        try {
            if ("criar".equals(acao)) {
                criarAvaliacao(request, response, relatorioId);
            } else if ("editar".equals(acao)) {
                atualizarAvaliacao(request, response, relatorioId);
            } else if ("excluir".equals(acao)) {
                excluirAvaliacao(request, response, relatorioId);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida");
            }
        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro no processamento", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro no servidor");
        }
    }

    private void criarAvaliacao(HttpServletRequest request, HttpServletResponse response, int relatorioId)
            throws SQLException, IOException {

        Avaliacao avaliacao = new Avaliacao(
                request.getParameter("area"),
                request.getParameter("desempenhoVerificado"),
                request.getParameter("observacoes")
        );

        if (avaliacaoDAO.inserir(avaliacao, relatorioId)) {
            response.sendRedirect(request.getContextPath() + "/relatorios/detalhes?id=" + relatorioId);
        } else {
            logger.log(Level.WARNING, "Falha ao criar avaliação para relatório ID: " + relatorioId);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Falha ao criar avaliação");
        }
    }

    private void atualizarAvaliacao(HttpServletRequest request, HttpServletResponse response, int relatorioId)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Avaliacao avaliacao = new Avaliacao(
                request.getParameter("area"),
                request.getParameter("desempenhoVerificado"),
                request.getParameter("observacoes")
        );
        avaliacao.setId(id);

        if (avaliacaoDAO.atualizar(avaliacao)) {
            response.sendRedirect(request.getContextPath() + "/relatorios/detalhes?id=" + relatorioId);
        } else {
            logger.log(Level.WARNING, "Falha ao atualizar avaliação ID: " + id);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Falha ao atualizar avaliação");
        }
    }

    private void excluirAvaliacao(HttpServletRequest request, HttpServletResponse response, int relatorioId)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        if (avaliacaoDAO.excluir(id)) {
            response.sendRedirect(request.getContextPath() + "/relatorios/detalhes?id=" + relatorioId);
        } else {
            logger.log(Level.WARNING, "Falha ao excluir avaliação ID: " + id);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Falha ao excluir avaliação");
        }
    }

    // Adicione este método se precisar lidar com requisições GET (para edição)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");

        if ("editar".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                Avaliacao avaliacao = avaliacaoDAO.buscarPorId(id);
                request.setAttribute("avaliacao", avaliacao);
                request.setAttribute("acao", "editar");
                request.getRequestDispatcher("/templates/aee/CriarAvaliacao.jsp").forward(request, response);
            } catch (SQLException e) {
                logger.log(Level.SEVERE, "Erro ao buscar avaliação", e);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else if ("criar".equals(acao)) {
            request.setAttribute("acao", "criar");
            request.getRequestDispatcher("/templates/aee/CriarAvaliacao.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida");
        }
    }
}