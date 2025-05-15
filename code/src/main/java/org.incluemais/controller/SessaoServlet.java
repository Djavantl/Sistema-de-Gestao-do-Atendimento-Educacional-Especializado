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
                listarSessoes(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro de banco de dados", e);
        }
    }

    private void criarSessao(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Entrou no metodo");
        String nomeAluno = request.getParameter("aluno");
        LocalDate data = LocalDate.parse(request.getParameter("data"));
        LocalTime horario = LocalTime.parse(request.getParameter("horario"));
        String local = request.getParameter("local");

        List<Aluno> alunos = alunoDAO.buscarPorNome(nomeAluno);

        if (alunos.isEmpty()) {
            request.setAttribute("erro", "Aluno não encontrado: " + nomeAluno);
            request.getRequestDispatcher("/templates/aee/PorSessao.jsp").forward(request, response);
            return;
        }

        if (alunos.size() > 1) {
            request.setAttribute("alunos", alunos);
            request.setAttribute("data", data.toString());
            request.setAttribute("horario", horario.toString());
            request.setAttribute("local", local);
            request.getRequestDispatcher("/templates/aee/PorSessao.jsp").forward(request, response);
            return;
        }


        Aluno aluno = alunos.get(0);
        System.out.println(nomeAluno);
        System.out.println(data);
        System.out.println(horario);
        System.out.println(local);
        SessaoAtendimento sessao = new SessaoAtendimento(aluno, data, horario, local);

        try{
            sessaoDAO.inserir(sessao);
        } catch (SQLException e){
            System.out.println(e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/templates/aee/sessoes?sucesso=Sessão+criada+com+sucesso");
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

        List<SessaoAtendimento> sessoes = sessaoDAO.listarTodos();
        request.setAttribute("sessoeslista", sessoes);
        request.getRequestDispatcher("/templates/aee/PorSessao.jsp").forward(request, response);
    }

    private void exibirFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        SessaoAtendimento sessao = sessaoDAO.buscarPorId(id);

        if (sessao != null) {
            request.setAttribute("sessao", sessao);
            request.getRequestDispatcher("/templates/aee/PorSessao.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sessão não encontrada");
        }
    }

    private void atualizarSessao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        LocalDate data = LocalDate.parse(request.getParameter("data"));
        LocalTime horario = LocalTime.parse(request.getParameter("horario"));
        String local = request.getParameter("local");
        boolean presenca = Boolean.parseBoolean(request.getParameter("presenca"));
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