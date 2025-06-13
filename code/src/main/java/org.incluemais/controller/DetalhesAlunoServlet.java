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

@WebServlet(name = "DetalhesAlunoServlet", urlPatterns = {"/templates/aee/detalhes-aluno"})
public class DetalhesAlunoServlet extends HttpServlet {
    private AlunoDAO alunoDAO;
    private DeficienciaDAO deficienciaDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.alunoDAO = new AlunoDAO(conn);
        this.deficienciaDAO = new DeficienciaDAO(conn); // Inicialize o DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do aluno não fornecido");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Connection conn = (Connection) getServletContext().getAttribute("conexao");
            AlunoDAO alunoDAO = new AlunoDAO(conn);
            Aluno aluno = alunoDAO.buscar(id);

            if (aluno == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Aluno não encontrado");
                return;
            }


            List<Deficiencia> deficiencias = deficienciaDAO.buscar(aluno.getMatricula());

            OrganizacaoAtendimentoDAO orgDAO = new OrganizacaoAtendimentoDAO(
                    (Connection) getServletContext().getAttribute("conexao")
            );
            OrganizacaoAtendimento organizacao = orgDAO.buscarPorAlunoMatricula(aluno.getMatricula());


            request.setAttribute("aluno", aluno);
            request.setAttribute("deficiencias", deficiencias);
            request.setAttribute("organizacao", organizacao);

            request.getRequestDispatcher("/templates/aee/DetalhesAluno.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao processar requisição");
        }
    }
}
