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
            // Código de listagem
            try (Connection conn = getConnection()) {
                PlanoAEEDAO planoDAO = new PlanoAEEDAO(conn);
                List<Map<String, Object>> planos = planoDAO.listarTodosComNomes();

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
            Connection conn = null;
            try {
                conn = getConnection();
                PlanoAEEDAO planoDAO = new PlanoAEEDAO(conn);

                String idParam = request.getParameter("planoId");
                if (idParam == null || idParam.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do plano não fornecido");
                    return;
                }

                int planoId = Integer.parseInt(idParam);
                boolean excluido = planoDAO.excluir(planoId);

                if (excluido) {
                    response.sendRedirect(request.getContextPath() + "/templates/aee/planosAEE");
                } else {
                    response.sendRedirect(request.getContextPath() + "/templates/aee/planosAEE?erro=Falha+ao+excluir+plano");
                }
            } catch (SQLException | NumberFormatException e) {
                logger.log(Level.SEVERE, "Erro ao excluir plano", e);
                response.sendRedirect(request.getContextPath() + "/templates/aee/planosAEE?erro=Erro+ao+excluir+plano");
            } finally {
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        logger.warning("Erro ao fechar conexão");
                    }
                }
            }
        } else {
            doGet(request, response);
        }
    }

    protected void carregarPaginaEdicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection conn = null;
        try {
            conn = getConnection();
            String idParam = request.getParameter("id");

            if (idParam == null || idParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do plano não fornecido");
                return;
            }

            int planoId = Integer.parseInt(idParam);

            // Buscar o plano
            PlanoAEEDAO planoDAO = new PlanoAEEDAO(conn);
            PlanoAEE plano = planoDAO.buscarPorId(planoId);

            if (plano == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Plano não encontrado");
                return;
            }

            // Buscar aluno associado
            Aluno aluno = alunoDAO.buscarPorMatricula(plano.getAlunoMatricula());

            // Buscar todos os professores para o dropdown
            List<ProfessorAEE> professores = professorAEEDAO.getAll();

            // Adicionar atributos à requisição
            request.setAttribute("plano", plano);
            request.setAttribute("aluno", aluno);
            request.setAttribute("professores", professores);

            // Encaminhar para a página de edição
            request.getRequestDispatcher("/templates/aee/EditarPlanoAEE.jsp").forward(request, response);

        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao carregar página de edição", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    logger.warning("Erro ao fechar conexão");
                }
            }
        }
    }
}