package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.OrganizacaoAtendimentoDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.OrganizacaoAtendimento;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "MinhaOrganizacaoServlet", urlPatterns = {"/MinhaOrganizacao"})
public class MinhaOrganizacaoServlet extends HttpServlet {
    private AlunoDAO alunoDAO;
    private OrganizacaoAtendimentoDAO orgDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.alunoDAO = new AlunoDAO(conn);
        this.orgDAO = new OrganizacaoAtendimentoDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("entrou no servlet");
        String matricula = request.getParameter("matricula");
        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula não fornecida");
            return;
        }

        try {
            Aluno aluno = alunoDAO.buscar(matricula);

            if (aluno == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }

            OrganizacaoAtendimento organizacao = orgDAO.buscarPorAlunoMatricula(matricula);

            if (organizacao == null) {
                // Caso não exista organização para o aluno
                request.setAttribute("semPlano", true);
                request.setAttribute("aluno", aluno);
                request.setAttribute("matricula", matricula);
                request.getRequestDispatcher("/templates/aluno/MinhaOrganizacao.jsp").forward(request, response);
                return;

            }
            request.setAttribute("aluno", aluno);
            request.setAttribute("organizacao", organizacao);
            request.setAttribute("matricula", matricula);
            System.out.println("entrou aqui " + aluno.getMatricula() + " " + organizacao.getId());
            request.getRequestDispatcher("/templates/aluno/MinhaOrganizacao.jsp").forward(request, response);

        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar requisição");
        }
    }
}
