package org.incluemais.controller;

import org.incluemais.model.dao.UsuarioAlunoDAO;
import org.incluemais.model.dao.UsuarioProfessorDAO;
import org.incluemais.model.dao.UsuarioProfessorAEEDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UsuarioAlunoDAO usuarioAlunoDAO;
    private UsuarioProfessorDAO usuarioProfessorDAO;
    private UsuarioProfessorAEEDAO usuarioProfessorAEEDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        if (conn == null) {
            throw new ServletException("Conexão não disponível");
        }
        this.usuarioAlunoDAO = new UsuarioAlunoDAO(conn);
        this.usuarioProfessorDAO = new UsuarioProfessorDAO(conn);
        this.usuarioProfessorAEEDAO = new UsuarioProfessorAEEDAO(conn);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Iniciando processo de login...");

        String tipo = request.getParameter("tipo");
        String identificacao = request.getParameter("identificacao");
        String senha = request.getParameter("senha");

        System.out.println("Tipo: " + tipo);
        System.out.println("Identificação: " + identificacao);
        System.out.println("Senha: " + senha);

        Connection conn = (Connection) getServletContext().getAttribute("conexao");

        if (conn == null) {
            System.err.println("ERRO GRAVE: Conexão com banco de dados não encontrada no contexto");
            request.setAttribute("mensagemErro", "Erro de conexão com o banco de dados");
            request.getRequestDispatcher("/templates/usuarios/login.jsp").forward(request, response);
            return;
        }

        try {
            boolean autenticado = false;
            String redirectPage = "/templates/usuarios/login.jsp";
            String tipoUsuario = "";


            if ("aluno".equals(tipo)) {
                usuarioAlunoDAO = new UsuarioAlunoDAO(conn);
                autenticado = usuarioAlunoDAO.verificarCredenciais(identificacao, senha);
                tipoUsuario = "aluno";
                redirectPage = request.getContextPath() + "/telaInicialAluno";
                System.out.println("Redirecionando aluno para: " + redirectPage);
            }
            else if ("professor".equals(tipo)) {
                usuarioProfessorDAO = new UsuarioProfessorDAO(conn);
                autenticado = usuarioProfessorDAO.verificarCredenciais(identificacao, senha);
                tipoUsuario = "professor";
                System.out.println(identificacao);
                redirectPage = "/templates/professor/professor-alunos?siape=" + identificacao;
            }
            else if ("professorAEE".equals(tipo)) {
                usuarioProfessorAEEDAO = new UsuarioProfessorAEEDAO(conn);
                autenticado = usuarioProfessorAEEDAO.verificarCredenciais(identificacao, senha);
                tipoUsuario = "professorAEE";
                redirectPage = "/templates/aee/sessoes";
            }

            if (autenticado) {
                HttpSession session = request.getSession();
                session.setAttribute("tipoUsuario", tipoUsuario);
                session.setAttribute("identificacao", identificacao);
                response.sendRedirect(redirectPage);
            } else {
                request.setAttribute("mensagemErro", "Matrícula/SIAPE ou senha incorretos");
                request.getRequestDispatcher("/templates/usuarios/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("mensagemErro", "Erro no banco de dados: " + e.getMessage());
            request.getRequestDispatcher("/templates/usuarios/login.jsp").forward(request, response);
        }
    }
}