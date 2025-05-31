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
        urlPatterns = {"/templates/aee/detalhes-plano", "/templates/aee/editarPlanoAEE"})
public class DetalhesPlanoAEEServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(DetalhesPlanoAEEServlet.class.getName());

    private PlanoAEEDAO planoAEEDAO;
    private AlunoDAO alunoDAO;
    private ProfessorAEEDAO professorAEEDAO;
    private PropostaPedagogicaDAO propostaDAO;
    private MetaDAO metaDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.planoAEEDAO = new PlanoAEEDAO(conn);
        this.alunoDAO = new AlunoDAO(conn);
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
        this.propostaDAO = new PropostaPedagogicaDAO(conn);
        this.metaDAO = new MetaDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/templates/aee/editarPlanoAEE".equals(path)) {
            carregarPaginaEdicao(request, response);
        } else if ("/templates/aee/detalhes-plano".equals(path)) {
            // Código existente para detalhes do plano
            String idParam = request.getParameter("id");
            System.out.println(idParam);
            if (idParam == null || idParam.isEmpty()) {
                System.out.println(idParam + "IF");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do plano não fornecido");
                return;
            }

            try {
                int planoId = Integer.parseInt(idParam);
                // Busca o plano principal
                PlanoAEE plano = planoAEEDAO.buscarPorId(planoId);

                if (plano == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Plano não encontrado");
                    return;
                }

                // Busca informações complementares
                Aluno aluno = alunoDAO.buscarPorMatricula(plano.getAlunoMatricula());
                ProfessorAEE professor = professorAEEDAO.getBySiape(plano.getProfessorSiape());
                PropostaPedagogica proposta = propostaDAO.buscarPorPlanoId(planoId);
                List<Meta> metas = metaDAO.buscarMetasPorPlanoId(planoId);

                // Atribui as relações ao plano
                plano.setProposta(proposta);
                plano.setMetas(metas);

                // Adiciona atributos para a JSP
                request.setAttribute("plano", plano);
                request.setAttribute("aluno", aluno);
                request.setAttribute("professor", professor);

                // Mensagens de feedback
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
                    response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + planoId + "&erro=Falha+ao+excluir+plano");
                }
            } catch (SQLException | NumberFormatException e) {
                logger.log(Level.SEVERE, "Erro ao excluir plano", e);
                String idParam = request.getParameter("planoId");
                response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-plano?id=" + idParam + "&erro=Erro+ao+excluir+plano");
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
            // Se não for ação de exclusão, chama o doGet
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
            AlunoDAO alunoDAO = new AlunoDAO(conn);
            Aluno aluno = alunoDAO.buscarPorMatricula(plano.getAlunoMatricula());

            // Buscar todos os professores para o dropdown
            ProfessorAEEDAO professorDAO = new ProfessorAEEDAO(conn);
            List<ProfessorAEE> professores = professorDAO.getAll();

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