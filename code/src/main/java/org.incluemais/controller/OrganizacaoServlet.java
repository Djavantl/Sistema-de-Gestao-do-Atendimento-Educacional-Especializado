package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.OrganizacaoAtendimentoDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.OrganizacaoAtendimento;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "OrganizacaoServlet", urlPatterns = {"/templates/aee/organizacao", "/templates/aee/organizacao/*"})
public class OrganizacaoServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(SessaoServlet.class.getName());
    private OrganizacaoAtendimentoDAO organizacaoDAO;
    private AlunoDAO alunoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");

        if(conn == null) {
            logger.severe(" Conexão não encontrada!");
            throw new ServletException("Banco de dados não disponível");
        }
        this.alunoDAO = new AlunoDAO(conn);
        this.organizacaoDAO = new OrganizacaoAtendimentoDAO(conn);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        String matricula = request.getParameter("alunoM");

        try {

            if ("editar".equals(acao)) {
                try (Connection conn = DBConnection.getConnection()) {
                    OrganizacaoAtendimentoDAO dao = new OrganizacaoAtendimentoDAO(conn);
                    int orgId = dao.buscarIdPorMatricula(matricula);
                    OrganizacaoAtendimento org = dao.buscarPorAlunoMatricula(matricula);
                    org.setId(orgId);
                    if (org != null) {
                        Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
                        request.setAttribute("aluno", aluno);
                        request.setAttribute("organizacao", org);
                        request.getRequestDispatcher("/templates/aee/EditarOrganizacao.jsp").forward(request, response);
                    } else {
                        System.out.println("nao editou");
                    }
                }
            }

            else {
                request.getRequestDispatcher("/templates/aee/NovaOrganizacao.jsp").forward(request, response);
            }

        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro no processamento GET", e);
            response.sendRedirect(request.getContextPath() + "/templates/aee/alunos?erro=Erro+no+servidor");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("acao");

        if (action == null || action.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação não especificada.");
            return;
        }

        try {
            switch (action) {
                case "criar":
                    criarOrganizacao(request, response);
                    break;
                case "excluir":
                    excluirOrganizacao(request, response);
                    break;
                case "atualizar":
                    atualizarOrganizacao(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida.");
                    break;
            }
        } catch (Exception e) {
            logger.severe("Erro ao processar a requisição: " + e.getMessage());
            request.setAttribute("erro", "Erro ao processar a solicitação: " + e.getMessage());
            request.getRequestDispatcher("/templates/aee/NovaOrganizacao.jsp").forward(request, response);
        }
    }


    private void criarOrganizacao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String matricula = request.getParameter("matricula");


        try {
            Aluno alunoM = alunoDAO.buscarPorMatricula(matricula);

            if (alunoM == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }

            Aluno alunoID = alunoDAO.buscarPorId(id);

            if (alunoID == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }

            OrganizacaoAtendimento org = new OrganizacaoAtendimento(
                    alunoM,
                    request.getParameter("periodo"),
                    request.getParameter("duracao"),
                    request.getParameter("frequencia"),
                    request.getParameter("composicao"),
                    request.getParameter("tipo")

            );

            int idOrganizacao = organizacaoDAO.insert(org);

            if (idOrganizacao > 0) {
                response.sendRedirect(
                        request.getContextPath() +
                                "/templates/aee/detalhes-aluno?id=" + id +
                                "&sucesso=Organização criada com sucesso"
                );
            } else {
                throw new SQLException("Falha ao inserir no banco");
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro de banco de dados", e);
            request.setAttribute("erro", "Erro ao criar organização: " + e.getMessage());
            request.getRequestDispatcher("/templates/aee/NovaOrganizacao.jsp").forward(request, response);
        }
    }

    private void excluirOrganizacao(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        String matricula = request.getParameter("alunoM");
        int alunoId = Integer.parseInt(request.getParameter("alunoId"));
        System.out.println(matricula);
        System.out.println(alunoId);
        int idOrg = organizacaoDAO.buscarIdPorMatricula(matricula);


        try {
            organizacaoDAO.delete(idOrg);

            response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-aluno?id=" + alunoId + "&sucesso=Organização+excluída+com+sucesso");

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao excluir organização", e);
            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/detalhes-aluno?id=" + alunoId +
                    "&erro=Erro+ao+excluir+organização");
        }
    }


    private void atualizarOrganizacao(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String matricula = request.getParameter("alunoM");
            int alunoId = Integer.parseInt(request.getParameter("alunoId"));
            int id = organizacaoDAO.buscarIdPorMatricula(matricula);
            System.out.println(matricula);
            System.out.println(alunoId);

            OrganizacaoAtendimento org = new OrganizacaoAtendimento(
                    alunoDAO.buscarPorMatricula(matricula),
                    request.getParameter("periodo"),
                    request.getParameter("duracao"),
                    request.getParameter("frequencia"),
                    request.getParameter("composicao"),
                    request.getParameter("tipo")
            );
            org.setId(id);

            organizacaoDAO.update(org);

            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/detalhes-aluno?id=" + alunoId +
                    "&sucesso=Organização+atualizada+com+sucesso");

        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao atualizar organização", e);
            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/detalhes-aluno?id=" + request.getParameter("alunoId") +
                    "&erro=Erro+ao+atualizar+organização");
        }
    }
}
