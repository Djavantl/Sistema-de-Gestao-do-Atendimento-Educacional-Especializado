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

@WebServlet("/templates/professor/visualizar-plano")
public class PlanoAEEAlunoProfessorServlet extends HttpServlet {

    private PropostaPedagogicaDAO propostaDAO; // Adicionado

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.propostaDAO = new PropostaPedagogicaDAO(conn); // Inicializado
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String matricula = request.getParameter("matricula");
        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula do aluno inválida");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            PlanoAEEDAO planoAeeDAO = new PlanoAEEDAO(conn);
            AlunoDAO alunoDAO = new AlunoDAO(conn);
            ProfessorAEEDAO professorDAO = new ProfessorAEEDAO(conn);
            MetaDAO metaDAO = new MetaDAO(conn); // Novo DAO para metas

            // Buscar aluno pela matrícula
            Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
            if (aluno == null) {
                request.setAttribute("erro", "Aluno não encontrado");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            // Buscar plano do aluno
            PlanoAEE plano = planoAeeDAO.buscarPorAluno(matricula);

            if (plano == null) {
                request.setAttribute("erro", "Nenhum plano encontrado para este aluno");
                request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
                return;
            }

            // Carregar metas associadas ao plano
            List<Meta> metas = metaDAO.buscarMetasPorPlanoId(plano.getId());
            plano.setMetas(metas); // Adiciona metas ao objeto plano
            PropostaPedagogica proposta = propostaDAO.buscarPorPlanoId(plano.getId());
            plano.setProposta(proposta);

            // Completar dados do professor se existir
            if (plano.getProfessorAEE() != null && plano.getProfessorAEE().getSiape() != null) {
                ProfessorAEE professor = professorDAO.buscarPorSiape(
                        plano.getProfessorAEE().getSiape()
                );
                plano.setProfessorAEE(professor);
            }

            // Completar dados do aluno
            plano.setAluno(aluno);

            request.setAttribute("plano", plano);
            request.setAttribute("metas", metas); // Passa metas explicitamente
            request.getRequestDispatcher("/templates/professor/PlanoAEEAlunoP.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao carregar plano: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
        }
    }

}