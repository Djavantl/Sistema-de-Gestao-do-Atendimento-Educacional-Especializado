package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.SessaoAtendimentoDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.SessaoAtendimento;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "MinhasSessoesServlet", urlPatterns = {"/templates/aluno/minhas-sessoes"})
public class MinhasSessoesServlet extends HttpServlet {
    private SessaoAtendimentoDAO sessaoDAO;
    private AlunoDAO alunoDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.sessaoDAO = new SessaoAtendimentoDAO(conn);
        this.alunoDAO = new AlunoDAO(conn);
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
            Aluno aluno = alunoDAO.buscar(matricula);
            if (aluno == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }

            List<SessaoAtendimento> todasSessoes = sessaoDAO.buscar(matricula);
            List<SessaoAtendimento> sessoesFuturas = new ArrayList<>();
            List<SessaoAtendimento> sessoesPassadas = new ArrayList<>();

            LocalDate hoje = LocalDate.now();

            for (SessaoAtendimento sessao : todasSessoes) {
                if (sessao.getData().isAfter(hoje) || sessao.getData().isEqual(hoje)) {
                    sessoesFuturas.add(sessao);
                } else {
                    sessoesPassadas.add(sessao);
                }
            }

            request.setAttribute("aluno", aluno);
            request.setAttribute("sessoesFuturas", sessoesFuturas);
            request.setAttribute("sessoesPassadas", sessoesPassadas);
            request.setAttribute("matricula", matricula);

            request.getRequestDispatcher("/templates/aluno/MinhasSessoes.jsp").forward(request, response);

        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar requisição");
        }
    }
}