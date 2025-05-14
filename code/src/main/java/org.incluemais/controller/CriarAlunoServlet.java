package org.incluemais.controller;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.entities.Aluno;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

@WebServlet(name = "AlunoServlet", urlPatterns = {"/alunos", "/alunos/*"})
public class CriarAlunoServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CriarAlunoServlet.class.getName());
    private AlunoDAO alunoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        if (conn == null) {
            logger.severe("Conexão não encontrada!");
            throw new ServletException("Banco de dados não disponível");
        }
        this.alunoDAO = new AlunoDAO(conn);
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
            } else {
                listarAlunos(request, response);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro de banco de dados", e);
            encaminharErro(request, response, "Erro ao acessar dados");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("acao");

        try {
            if ("criar".equals(action)) {
                processarCriacao(request, response);
            } else if ("atualizar".equals(action)) {
               atualizarAluno(request, response);
            } else if ("excluir".equals(action)) {
                processarExclusao(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Ação inválida");
            }
        } catch (SQLException | DateTimeParseException e) {
            logger.log(Level.SEVERE, "Erro no processamento", e);
            encaminharErro(request, response, "Erro no processamento dos dados");
        }
    }

    private void listarAlunos(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        try {
            String filtro = request.getParameter("filtro");
            List<Aluno> alunos;

            if (filtro != null && !filtro.isEmpty()) {
                alunos = alunoDAO.buscarPorNome(filtro);
            } else {
                alunos = alunoDAO.buscarTodos();
            }

            request.setAttribute("alunos", alunos);
            request.getRequestDispatcher("AlunoCriar.jsp").forward(request, response);

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao listar alunos", e);
            encaminharErro(request, response, "Erro ao carregar lista de alunos");
        }
    }

    private void exibirFormularioCriacao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("modo", "criar");
        request.getRequestDispatcher("AlunoCriar.jsp").forward(request, response);
    }

    private void exibirFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Aluno aluno = alunoDAO.buscarPorId(id);

        if (aluno != null) {
            request.setAttribute("aluno", aluno);
            request.setAttribute("modo", "editar");
            request.getRequestDispatcher("AlunoCriar.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
        }
    }

    private void processarCriacao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        Map<String, String> erros = validarCampos(request);

        if (!erros.isEmpty()) {
            request.setAttribute("erros", erros);
            request.setAttribute("aluno", extrairDadosFormulario(request));
            request.setAttribute("modo", "criar");
            request.getRequestDispatcher("AlunoCriar.jsp").forward(request, response);
            return;
        }

        Aluno aluno = construirAluno(request);

        if (alunoDAO.salvarAluno(aluno)) {
            response.sendRedirect("alunos?sucesso=Aluno+criado+com+sucesso");
        } else {
            encaminharErro(request, response, "Falha ao salvar aluno no banco de dados");
        }
    }

    private void atualizarAluno(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException { // Remova SQLException

        try {
            // Código que NÃO lança SQLException
            Aluno aluno = construirAluno(request);
            aluno.setId(Integer.parseInt(request.getParameter("id")));

            if (alunoDAO.atualizarAluno(aluno)) { // Supondo que atualizarAluno agora retorna boolean
                response.sendRedirect("alunos?sucesso=Aluno+atualizado");
            } else {
                encaminharErro(request, response, "Falha na atualização");
            }

        } catch (NumberFormatException e) { // Exceção específica
            encaminharErro(request, response, "ID inválido");
        } catch (DateTimeParseException e) { // Outra exceção específica
            encaminharErro(request, response, "Data inválida");
        }
    }

    private void processarExclusao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));

        if (alunoDAO.excluirAluno(id)) {
            response.sendRedirect("alunos?sucesso=Aluno+excluído+com+sucesso");
        } else {
            encaminharErro(request, response, "Falha ao excluir aluno. Verifique se o ID é válido.");
        }
    }

    private Aluno construirAluno(HttpServletRequest request) throws DateTimeParseException {
        Aluno aluno = new Aluno();

        // Dados básicos
        aluno.setNome(request.getParameter("nome"));
        aluno.setDataNascimento(LocalDate.parse(request.getParameter("dataNascimento")));
        aluno.setEmail(request.getParameter("email"));
        aluno.setSexo(request.getParameter("sexo"));
        aluno.setNaturalidade(request.getParameter("naturalidade"));
        aluno.setTelefone(request.getParameter("telefone"));

        // Dados específicos de aluno
        aluno.setMatricula(request.getParameter("matricula"));
        aluno.setResponsavel(request.getParameter("responsavel"));
        aluno.setTelResponsavel(request.getParameter("telResponsavel"));
        aluno.setTelTrabalho(request.getParameter("telTrabalho"));
        aluno.setCurso(request.getParameter("curso"));
        aluno.setTurma(request.getParameter("turma"));

        return aluno;
    }

    private Map<String, String> validarCampos(HttpServletRequest request) {
        Map<String, String> erros = new HashMap<>();

        // Validação dos campos obrigatórios
        validarCampoObrigatorio(request, "nome", "Nome", erros);
        validarCampoObrigatorio(request, "dataNascimento", "Data de Nascimento", erros);
        validarCampoObrigatorio(request, "matricula", "Matrícula", erros);
        validarCampoObrigatorio(request, "curso", "Curso", erros);
        validarCampoObrigatorio(request, "turma", "Turma", erros);

        // Validação de formato da data
        try {
            LocalDate.parse(request.getParameter("dataNascimento"));
        } catch (DateTimeParseException e) {
            erros.put("dataNascimento", "Formato de data inválido");
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

    private Aluno extrairDadosFormulario(HttpServletRequest request) {
        Aluno aluno = new Aluno();

        // Mapear todos os campos do formulário
        aluno.setNome(request.getParameter("nome"));
        aluno.setDataNascimento(parseDate(request.getParameter("dataNascimento")));
        aluno.setEmail(request.getParameter("email"));
        aluno.setSexo(request.getParameter("sexo"));
        aluno.setNaturalidade(request.getParameter("naturalidade"));
        aluno.setTelefone(request.getParameter("telefone"));
        aluno.setMatricula(request.getParameter("matricula"));
        aluno.setResponsavel(request.getParameter("responsavel"));
        aluno.setTelResponsavel(request.getParameter("telResponsavel"));
        aluno.setTelTrabalho(request.getParameter("telTrabalho"));
        aluno.setCurso(request.getParameter("curso"));
        aluno.setTurma(request.getParameter("turma"));

        return aluno;
    }

    private LocalDate parseDate(String dateString) {
        try {
            return LocalDate.parse(dateString);
        } catch (DateTimeParseException e) {
            return null;
        }
    }

    private void encaminharErro(HttpServletRequest request, HttpServletResponse response, String mensagem)
            throws ServletException, IOException {
        request.setAttribute("erro", mensagem);
        request.getRequestDispatcher("AlunoCriar.jsp").forward(request, response);
    }

    private void exibirDetalhesAluno(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Aluno aluno = alunoDAO.buscarPorId(id);

            if (aluno != null) {
                request.setAttribute("aluno", aluno);
                request.getRequestDispatcher("/detalhesAluno.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
            }
        } catch (NumberFormatException e) {
            encaminharErro(request, response, "ID inválido");
        }
    }
}