package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.DeficienciaDAO;
import org.incluemais.model.dao.OrganizacaoAtendimentoDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Deficiencia;
import org.incluemais.model.entities.OrganizacaoAtendimento;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "MostrarDetalhesAlunoServlet", urlPatterns = {"/templates/professor/detalhes-alunoP"})
public class DetalhesAlunosPServlet extends HttpServlet {
    private AlunoDAO alunoDAO;
    private DeficienciaDAO deficienciaDAO;
    private OrganizacaoAtendimentoDAO organizacaoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.alunoDAO = new AlunoDAO(conn);
        this.deficienciaDAO = new DeficienciaDAO(conn);
        this.organizacaoDAO = new OrganizacaoAtendimentoDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recebe matrícula como parâmetro de query string
        String matricula = request.getParameter("matricula");
        if (matricula == null || matricula.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Matrícula não fornecida");
            return;
        }

        try {
            // 1) busca dados principais do aluno
            Aluno aluno = alunoDAO.buscar(matricula);
            if (aluno == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }

            // 2) busca possíveis deficiências
            List<Deficiencia> deficiencias = deficienciaDAO.buscar(matricula);

            // 3) busca organização de atendimento
            OrganizacaoAtendimento organizacao =
                    organizacaoDAO.buscarPorAlunoMatricula(matricula);

            // 4) encaminha atributos para o JSP
            request.setAttribute("aluno", aluno);
            request.setAttribute("deficiencias", deficiencias);
            request.setAttribute("organizacao", organizacao);

            // 5) despacho para a página de detalhes
            request.getRequestDispatcher("/templates/professor/DetalhesAlunoP.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Erro ao carregar detalhes do aluno", e);
        }
    }
}

