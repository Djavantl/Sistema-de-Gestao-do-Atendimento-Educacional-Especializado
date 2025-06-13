package org.incluemais.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.dao.AlunoDAO;
import org.incluemais.model.dao.DeficienciaDAO;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Deficiencia;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet(name = "CriarDeficienciaServlet", value = "/deficiencia")
public class CriarDeficienciaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String alunoId = request.getParameter("alunoId");
        String matricula = request.getParameter("matricula");

        System.out.println("Params recebidos - alunoId: " + alunoId + ", matricula: " + matricula);

        if (acao == null || alunoId == null || matricula == null) {
            request.getSession().setAttribute("erro", "Parâmetros inválidos");
            response.sendRedirect(request.getContextPath() + "/templates/aee/alunos");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            AlunoDAO alunoDAO = new AlunoDAO(conn);
            DeficienciaDAO deficienciaDAO = new DeficienciaDAO(conn);

            switch (acao) {
                case "criar":
                    criarDeficiencia(request, conn, alunoDAO, deficienciaDAO, matricula);
                    break;
                case "atualizar":
                    atualizarDeficiencia(request, deficienciaDAO);
                    break;
                case "excluir":
                    excluirDeficiencia(request, deficienciaDAO);
                    break;
                default:
                    throw new IllegalArgumentException("Ação inválida: " + acao);
            }


        } catch (SQLException | IllegalArgumentException e) {
            handleError(request, response, alunoId, "Erro na operação: " + e.getMessage());
            return;
        }

        response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-aluno?id=" + alunoId);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        String idParam = request.getParameter("id");
        String alunoId = request.getParameter("alunoId");

        if ("editar".equals(acao)) {
            try (Connection conn = DBConnection.getConnection()) {
                int id = Integer.parseInt(idParam);
                DeficienciaDAO dao = new DeficienciaDAO(conn);
                Deficiencia deficiencia = dao.buscar(id);

                if (deficiencia != null) {
                    request.setAttribute("deficiencia", deficiencia);
                    request.getRequestDispatcher("/templates/aee/EditarDeficiencia.jsp").forward(request, response);
                } else {
                    System.out.println("nao editou");
                }
            } catch (SQLException | NumberFormatException e) {

            }
        } else {
            response.sendRedirect(request.getContextPath() + "/templates/aee/alunos");
        }


        try (Connection conn = DBConnection.getConnection()) {
            int id = Integer.parseInt(idParam);
            DeficienciaDAO dao = new DeficienciaDAO(conn);
            Deficiencia deficiencia = dao.buscar(id);

            if (deficiencia != null) {
                request.setAttribute("deficiencia", deficiencia);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/templates/aee/EditarDeficiencia.jsp");
                dispatcher.forward(request, response);
            } else {
                handleError(request, response, alunoId, "Deficiência não encontrada");
            }

        } catch (SQLException | NumberFormatException e) {
            handleError(request, response, alunoId, "Erro ao carregar dados: " + e.getMessage());
        }
    }

    private void criarDeficiencia(HttpServletRequest request, Connection conn, AlunoDAO alunoDAO, DeficienciaDAO deficienciaDAO, String matricula)
            throws SQLException {
        System.out.println("entrou criar");
        Aluno aluno = alunoDAO.buscar(matricula);
        if (aluno == null) {
            throw new SQLException("Aluno não encontrado com a matrícula: " + matricula);
        }

        Deficiencia deficiencia = new Deficiencia();
        deficiencia.setNome(request.getParameter("nome"));
        deficiencia.setDescricao(request.getParameter("descricao"));
        deficiencia.setGrauSeveridade(request.getParameter("grau"));
        deficiencia.setCid(request.getParameter("cid"));
        deficiencia.setAluno(aluno);

        deficienciaDAO.create(deficiencia);
    }

    private void atualizarDeficiencia(HttpServletRequest request, DeficienciaDAO dao) throws SQLException {
        System.out.println("entrou atualizar");
        Deficiencia deficiencia = new Deficiencia();
        deficiencia.setId(Integer.parseInt(request.getParameter("id")));
        deficiencia.setNome(request.getParameter("nome"));
        deficiencia.setDescricao(request.getParameter("descricao"));
        deficiencia.setGrauSeveridade(request.getParameter("grau"));
        deficiencia.setCid(request.getParameter("cid"));

        dao.update(deficiencia);
    }

    private void excluirDeficiencia(HttpServletRequest request, DeficienciaDAO dao) throws SQLException {
        System.out.println("entrou deletar");
        int id = Integer.parseInt(request.getParameter("id"));
        dao.delete(id);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String alunoId, String mensagem)
            throws IOException {
        request.getSession().setAttribute("erro", mensagem);
        response.sendRedirect(request.getContextPath() + "/templates/aee/detalhes-aluno?id=" + alunoId);
    }
}
