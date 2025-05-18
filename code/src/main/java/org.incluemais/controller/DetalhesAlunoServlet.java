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

@WebServlet(name = "DetalhesAlunoServlet", urlPatterns = {"/templates/aee/detalhes-aluno", "/templates/aee/detalhes-aluno/*"})
public class DetalhesAlunoServlet extends HttpServlet {
    private AlunoDAO alunoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.alunoDAO = new AlunoDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do aluno não fornecido");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Aluno aluno = alunoDAO.obterPorId(id);
            OrganizacaoAtendimentoDAO orgDAO = new OrganizacaoAtendimentoDAO((Connection) getServletContext().getAttribute("conexao"));
            OrganizacaoAtendimento organizacao = orgDAO.buscarPorAlunoMatricula(aluno.getMatricula());
            request.setAttribute("organizacao", organizacao);

            if (aluno == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }

            request.setAttribute("aluno", aluno);
            request.getRequestDispatcher("/templates/aee/DetalhesAluno.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID inválido");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
