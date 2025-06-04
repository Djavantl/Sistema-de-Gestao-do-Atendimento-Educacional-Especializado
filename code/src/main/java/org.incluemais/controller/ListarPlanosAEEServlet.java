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
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import static org.incluemais.model.connection.DBConnection.getConnection;

@WebServlet(name = "ListaPlanosAEEServlet", urlPatterns = {"/templates/aee/planosAEE", "/templates/aee/editarPlanoAEE"})
public class ListarPlanosAEEServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(ListarPlanosAEEServlet.class.getName());

    private PlanoAEEDAO planoAEEDAO;
    private AlunoDAO alunoDAO;
    private ProfessorAEEDAO professorAEEDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.planoAEEDAO = new PlanoAEEDAO(conn);
        this.alunoDAO = new AlunoDAO(conn);
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if ("/templates/aee/planosAEE".equals(path)) {
            try {
                List<Map<String, Object>> planos = planoAEEDAO.listarTodosComNomes();
                request.setAttribute("planosLista", planos);
                request.getRequestDispatcher("/templates/aee/PlanosAEE.jsp").forward(request, response);
            } catch (SQLException e) {
                logger.log(Level.SEVERE, "Erro ao listar planos", e);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
            }
        } else if ("/templates/aee/editarPlanoAEE".equals(path)) {
            carregarPaginaEdicao(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("excluirPlano".equals(action)) {
            String idParam = request.getParameter("planoId");
            if (idParam == null || idParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do plano não fornecido");
                return;
            }
            try {
                int planoId = Integer.parseInt(idParam);
                boolean excluido = planoAEEDAO.excluir(planoId);
                if (excluido) {
                    response.sendRedirect(request.getContextPath() + "/templates/aee/planosAEE");
                } else {
                    response.sendRedirect(request.getContextPath() + "/templates/aee/planosAEE?erro=Falha+ao+excluir+plano");
                }
            } catch (SQLException | NumberFormatException e) {
                logger.log(Level.SEVERE, "Erro ao excluir plano", e);
                response.sendRedirect(request.getContextPath() + "/templates/aee/planosAEE?erro=Erro+ao+excluir+plano");
            }
        } else {
            doGet(request, response);
        }
    }

    private void carregarPaginaEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("AAAAAAAAAAA");
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            System.out.println("Parametro nao fornecido");
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

            System.out.println("pano id" + planoId);
            System.out.println("plano professor aee" + plano.getProfessorAEE().getNome());
            List<ProfessorAEE> professores = professorAEEDAO.getAll();
            request.setAttribute("plano", plano);
            request.setAttribute("aluno", plano.getAluno());
            request.setAttribute("professores", professores);
            System.out.println();
            request.getRequestDispatcher("/templates/aee/EditarPlanoAEE.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao carregar página de edição", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
        }
    }
}