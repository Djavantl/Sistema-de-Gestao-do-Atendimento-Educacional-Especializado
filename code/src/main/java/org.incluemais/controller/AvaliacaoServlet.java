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

@WebServlet(name = "AvaliacaoServlet", urlPatterns = {"/avaliacao"})
public class AvaliacaoServlet extends HttpServlet {
    private AvaliacaoDAO avaliacaoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.avaliacaoDAO = new AvaliacaoDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String relatorioIdParam = request.getParameter("relatorioId");
        int relatorioId = Integer.parseInt(relatorioIdParam);

        if ("editar".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Avaliacao avaliacao = null;
            try {
                avaliacao = avaliacaoDAO.buscarPorId(id);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
            request.setAttribute("avaliacao", avaliacao);
            request.setAttribute("acao", "editar");
        } else if ("criar".equals(acao)) {
            request.setAttribute("acao", "criar");
        }
        // repassa relatorioId para o JSP
        request.setAttribute("relatorioId", relatorioId);
        request.getRequestDispatcher("/templates/aee/Avaliacao.jsp")
                .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String acao = request.getParameter("acao");
        String relatorioIdParam = request.getParameter("relatorioId");

        if (relatorioIdParam == null || relatorioIdParam.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "relatorioId não foi enviado no formulário.");
            return;
        }

        int relatorioId;
        try {
            relatorioId = Integer.parseInt(relatorioIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "relatorioId inválido: " + relatorioIdParam);
            return;
        }

        System.out.println(">> AvaliacaoServlet.doPost: ação=" + acao + ", relatorioId=" + relatorioId);

        try {
            if ("criar".equals(acao)) {
                criarAvaliacao(request, response, relatorioId);
            } else if ("editar".equals(acao)) {
                atualizarAvaliacao(request, response, relatorioId);
            } else if ("excluir".equals(acao)) {
                excluirAvaliacao(request, response, relatorioId);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação desconhecida: " + acao);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro no banco de dados: " + e.getMessage());
        }
    }


    private void criarAvaliacao(HttpServletRequest request, HttpServletResponse response, int relatorioId)
            throws SQLException, IOException {

        String area = request.getParameter("area");
        String desempenho = request.getParameter("desempenhoVerificado");
        String observacoes = request.getParameter("observacoes");

        // Validação básica de campos obrigatórios
        if (area == null || area.isBlank() || desempenho == null || desempenho.isBlank()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Área e Desempenho Verificado são obrigatórios");
            return;
        }

        // (Opcional) Verificar se o relatório existe antes de inserir
        if (!avaliacaoDAO.relatorioExiste(relatorioId)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Não existe relatório com id=" + relatorioId);
            return;
        }

        System.out.println(">> criarAvaliacao: area=" + area
                + ", desempenho=" + desempenho
                + ", observacoes=" + observacoes
                + ", relatorioId=" + relatorioId);

        Avaliacao avaliacao = new Avaliacao(area, desempenho, observacoes);
        boolean ok = avaliacaoDAO.inserir(avaliacao, relatorioId);

        if (ok) {
            response.sendRedirect(request.getContextPath() + "/relatorios/detalhes?id=" + relatorioId);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Não foi possível inserir a avaliação.");
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
        }
    }

    private void excluirAvaliacao(HttpServletRequest request, HttpServletResponse response, int relatorioId)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        if (avaliacaoDAO.excluir(id)) {
            response.sendRedirect(request.getContextPath() + "/relatorios/detalhes?id=" + relatorioId);
        }
    }
}