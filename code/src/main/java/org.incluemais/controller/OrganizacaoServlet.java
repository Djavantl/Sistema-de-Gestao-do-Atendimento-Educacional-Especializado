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

    // Logger apontando para esta classe
    private static final Logger logger = Logger.getLogger(OrganizacaoServlet.class.getName());

    // DAOs para acesso a Aluno e Organização de Atendimento
    private OrganizacaoAtendimentoDAO organizacaoDAO;
    private AlunoDAO alunoDAO;

    @Override
    public void init() throws ServletException {
        // Tenta obter a conexão armazenada como atributo no ServletContext
        Connection conn = (Connection) getServletContext().getAttribute("conexao");

        if (conn == null) {
            logger.severe("Conexão não encontrada no contexto!");
            throw new ServletException("Banco de dados não disponível");
        }
        // Inicializa DAOs com a conexão compartilhada
        this.alunoDAO = new AlunoDAO(conn);
        this.organizacaoDAO = new OrganizacaoAtendimentoDAO(conn);
    }

    /**
     * Trata requisições GET para exibir formulários de criação ou edição de Organização de Atendimento.
     * Parâmetros esperados:
     * - acao=editar e alunoM=<matrícula>: carrega dados para edição.
     * - caso contrário: encaminha para formulário de nova Organização.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        String matricula = request.getParameter("alunoM");

        try {
            if ("editar".equals(acao) && matricula != null && !matricula.isBlank()) {
                // Para edição, busca conexão nova para consistência
                try (Connection conn = DBConnection.getConnection()) {
                    OrganizacaoAtendimentoDAO daoTemp = new OrganizacaoAtendimentoDAO(conn);

                    // Busca o ID e entidade de Organização pelo parâmetro matrícula
                    int orgId = daoTemp.buscarIdPorMatricula(matricula);
                    OrganizacaoAtendimento org = daoTemp.buscarPorAlunoMatricula(matricula);

                    if (org != null) {
                        org.setId(orgId);
                        // Busca dados do Aluno para exibir junto no formulário
                        Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
                        request.setAttribute("aluno", aluno);
                        request.setAttribute("organizacao", org);
                        // Encaminha para JSP de edição
                        request.getRequestDispatcher("/templates/aee/EditarOrganizacao.jsp")
                                .forward(request, response);
                    } else {
                        // Caso não encontre a organização, loga para investigação
                        logger.warning("Organização não encontrada para matrícula: " + matricula);
                        // Poderia redirecionar ou exibir mensagem, mas como não mudar funcionalidade,
                        // apenas imprime no console aqui.
                        System.out.println("Não foi possível carregar para edição: organização não encontrada.");
                        // Redireciona para formulário de nova organização
                        response.sendRedirect(request.getContextPath() + "/templates/aee/organizacao");
                    }
                }
            } else {
                // Sem ação "editar" ou matrícula inválida: encaminha para formulário de nova Organização
                request.getRequestDispatcher("/templates/aee/NovaOrganizacao.jsp")
                        .forward(request, response);
            }
        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro no processamento GET de OrganizacaoServlet", e);
            // Em caso de erro, redireciona para lista de alunos com parâmetro de erro
            response.sendRedirect(
                    request.getContextPath() + "/templates/aee/alunos?erro=Erro+no+servidor"
            );
        }
    }

    /**
     * Trata requisições POST para criar, atualizar ou excluir Organização de Atendimento.
     * Parâmetro obrigatório: acao={criar, atualizar, excluir}
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Garante codificação UTF-8 para parâmetros de formulário
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
            // Trata exceções genéricas, logando e exibindo mensagem no formulário de nova organização
            logger.log(Level.SEVERE, "Erro ao processar a requisição POST de OrganizacaoServlet", e);
            request.setAttribute("erro", "Erro ao processar a solicitação: " + e.getMessage());
            request.getRequestDispatcher("/templates/aee/NovaOrganizacao.jsp")
                    .forward(request, response);
        }
    }

    /**
     * Cria uma nova Organização de Atendimento para um aluno existente.
     * Parâmetros esperados:
     * - id: ID do aluno (inteiro)
     * - matricula: matrícula do aluno (String)
     * - demais campos do formulário: periodo, duracao, frequencia, composicao, tipo
     */
    private void criarOrganizacao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String matricula = request.getParameter("matricula");

            // Verifica existência do aluno pela matrícula
            Aluno alunoM = alunoDAO.buscarPorMatricula(matricula);
            if (alunoM == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado pela matrícula");
                return;
            }
            // Verifica existência do aluno por ID (redundante, mas mantido conforme lógica original)
            Aluno alunoID = alunoDAO.buscarPorId(id);
            if (alunoID == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado pelo ID");
                return;
            }

            // Cria objeto OrganizacaoAtendimento a partir dos parâmetros do formulário
            OrganizacaoAtendimento org = new OrganizacaoAtendimento(
                    alunoM,
                    request.getParameter("periodo"),
                    request.getParameter("duracao"),
                    request.getParameter("frequencia"),
                    request.getParameter("composicao"),
                    request.getParameter("tipo")
            );

            // Insere no banco
            int idOrganizacao = organizacaoDAO.insert(org);
            if (idOrganizacao > 0) {
                // Sucesso: redireciona para detalhes do aluno com mensagem de sucesso
                response.sendRedirect(
                        request.getContextPath() +
                                "/templates/aee/detalhes-aluno?id=" + id +
                                "&sucesso=Organiza%C3%A7%C3%A3o+criada+com+sucesso"
                );
            } else {
                throw new SQLException("Falha ao inserir organização no banco");
            }
        } catch (NumberFormatException e) {
            // Parâmetro ID inválido
            logger.log(Level.SEVERE, "ID de aluno inválido ao criar organização", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de aluno inválido.");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro de banco de dados ao criar organização", e);
            request.setAttribute("erro", "Erro ao criar organização: " + e.getMessage());
            request.getRequestDispatcher("/templates/aee/NovaOrganizacao.jsp")
                    .forward(request, response);
        }
    }

    /**
     * Exclui uma Organização de Atendimento associada a um aluno.
     * Parâmetros esperados:
     * - alunoM: matrícula do aluno
     * - alunoId: ID do aluno (inteiro) para redirecionamento após exclusão
     */
    private void excluirOrganizacao(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String matricula = request.getParameter("alunoM");
        int alunoId;
        try {
            alunoId = Integer.parseInt(request.getParameter("alunoId"));
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "ID de aluno inválido ao excluir organização", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de aluno inválido.");
            return;
        }

        try {
            // Busca ID da organização pela matrícula
            int idOrg = organizacaoDAO.buscarIdPorMatricula(matricula);
            // Exclui no banco
            organizacaoDAO.delete(idOrg);
            // Redireciona para detalhes do aluno com mensagem de sucesso
            response.sendRedirect(
                    request.getContextPath() +
                            "/templates/aee/detalhes-aluno?id=" + alunoId +
                            "&sucesso=Organiza%C3%A7%C3%A3o+exclu%C3%ADda+com+sucesso"
            );
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao excluir organização", e);
            // Redireciona para detalhes com parâmetro de erro
            response.sendRedirect(
                    request.getContextPath() +
                            "/templates/aee/detalhes-aluno?id=" + alunoId +
                            "&erro=Erro+ao+excluir+organiza%C3%A7%C3%A3o"
            );
        }
    }

    /**
     * Atualiza os dados de uma Organização de Atendimento existente.
     * Parâmetros esperados:
     * - alunoM: matrícula do aluno
     * - alunoId: ID do aluno (inteiro) para redirecionamento após atualização
     * - demais campos do formulário: periodo, duracao, frequencia, composicao, tipo
     */
    private void atualizarOrganizacao(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String matricula = request.getParameter("alunoM");
            int alunoId = Integer.parseInt(request.getParameter("alunoId"));

            // Busca ID existente da organização pela matrícula
            int idOrg = organizacaoDAO.buscarIdPorMatricula(matricula);

            // Cria objeto OrganizacaoAtendimento com novos dados
            OrganizacaoAtendimento org = new OrganizacaoAtendimento(
                    alunoDAO.buscarPorMatricula(matricula),
                    request.getParameter("periodo"),
                    request.getParameter("duracao"),
                    request.getParameter("frequencia"),
                    request.getParameter("composicao"),
                    request.getParameter("tipo")
            );
            org.setId(idOrg);

            // Atualiza no banco
            organizacaoDAO.update(org);

            // Redireciona para detalhes do aluno com mensagem de sucesso
            response.sendRedirect(
                    request.getContextPath() +
                            "/templates/aee/detalhes-aluno?id=" + alunoId +
                            "&sucesso=Organiza%C3%A7%C3%A3o+atualizada+com+sucesso"
            );
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "ID de aluno inválido ao atualizar organização", e);
            response.sendRedirect(
                    request.getContextPath() +
                            "/templates/aee/detalhes-aluno?id=" + request.getParameter("alunoId") +
                            "&erro=ID+de+aluno+inv%C3%A1lido"
            );
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao atualizar organização", e);
            response.sendRedirect(
                    request.getContextPath() +
                            "/templates/aee/detalhes-aluno?id=" + request.getParameter("alunoId") +
                            "&erro=Erro+ao+atualizar+organiza%C3%A7%C3%A3o"
            );
        }
    }
}
