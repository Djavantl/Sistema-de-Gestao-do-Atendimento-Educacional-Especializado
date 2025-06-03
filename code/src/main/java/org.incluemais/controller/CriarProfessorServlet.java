package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.ProfessorDAO;
import org.incluemais.model.entities.Professor;

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

@WebServlet(name = "CriarProfessorServlet", urlPatterns = {"/templates/admin/professores", "/templates/admin/professores/*"})
public class CriarProfessorServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CriarProfessorServlet.class.getName());
    private ProfessorDAO professorDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        if (conn == null) {
            logger.severe("Conexão não encontrada!");
            throw new ServletException("Banco de dados não disponível");
        }
        this.professorDAO = new ProfessorDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("acao");

            if ("editar".equals(action)) {
                String siape = request.getParameter("siape");
                Professor professor = professorDAO.getBySiape(siape);

                if (professor != null) {
                    request.setAttribute("professor", professor);
                    request.getRequestDispatcher("/templates/admin/EditarProfessor.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Professor não encontrado");
                }
            } else {
                listarProfessores(request, response);
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
                atualizarProfessor(request, response);
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

    private void listarProfessores(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<Professor> professores = professorDAO.getAll();
        logger.info("Número de professores recuperados: " + professores.size());
        request.setAttribute("professoresLista", professores);
        logger.info("Número de professores recuperados DAO: " + professores.size()); // Log 1

        // Log dos dados recebidos
        professores.forEach(p ->
                logger.info("Professor: " + p.getNome() + " - " + p.getSiape())
        );

        request.setAttribute("professoresLista", professores);

        // Log antes do forward
        logger.info("Encaminhando para JSP: /templates/admin/CriarProfessor.jsp"); // Log 2

        request.getRequestDispatcher("/templates/admin/CriarProfessor.jsp").forward(request, response);
    }

    private void exibirFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String siape = request.getParameter("siape");
        Professor professor = professorDAO.getBySiape(siape);

        if (professor != null) {
            request.setAttribute("professor", professor);
            request.getRequestDispatcher("/templates/admin/CriarProfessor.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Professor não encontrado");
        }
    }

    private void processarCriacao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        Map<String, String> erros = validarCampos(request);

        if (!erros.isEmpty()) {
            request.setAttribute("erros", erros);
            request.setAttribute("professor", extrairDadosFormulario(request));
            request.getRequestDispatcher("/templates/admin/CriarProfessor.jsp").forward(request, response);
            return;
        }

        Professor professor = construirProfessor(request);
        professorDAO.salvarProfessor(professor);
        response.sendRedirect(request.getContextPath() + "/templates/admin/professores?sucesso=Professor+criado+com+sucesso");
    }

    private void atualizarProfessor(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException, SQLException {

            Professor professor = construirProfessor(request);
            professor.setSiape(request.getParameter("siape"));
            professorDAO.update(professor);

            List<Professor> professores = professorDAO.getAll();
            request.setAttribute("professoresLista", professores);
            request.getRequestDispatcher("/templates/admin/CriarProfessor.jsp").forward(request, response);

    }

    private void processarExclusao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        String siape = request.getParameter("siape");
        if (siape != null && !siape.isEmpty()) {
                professorDAO.delete(siape);
                response.sendRedirect(request.getContextPath() +
                        "/templates/admin/professores?sucesso=Professor+excluído+com+sucesso");

        }
    }

    private Professor construirProfessor(HttpServletRequest request) throws DateTimeParseException {
        Professor professor = new Professor();

        professor.setNome(request.getParameter("nome"));
        professor.setDataNascimento(LocalDate.parse(request.getParameter("dataNascimento")));
        professor.setEmail(request.getParameter("email"));
        professor.setSexo(request.getParameter("sexo"));
        professor.setNaturalidade(request.getParameter("naturalidade"));
        professor.setTelefone(request.getParameter("telefone"));
        professor.setSiape(request.getParameter("siape"));
        professor.setEspecialidade(request.getParameter("especialidade"));

        return professor;
    }

    private Map<String, String> validarCampos(HttpServletRequest request) {
        Map<String, String> erros = new HashMap<>();

        validarCampoObrigatorio(request, "nome", "Nome", erros);
        validarCampoObrigatorio(request, "dataNascimento", "Data de Nascimento", erros);
        validarCampoObrigatorio(request, "email", "Email", erros);
        validarCampoObrigatorio(request, "sexo", "Sexo", erros);
        validarCampoObrigatorio(request, "siape", "SIAPE", erros);
        validarCampoObrigatorio(request, "especialidade", "Especialidade", erros);

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

    private Professor extrairDadosFormulario(HttpServletRequest request) {
        Professor professor = new Professor();

        professor.setNome(request.getParameter("nome"));
        professor.setDataNascimento(parseDate(request.getParameter("dataNascimento")));
        professor.setEmail(request.getParameter("email"));
        professor.setSexo(request.getParameter("sexo"));
        professor.setNaturalidade(request.getParameter("naturalidade"));
        professor.setTelefone(request.getParameter("telefone"));
        professor.setSiape(request.getParameter("siape"));
        professor.setEspecialidade(request.getParameter("especialidade"));

        return professor;
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
        request.getRequestDispatcher("/templates/admin/CriarProfessor.jsp").forward(request, response);
    }
}
