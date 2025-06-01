package org.incluemais.controller;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.SessaoAtendimento;
import org.incluemais.model.dao.SessaoAtendimentoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeParseException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet(name = "SessaoServlet", urlPatterns = {"/templates/aee/sessoes", "/templates/aee/sessoes/*"})
public class SessaoServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(SessaoServlet.class.getName());
    private AlunoDAO alunoDAO;
    private SessaoAtendimentoDAO sessaoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");

        if(conn == null) {
            logger.severe(" Conexão não encontrada!");
            throw new ServletException("Banco de dados não disponível");
        }

        this.alunoDAO = new AlunoDAO(conn);
        this.sessaoDAO = new SessaoAtendimentoDAO(conn);
        logger.info("🔄 Servlet inicializado com sucesso");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String matriculaAluno = request.getParameter("matriculaAluno");

            if (matriculaAluno != null && !matriculaAluno.isEmpty()) {
                List<SessaoAtendimento> sessoesPorAluno = sessaoDAO.buscarPorAluno(matriculaAluno);
                request.setAttribute("sessoesPorAluno", sessoesPorAluno);
            }
            listarSessoes(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro de banco de dados", e);
        }
    }

    private void criarSessao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        // Corrigido: obter matrícula em vez de nome
        String matricula = request.getParameter("aluno_matricula");
        LocalDate data = LocalDate.parse(request.getParameter("data"));
        LocalTime horario = LocalTime.parse(request.getParameter("horario"));
        String local = request.getParameter("local");

        // Buscar aluno por matrícula em vez de nome
        Aluno aluno = alunoDAO.buscarPorMatricula(matricula);

        if (aluno == null) {
            request.setAttribute("erro", "Aluno não encontrado com matrícula: " + matricula);
            listarSessoes(request, response);
            return;
        }

        SessaoAtendimento sessao = new SessaoAtendimento(aluno, data, horario, local);

        try {
            sessaoDAO.inserir(sessao);
            response.sendRedirect(request.getContextPath() + "/templates/aee/sessoes?sucesso=Sessão+criada+com+sucesso");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao criar sessão: " + e.getMessage());
            listarSessoes(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("acao");
        System.out.println(action);
        try {
            if (action != null) {
                switch (action) {
                    case "criar" -> criarSessao(request, response);
                    case "atualizar" -> atualizarSessao(request, response);
                    case "excluir" -> excluirSessao(request, response);
                    default -> response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida");
                }
            }
        } catch (SQLException | DateTimeParseException e) {
            throw new ServletException("Erro de processamento", e);
        }
    }

    private void listarSessoes(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        try {
            List<SessaoAtendimento> sessoes = sessaoDAO.listarTodos();
            System.out.println("Total de sessões encontradas: " + sessoes.size());

            for (SessaoAtendimento sessao : sessoes) {
                System.out.println("Sessão ID: " + sessao.getId()
                        + " | Aluno: " + sessao.getAluno().getNome()
                        + " | Presença: " + sessao.isPresenca());
            }

            request.setAttribute("sessoeslista", sessoes);

            LocalDate hoje = LocalDate.now();
            request.setAttribute("hoje", hoje);

            List<Aluno> todosAlunos = alunoDAO.buscarTodos();
            System.out.println("Total de alunos encontrados: " + todosAlunos.size());
            request.setAttribute("todosAlunos", todosAlunos);

        } catch (Exception e) {
            System.err.println("ERRO GRAVE ao carregar sessões:");
            e.printStackTrace();
            request.setAttribute("erro", "Falha ao carregar dados: " + e.getMessage());
        }

        request.getRequestDispatcher("/templates/aee/PorSessao.jsp").forward(request, response);
    }

    private void atualizarSessao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        LocalDate data = LocalDate.parse(request.getParameter("data"));
        LocalTime horario = LocalTime.parse(request.getParameter("horario"));
        String local = request.getParameter("local");

        String presencaParam = request.getParameter("presenca");
        Boolean presenca = null;

        if (presencaParam != null && !presencaParam.isEmpty()) {
            presenca = Boolean.parseBoolean(presencaParam);
        }

        String observacoes = request.getParameter("observacoes");

        SessaoAtendimento sessao = sessaoDAO.buscarPorId(id);
        sessao.setData(data);
        sessao.setHorario(horario);
        sessao.setLocal(local);
        sessao.setPresenca(presenca);
        sessao.setObservacoes(observacoes);

        sessaoDAO.atualizar(sessao);
        response.sendRedirect(request.getContextPath() + "/templates/aee/sessoes?sucesso=Sessão+atualizada+com+sucesso");
    }

    private void excluirSessao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        System.out.println("entrou em excluir");
        int id = Integer.parseInt(request.getParameter("id"));
        sessaoDAO.deletar(id);
        response.sendRedirect(request.getContextPath() + "/templates/aee/sessoes?sucesso=Sessão+excluída+com+sucesso");
    }


}