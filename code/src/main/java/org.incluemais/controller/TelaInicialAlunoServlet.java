package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.entities.Aluno;

import java.io.IOException;
import java.sql.Connection;

@WebServlet(name = "TelaInicialServlet", urlPatterns = {"/telaInicialAluno"})
public class TelaInicialAlunoServlet extends HttpServlet {
    private AlunoDAO alunoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.alunoDAO = new AlunoDAO(conn);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("identificacao") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        String matricula = (String) session.getAttribute("identificacao");
        Aluno aluno = alunoDAO.buscar(matricula);

        request.setAttribute("matricula", matricula);
        request.setAttribute("aluno", aluno);
        request.getRequestDispatcher("/templates/aluno/PaginaInicial.jsp").forward(request, response);
    }
}
