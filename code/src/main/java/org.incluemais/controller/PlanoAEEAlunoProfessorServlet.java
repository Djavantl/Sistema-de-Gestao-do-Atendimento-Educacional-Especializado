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
import org.incluemais.model.connection.DBConnection;

/**
 * Servlet responsável pela visualização do Plano AEE de um aluno pelo professor.
 * Recupera dados de aluno, plano, metas, proposta e professor para exibição.
 */
@WebServlet("/templates/professor/visualizar-plano")
public class PlanoAEEAlunoProfessorServlet extends HttpServlet {

    private PropostaPedagogicaDAO propostaDAO;

    /**
     * Inicializa o DAO de PropostaPedagogica usando conexão armazenada no contexto.
     */
    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.propostaDAO = new PropostaPedagogicaDAO(conn);
    }

    /**
     * Processa requisições GET para exibir o plano AEE de um aluno.
     * Valida matrícula, busca aluno, plano, metas, proposta e dados de professor.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Validação do parâmetro matrícula
        String matricula = request.getParameter("matricula");
        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula do aluno inválida");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            // Instanciação de DAOs
            PlanoAEEDAO planoAeeDAO = new PlanoAEEDAO(conn);
            AlunoDAO alunoDAO = new AlunoDAO(conn);
            ProfessorAEEDAO professorDAO = new ProfessorAEEDAO(conn);
            MetaDAO metaDAO = new MetaDAO(conn);

            // Busca de aluno e plano
            Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
            if (aluno == null) {
                request.setAttribute("erro", "Aluno não encontrado");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            PlanoAEE plano = planoAeeDAO.buscarPorAluno(matricula);
            if (plano == null) {
                request.setAttribute("erro", "Nenhum plano encontrado para este aluno");
                request.getRequestDispatcher("/templates/professor/PlanoAEEAlunoP.jsp").forward(request, response);
                return;
            }

            // Carregamento de metas e proposta
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(plano.getId());
            plano.setMetas(metas);
            PropostaPedagogica proposta = propostaDAO.buscarPorPlanoId(plano.getId());
            plano.setProposta(proposta);

            // Completa dados do professor, se houver
            if (plano.getProfessorAEE() != null && plano.getProfessorAEE().getSiape() != null) {
                ProfessorAEE professor = professorDAO.buscarPorSiape(plano.getProfessorAEE().getSiape());
                plano.setProfessorAEE(professor);
            }

            // Atribuição do aluno ao plano
            plano.setAluno(aluno);

            // Encaminhamento para a JSP de visualização
            request.setAttribute("plano", plano);
            request.setAttribute("metas", metas);
            request.getRequestDispatcher("/templates/professor/PlanoAEEAlunoP.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar plano: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}