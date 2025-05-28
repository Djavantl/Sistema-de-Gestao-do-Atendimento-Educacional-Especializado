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

@WebServlet(name = "RelatorioServlet", urlPatterns = {"/relatorios", "/relatorios/*"})
public class RelatorioServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(RelatorioServlet.class.getName());
    private RelatorioDAO relatorioDAO;
    private AlunoDAO alunoDAO;
    private ProfessorAEEDAO professorDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        if (conn == null) {
            logger.severe("Conexão não encontrada!");
            throw new ServletException("Banco de dados não disponível");
        }
        this.relatorioDAO = new RelatorioDAO(conn);
        this.alunoDAO = new AlunoDAO(conn);
        this.professorDAO = new ProfessorAEEDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("acao");

            if ("editar".equals(action)) {
                exibirFormularioEdicao(request, response);
            } else if ("novo".equals(action)) {
                exibirFormularioCriacao(request, response);
            } else if ("detalhes".equals(action)) {
                exibirDetalhesRelatorio(request, response);
            } else {
                listarRelatorios(request, response);
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
            if ("criar".equals(action)) {
                criarRelatorio(request, response);
            } else if ("atualizar".equals(action)) {
                atualizarRelatorio(request, response);
            } else if ("excluir".equals(action)) {
                excluirRelatorio(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida");
            }
        } catch (SQLException | DateTimeParseException e) {
            logger.log(Level.SEVERE, "Erro no processamento", e);
            encaminharErro(request, response, "Erro no processamento dos dados");
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
            Relatorio relatorio = construirRelatorio(request);
            relatorioDAO.inserir(relatorio);

            // Adicionar o relatório ao aluno
            relatorio.adicionarAoAluno(relatorio.getAluno(), relatorio);

            response.sendRedirect(request.getContextPath() + "/relatorios?sucesso=Relatório+criado+com+sucesso");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao criar relatório", e);
            request.setAttribute("erro", "Erro ao criar relatório no banco de dados");
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
            exibirFormularioEdicao(request, response);
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
            exibirFormularioEdicao(request, response);
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

        // Buscar aluno e professor no banco
        String matriculaAluno = request.getParameter("aluno");
        String siapeProfessor = request.getParameter("professorAEE");

        Aluno aluno = alunoDAO.buscarPorMatricula(matriculaAluno);
        ProfessorAEE professor = siapeProfessor != null && !siapeProfessor.isEmpty() ?
                professorDAO.getBySiape(siapeProfessor) : null;

        relatorio.setAluno(aluno);
        relatorio.setProfessorAEE(professor);
        relatorio.setResumo(request.getParameter("resumo"));
        relatorio.setObservacoes(request.getParameter("observacoes"));

        return relatorio;
    }

    private void listarRelatorios(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            System.out.println("DEBUG - Iniciando listarRelatorios()");
            List<Relatorio> relatorios = relatorioDAO.buscarTodos();

            // Debug detalhado
            System.out.println("DEBUG - Número de relatórios encontrados: " + relatorios.size());
            if (!relatorios.isEmpty()) {
                Relatorio primeiro = relatorios.get(0);
                System.out.println("DEBUG - Primeiro relatório: " +
                        primeiro.getId() + " - " + primeiro.getTitulo() +
                        " - Aluno: " + primeiro.getAluno().getNome());
            }

            request.setAttribute("relatoriosLista", relatorios);

            System.out.println("DEBUG - Encaminhando para /templates/aee/PorRelatorio.jsp");
            request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("ERRO - Em listarRelatorios: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar relatórios: " + e.getMessage());
            request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
        }
    }

    private void exibirFormularioCriacao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        List<Aluno> alunos = alunoDAO.buscarTodos();
        List<ProfessorAEE> professores = professorDAO.getAll();

        request.setAttribute("todosAlunos", alunos);
        request.setAttribute("todosProfessores", professores);
        request.setAttribute("modo", "criar");
        request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
    }

    private void exibirFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Relatorio relatorio = relatorioDAO.buscarPorId(id);

        if (relatorio != null) {
            List<Aluno> alunos = alunoDAO.buscarTodos();
            List<ProfessorAEE> professores = professorDAO.getAll();

            request.setAttribute("relatorio", relatorio);
            request.setAttribute("todosAlunos", alunos);
            request.setAttribute("todosProfessores", professores);
            request.setAttribute("modo", "editar");
            request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Relatório não encontrado");
        }
    }

    private void exibirDetalhesRelatorio(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("id"));
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

        // Validação dos campos obrigatórios
        validarCampoObrigatorio(request, "titulo", "Título", erros);
        validarCampoObrigatorio(request, "dataGeracao", "Data de Geração", erros);
        validarCampoObrigatorio(request, "aluno", "Aluno", erros);
        validarCampoObrigatorio(request, "resumo", "Resumo", erros);

        // Validação de formato da data
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
