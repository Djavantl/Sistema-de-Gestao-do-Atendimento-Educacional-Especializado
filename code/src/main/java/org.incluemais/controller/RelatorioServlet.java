package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.http.HttpSession;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.AvaliacaoDAO;
import org.incluemais.model.dao.ProfessorAEEDAO;
import org.incluemais.model.dao.RelatorioDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.ProfessorAEE;
import org.incluemais.model.entities.Relatorio;

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
        "/relatorios/excluir",
        "/meus-relatorios",
        "/relatorios/meus-detalhes"
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
            String path = request.getServletPath();

            if (path.equals("/relatorios")) {
                listarRelatorios(request, response);
            } else if (path.equals("/relatorios/novo")) {
                exibirFormularioCriacao(request, response);
            } else if (path.equals("/relatorios/editar")) {
                int id = Integer.parseInt(request.getParameter("id"));
                exibirFormularioEdicao(id, request, response);
            } else if (path.equals("/relatorios/detalhes")) {
                int id = Integer.parseInt(request.getParameter("id"));
                exibirDetalhesRelatorio(id, request, response);
            } else if (path.equals("/meus-relatorios")) {
                listarMeusRelatorios(request, response);
            } else if (path.equals("/relatorios/meus-detalhes")) {
                int id = Integer.parseInt(request.getParameter("id"));
                exibirDetalhesMeuRelatorio(id, request, response);
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
        String path = request.getServletPath();

        try {
            if (path.equals("/relatorios/criar")) {
                criarRelatorio(request, response);
            } else if (path.equals("/relatorios/atualizar")) {
                atualizarRelatorio(request, response);
            } else if (path.equals("/relatorios/excluir")) {
                excluirRelatorio(request, response);
            }
        } catch (SQLException | DateTimeParseException e) {
            logger.log(Level.SEVERE, "Erro no processamento", e);
            encaminharErro(request, response, "Erro no processamento dos dados");
        }
    }

    private void listarMeusRelatorios(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        // Obter a matrícula do aluno logado da sessão
        HttpSession session = request.getSession();
        String matriculaSessao = (String) session.getAttribute("identificacao"); // Alterado para "identificacao"

        if (matriculaSessao == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Filtrar relatórios apenas do aluno logado
        List<Relatorio> relatorios = relatorioDAO.buscarPorAlunoMatricula(matriculaSessao);

        request.setAttribute("relatoriosLista", relatorios);
        request.getRequestDispatcher("/templates/aluno/MeusRelatorios.jsp").forward(request, response);
        logger.info("Matrícula da sessão: " + matriculaSessao);
        logger.info("Número de relatórios encontrados: " + relatorios.size());
    }

    private void exibirDetalhesMeuRelatorio(int id, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        Relatorio relatorio = relatorioDAO.buscarPorId(id);

        if (relatorio != null) {
            request.setAttribute("relatorio", relatorio);
            request.getRequestDispatcher("/templates/aluno/DetalhesMeusRelatorios.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Relatório não encontrado");
        }
    }

    private void criarRelatorio(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        Map<String, String> erros = validarCampos(request);

        // Validação adicional para o professor
        String siape = request.getParameter("professorSiape");
        if (siape == null || siape.trim().isEmpty()) {
            erros.put("professorSiape", "SIAPE do professor é obrigatório");
        } else {
            ProfessorAEE professor = professorAEEDAO.buscarPorSiape(siape);
            if (professor == null) {
                erros.put("professorSiape", "Professor não encontrado com este SIAPE");
            }
        }

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

            ProfessorAEE professor = professorAEEDAO.buscarPorSiape(siape);
            Relatorio relatorio = construirRelatorio(request);
            relatorio.setAluno(aluno);
            relatorio.setProfessorAEE(professor);

            // Log para depuração
            logger.info("Criando relatório: " +
                    "Título=" + relatorio.getTitulo() +
                    ", Aluno=" + aluno.getNome() +
                    ", Professor=" + (professor != null ? professor.getNome() : "null") +
                    ", Resumo=" + relatorio.getResumo());

            boolean salvou = relatorioDAO.inserir(relatorio);
            if (salvou) {
                response.sendRedirect(request.getContextPath() + "/relatorios/detalhes?id=" + relatorio.getId());
            } else {
                throw new ServletException("Falha ao salvar relatório no banco de dados");
            }
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
            // Monta um novo objeto Relatorio
            Relatorio relatorio = new Relatorio();
            relatorio.setId(id);

            // 1) Define o título e data:
            relatorio.setTitulo(request.getParameter("titulo"));
            relatorio.setDataGeracao(LocalDate.parse(request.getParameter("dataGeracao")));

            // 2) Lê o alunoMatricula do <select> e busca o objeto Aluno no banco:
            String alunoMatricula = request.getParameter("alunoMatricula");
            Aluno aluno = alunoDAO.buscarPorMatricula(alunoMatricula);
            if (aluno == null) {
                throw new ServletException("Aluno não encontrado para a matrícula: " + alunoMatricula);
            }
            relatorio.setAluno(aluno);

            // 3) Lê o SIAPE do professor (se existir) e busca o ProfessorAEE:
            String siape = request.getParameter("professorSiape");
            if (siape != null && !siape.trim().isEmpty()) {
                ProfessorAEE professor = professorAEEDAO.buscarPorSiape(siape);
                relatorio.setProfessorAEE(professor);
            } else {
                relatorio.setProfessorAEE(null);
            }

            // 4) Define resumo e observações:
            relatorio.setResumo(request.getParameter("resumo"));
            relatorio.setObservacoes(request.getParameter("observacoes"));

            // 5) Chama o DAO para atualizar no banco:
            relatorioDAO.atualizar(relatorio);

            // 6) Redireciona de volta para a lista (ou detalhe), conforme sua lógica:

            response.sendRedirect(request.getContextPath() + "/relatorios?alunoMatricula=" + alunoMatricula + "&sucesso=Relatório+atualizado+com+sucesso");

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
            // Buscar relatório antes de excluir para obter matrícula do aluno
            Relatorio relatorio = relatorioDAO.buscarPorId(id);
            String alunoMatricula = null;
            if (relatorio != null && relatorio.getAluno() != null) {
                alunoMatricula = relatorio.getAluno().getMatricula();
            }

            relatorioDAO.deletar(id);

            String redirectURL = request.getContextPath() + "/relatorios?sucesso=Relatório+excluído+com+sucesso";
            if (alunoMatricula != null && !alunoMatricula.isEmpty()) {
                redirectURL += "&alunoMatricula=" + alunoMatricula;
            }

            response.sendRedirect(redirectURL);
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

        // Obter SIAPE digitado manualmente
        String siape = request.getParameter("professorSiape");
        if (siape != null && !siape.trim().isEmpty()) {
            ProfessorAEE professor = professorAEEDAO.buscarPorSiape(siape);
            relatorio.setProfessorAEE(professor);
        }

        relatorio.setResumo(request.getParameter("resumo"));
        relatorio.setObservacoes(request.getParameter("observacoes"));
        return relatorio;
    }

    private void listarRelatorios(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String alunoMatricula = request.getParameter("alunoMatricula");
        List<Relatorio> relatorios;

        if (alunoMatricula != null && !alunoMatricula.isEmpty()) {
            relatorios = relatorioDAO.buscarPorAlunoMatricula(alunoMatricula);
            // opcional: passar de volta para o JSP o próprio alunoMatricula, se quiser exibir
            request.setAttribute("alunoMatricula", alunoMatricula);
        } else {
            relatorios = relatorioDAO.buscarTodos();
        }

        request.setAttribute("relatoriosLista", relatorios);
        request.getRequestDispatcher("/templates/aee/PorRelatorio.jsp").forward(request, response);
    }

    private void exibirFormularioCriacao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String matricula = request.getParameter("alunoMatricula");

        if (matricula == null || matricula.isEmpty()) {
            throw new ServletException("Matrícula do aluno não fornecida.");
        }
        Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
        request.setAttribute("aluno", aluno);

        // Lista todas as opções de alunos para o <select> do JSP
        List<Aluno> todosAlunos = alunoDAO.buscarTodos();
        request.setAttribute("alunosLista", todosAlunos);

        request.setAttribute("aluno", aluno);           // Pode ser null para novo
        request.setAttribute("modo", "criar");
        request.getRequestDispatcher("/templates/aee/NovoRelatorio.jsp").forward(request, response);
    }

    private void exibirFormularioEdicao(int id, HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Relatorio relatorio = relatorioDAO.buscarPorId(id);
        if (relatorio != null) {
            // Busca todos os alunos para preencher o <select>
            List<Aluno> todosAlunos = alunoDAO.buscarTodos();
            request.setAttribute("alunosLista", todosAlunos);

            request.setAttribute("relatorio", relatorio);
            request.getRequestDispatcher("/templates/aee/EditarRelatorio.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Relatório não encontrado");
        }
    }

    private void exibirDetalhesRelatorio(int id, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        logger.info("Buscando relatório com ID: " + id);
        Relatorio relatorio = relatorioDAO.buscarPorId(id);

        if (relatorio != null) {
            logger.info("Relatório encontrado: " + relatorio.getTitulo());
            // A lista de avaliações já estará em relatorio.getAvaliacoes()
            request.setAttribute("relatorio", relatorio);

            String caminhoJSP = "/templates/aee/DetalhesRelatorio.jsp";
            logger.info("Encaminhando para: " + caminhoJSP);
            request.getRequestDispatcher(caminhoJSP).forward(request, response);
        } else {
            logger.warning("Relatório não encontrado para ID: " + id);
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Relatório não encontrado");
        }
    }

    private Map<String, String> validarCampos(HttpServletRequest request) {
        Map<String, String> erros = new HashMap<>();
        validarCampoObrigatorio(request, "titulo", "Título", erros);
        validarCampoObrigatorio(request, "dataGeracao", "Data de Geração", erros);
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
