package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.DeficienciaDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Deficiencia;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "MinhasInformacoesServlet", urlPatterns = {"/templates/aluno/minhas-informacoes"})
public class MinhasInformacoesServlet extends HttpServlet {
    private AlunoDAO alunoDAO;
    private DeficienciaDAO deficienciaDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.alunoDAO = new AlunoDAO(conn);
        this.deficienciaDAO = new DeficienciaDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String matricula = request.getParameter("matricula");
        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula não fornecida");
            return;
        }

        try {
            Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
            if (aluno == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }

            List<Deficiencia> deficiencias = deficienciaDAO.findByAlunoMatricula(matricula);

            request.setAttribute("aluno", aluno);
            request.setAttribute("deficiencias", deficiencias);
            request.setAttribute("matricula", matricula);
            request.getRequestDispatcher("/templates/aluno/MinhasInformacoes.jsp").forward(request, response);

        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar requisição");
        }
    }
}