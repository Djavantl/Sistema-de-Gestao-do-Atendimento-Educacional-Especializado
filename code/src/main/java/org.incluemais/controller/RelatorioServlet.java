package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.RelatorioDAO;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.ProfessorAEEDAO;
import org.incluemais.model.entities.Relatorio;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.ProfessorAEE;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "RelatorioServlet", urlPatterns = {
        "/relatorios",
        "/relatorios/novo",
        "/relatorios/editar",
        "/relatorios/detalhes",
        "/relatorios/criar",
        "/relatorios/atualizar",
        "/relatorios/excluir"
})

public class RelatorioServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(RelatorioServlet.class.getName());
    private RelatorioDAO relatorioDAO;
    private AlunoDAO alunoDAO;
    private ProfessorAEEDAO professorAEEDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        if (conn == null) {
            logger.severe("Conexão não encontrada!");
            throw new ServletException("Banco de dados não disponível");
        }
        this.relatorioDAO = new RelatorioDAO(conn);
        this.alunoDAO = new AlunoDAO(conn);
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("acao");
            String pathInfo = request.getPathInfo();

            // Novo caso para criação de relatório com alunoMatricula
            if (pathInfo != null && pathInfo.startsWith("/novo")) {
                String alunoMatricula = request.getParameter("alunoMatricula");
                if (alunoMatricula != null && !alunoMatricula.isEmpty()) {
                    exibirFormularioCriacaoComAluno(alunoMatricula, request, response);
                    return;
                }
            }

            // Ações padrão via parâmetro acao
            if (request.getServletPath().equals("/relatorios/novo")) {
                exibirFormularioCriacao(request, response);
            }
            else if (request.getServletPath().equals("/relatorios/editar")) {
                int id = Integer.parseInt(request.getParameter("id"));
                exibirFormularioEdicao(id, request, response);
            }
            else if (request.getServletPath().equals("/relatorios/detalhes")) {
                int id = Integer.parseInt(request.getParameter("id"));
                exibirDetalhesRelatorio(id, request, response);
            }

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro de banco de dados", e);
            encaminharErro(request, response, "Erro ao acessar dados");
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro de formato numérico", e);
            encaminharErro(request, response, "ID inválido");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("acao");

        try {
            if (request.getServletPath().equals("/relatorios/criar")) {
                criarRelatorio(request, response);
            }
            else if (request.getServletPath().equals("/relatorios/atualizar")) {
                atualizarRelatorio(request, response);
            }
            else if (request.getServletPath().equals("/relatorios/excluir")) {
                excluirRelatorio(request, response);
            }
        } catch (SQLException | DateTimeParseException e) {
            logger.log(Level.SEVERE, "Erro no processamento", e);
            encaminharErro(request, response, "Erro no processamento dos dados");
        }
    }

    private void exibirFormularioCriacaoComAluno(String alunoMatricula, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Aluno aluno = alunoDAO.buscarPorMatricula(alunoMatricula);
        List<ProfessorAEE> professores = professorAEEDAO.getAll();

        if (aluno != null) {
            request.setAttribute("aluno", aluno);
            request.setAttribute("alunoMatricula", alunoMatricula); // Passar matrícula para o JSP
            request.setAttribute("professores", professores);
            request.getRequestDispatcher("/templates/aee/NovoRelatorio.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
        }
    }

    private void criarRelatorio(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        Map<String, String> erros = validarCampos(request);

        if (!erros.isEmpty()) {
            request.setAttribute("erros", erros);
            request.setAttribute("relatorio", extrairDadosFormulario(request));
            exibirFormularioCriacao(request, response);
            return;
        }

        try {
            String alunoMatricula = request.getParameter("alunoMatricula");
            Aluno aluno = alunoDAO.buscarPorMatricula(alunoMatricula);

            if (aluno == null) {
                throw new ServletException("Aluno não encontrado");
            }

            Relatorio relatorio = construirRelatorio(request);
            relatorio.setAluno(aluno);
            relatorioDAO.inserir(relatorio);

            // Redirecionar para a lista de relatórios do aluno
            response.sendRedirect(request.getContextPath() + "/relatorios?alunoMatricula=" + alunoMatricula);
        } catch (SQLException | NumberFormatException e) {
            logger.log(Level.SEVERE, "Erro ao criar relatório", e);
            request.setAttribute("erro", "Erro ao criar relatório: " + e.getMessage());
            exibirFormularioCriacao(request, response);
        }
    }

    private void atualizarRelatorio(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        Map<String, String> erros = validarCampos(request);
        int id = Integer.parseInt(request.getParameter("id"));

        if (!erros.isEmpty()) {
            request.setAttribute("erros", erros);
            request.setAttribute("relatorio", extrairDadosFormulario(request));
            exibirFormularioEdicao(id, request, response);
            return;
        }

        try {
            Relatorio relatorio = construirRelatorio(request);
            relatorio.setId(id);

            relatorioDAO.atualizar(relatorio);
            response.sendRedirect(request.getContextPath() + "/relatorios?sucesso=Relatório+atualizado+com+sucesso");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao atualizar relatório", e);
            request.setAttribute("erro", "Erro ao atualizar relatório no banco de dados");
            exibirFormularioEdicao(id, request, response);
        }
    }

    private void excluirRelatorio(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            relatorioDAO.deletar(id);
            response.sendRedirect(request.getContextPath() + "/relatorios?sucesso=Relatório+excluído+com+sucesso");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao excluir relatório", e);
            request.setAttribute("erro", "Erro ao excluir relatório do banco de dados");
            listarRelatorios(request, response);
        }
    }

    private Relatorio construirRelatorio(HttpServletRequest request) throws SQLException {
        Relatorio relatorio = new Relatorio();

        relatorio.setTitulo(request.getParameter("titulo"));
        relatorio.setDataGeracao(LocalDate.parse(request.getParameter("dataGeracao")));

        // Buscar professor pelo SIAPE, não pelo ID
        int professorId = Integer.parseInt(request.getParameter("professorId"));
        ProfessorAEE professor = professorAEEDAO.getById(professorId);

        if (professor != null) {
            relatorio.setProfessorAEE(professor);  // Isso deve armazenar o SIAPE internamente
        }

        relatorio.setResumo(request.getParameter("resumo"));
        relatorio.setObservacoes(request.getParameter("observacoes"));

        return relatorio;
    }

    private void listarRelatorios(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        try {
            String alunoMatricula = request.getParameter("alunoMatricula");
            List<Relatorio> relatorios;

            if (alunoMatricula != null && !alunoMatricula.isEmpty()) {
                relatorios = relatorioDAO.buscarPorAlunoMatricula(alunoMatricula);
                request.setAttribute("alunoMatricula", alunoMatricula); // Para usar no JSP
            } else {
                relatorios = relatorioDAO.buscarTodos();
            }

            request.setAttribute("relatoriosLista", relatorios);
            request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro de banco de dados", e);
            request.setAttribute("erro", "Erro ao carregar relatórios do banco de dados");
            request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Erro inesperado", e);
            request.setAttribute("erro", "Ocorreu um erro inesperado");
            request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
        }
    }

    private void exibirFormularioCriacao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<Aluno> alunos = alunoDAO.buscarTodos();
        List<ProfessorAEE> professores = professorAEEDAO.getAll();

        request.setAttribute("todosAlunos", alunos);
        request.setAttribute("todosProfessores", professores);
        request.setAttribute("modo", "criar");
        request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
    }

    private void exibirFormularioEdicao(int id, HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        Relatorio relatorio = relatorioDAO.buscarPorId(id);

        if (relatorio != null) {
            List<Aluno> alunos = alunoDAO.buscarTodos();
            List<ProfessorAEE> professores = professorAEEDAO.getAll();

            request.setAttribute("relatorio", relatorio);
            request.setAttribute("todosAlunos", alunos);
            request.setAttribute("todosProfessores", professores);
            request.setAttribute("modo", "editar");
            request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Relatório não encontrado");
        }
    }

    private void exibirDetalhesRelatorio(int id, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Relatorio relatorio = relatorioDAO.buscarPorId(id);

        if (relatorio != null) {
            request.setAttribute("relatorio", relatorio);
            request.getRequestDispatcher("/templates/aee/detalhes-PorRelatorio.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Relatório não encontrado");
        }
    }

    private Map<String, String> validarCampos(HttpServletRequest request) {
        Map<String, String> erros = new HashMap<>();

        validarCampoObrigatorio(request, "titulo", "Título", erros);
        validarCampoObrigatorio(request, "dataGeracao", "Data de Geração", erros);
        validarCampoObrigatorio(request, "professorId", "Professor Responsável", erros); // Corrigido
        validarCampoObrigatorio(request, "resumo", "Resumo", erros);

        try {
            LocalDate.parse(request.getParameter("dataGeracao"));
        } catch (DateTimeParseException e) {
            erros.put("dataGeracao", "Formato de data inválido");
        }

        return erros;
    }

    private void validarCampoObrigatorio(HttpServletRequest request, String param, String nomeCampo,
                                         Map<String, String> erros) {
        String valor = request.getParameter(param);
        if (valor == null || valor.trim().isEmpty()) {
            erros.put(param, nomeCampo + " é obrigatório");
        }
    }

    private Relatorio extrairDadosFormulario(HttpServletRequest request) {
        Relatorio relatorio = new Relatorio();

        relatorio.setTitulo(request.getParameter("titulo"));
        relatorio.setDataGeracao(parseDate(request.getParameter("dataGeracao")));
        relatorio.setResumo(request.getParameter("resumo"));
        relatorio.setObservacoes(request.getParameter("observacoes"));

        return relatorio;
    }

    private LocalDate parseDate(String dateString) {
        try {
            return dateString != null ? LocalDate.parse(dateString) : null;
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    private void encaminharErro(HttpServletRequest request, HttpServletResponse response, String mensagem)
            throws ServletException, IOException {
        request.setAttribute("erro", mensagem);
        request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
    }
}