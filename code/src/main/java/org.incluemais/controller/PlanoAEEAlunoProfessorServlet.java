package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.*;
import org.incluemais.model.entities.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "PlanoAEEVisualizacaoServlet",
        urlPatterns = {"/templates/professor/visualizar-plano"})
public class PlanoAEEAlunoProfessorServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(PlanoAEEAlunoProfessorServlet.class.getName());

    private PlanoAEEDAO planoAEEDAO;
    private AlunoDAO alunoDAO;
    private ProfessorAEEDAO professorAEEDAO;
    private PropostaPedagogicaDAO propostaDAO;
    private MetaDAO metaDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.planoAEEDAO = new PlanoAEEDAO(conn);
        this.alunoDAO = new AlunoDAO(conn);
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
        this.propostaDAO = new PropostaPedagogicaDAO(conn);
        this.metaDAO = new MetaDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String matricula = request.getParameter("matricula");

        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do plano não fornecido");
            return;
        }

        try {
            PlanoAEE plano = planoAEEDAO.buscarPorMatriculaAluno(matricula);

            if (plano == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Plano não encontrado");
                return;
            }

            Aluno aluno = alunoDAO.buscarPorMatricula(plano.getAlunoMatricula());
            ProfessorAEE professor = professorAEEDAO.getBySiape(plano.getProfessorSiape());
            PropostaPedagogica proposta = propostaDAO.buscarPorPlanoId(plano.getId());
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(plano.getId());

            plano.setProposta(proposta);
            plano.setMetas(metas);

            request.setAttribute("plano", plano);
            request.setAttribute("aluno", aluno);
            request.setAttribute("professor", professor);

            if (request.getParameter("success") != null) {
                request.setAttribute("success", request.getParameter("success"));
            }
            if (request.getParameter("erro") != null) {
                request.setAttribute("erro", request.getParameter("erro"));
            }

            request.getRequestDispatcher("/templates/professor/PlanoAEEAlunoP.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException e) {
            logger.log(Level.SEVERE, "Erro ao carregar detalhes do plano", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
        }
    }
}