package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.ProfessorAEEDAO;
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

@WebServlet(name = "CriarProfessorAEEServlet", urlPatterns = {"/templates/aee/professoresAEE", "/templates/aee/professoresAEE/*"})
public class CriarProfessorAEEServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CriarProfessorAEEServlet.class.getName());
    private ProfessorAEEDAO professorAEEDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        if (conn == null) {
            logger.severe("Conexão não encontrada!");
            throw new ServletException("Banco de dados não disponível");
        }
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("acao");

            if ("editar".equals(action)) {
                String siape = request.getParameter("siape");
                ProfessorAEE professorAEE = professorAEEDAO.getBySiape(siape);

                if (professorAEE != null) {
                    request.setAttribute("professorAEE", professorAEE);
                    request.getRequestDispatcher("/templates/aee/EditarProfessorAEE.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Professor AEE não encontrado");
                }
            } else {
                listarProfessoresAEE(request, response);
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
                atualizarProfessorAEE(request, response);
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

    private void listarProfessoresAEE(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        List<ProfessorAEE> professores = professorAEEDAO.getAll();
        logger.info("Número de professores AEE recuperados: " + professores.size());

        professores.forEach(p ->
                logger.info("ProfessorAEE: " + p.getNome() + " - " + p.getSiape())
        );

        request.setAttribute("professoresAEELista", professores);
        request.getRequestDispatcher("/templates/aee/CriarProfessorAEE.jsp").forward(request, response);
    }

    private void exibirFormularioEdicao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        String siape = request.getParameter("siape");
        ProfessorAEE professorAEE = professorAEEDAO.getBySiape(siape);

        if (professorAEE != null) {
            request.setAttribute("professorAEE", professorAEE);
            request.getRequestDispatcher("/templates/aee/EditarProfessorAEE.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Professor AEE não encontrado");
        }
    }

    private void processarCriacao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        Map<String, String> erros = validarCampos(request);

        if (!erros.isEmpty()) {
            request.setAttribute("erros", erros);
            request.setAttribute("professorAEE", extrairDadosFormulario(request));
            request.getRequestDispatcher("/templates/aee/CriarProfessorAEE.jsp").forward(request, response);
            return;
        }

        ProfessorAEE professor = construirProfessorAEE(request);
        if(professorAEEDAO.salvarProfessorAEE(professor)) {
            response.sendRedirect(request.getContextPath() + "/templates/aee/professoresAEE?sucesso=Professor+AEE+criado+com+sucesso");
        } else {
            encaminharErro(request, response, "Erro ao salvar professor AEE");
        }
    }

    private void atualizarProfessorAEE(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        ProfessorAEE professor = construirProfessorAEE(request);
        professor.setSiape(request.getParameter("siape"));
        professorAEEDAO.update(professor);
        response.sendRedirect(request.getContextPath() + "/templates/aee/professoresAEE?sucesso=Professor+AEE+atualizado");
    }

    private void processarExclusao(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String siape = request.getParameter("siape");
        if (siape != null && !siape.isEmpty()) {
            professorAEEDAO.delete(siape);
            response.sendRedirect(request.getContextPath() +
                    "/templates/aee/professoresAEE?sucesso=Professor+AEE+excluído+com+sucesso");
        }
    }

    private ProfessorAEE construirProfessorAEE(HttpServletRequest request) throws DateTimeParseException {
        ProfessorAEE professor = new ProfessorAEE();

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

    private ProfessorAEE extrairDadosFormulario(HttpServletRequest request) {
        ProfessorAEE professor = new ProfessorAEE();

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
        request.getRequestDispatcher("/templates/aee/CriarProfessorAEE.jsp").forward(request, response);
    }
}