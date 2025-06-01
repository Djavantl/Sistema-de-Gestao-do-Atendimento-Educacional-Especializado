package org.incluemais.controller;

import org.incluemais.model.dao.AvaliacaoDAO;
import org.incluemais.model.dao.UsuarioAlunoDAO;
import org.incluemais.model.dao.UsuarioProfessorDAO;
import org.incluemais.model.dao.UsuarioProfessorAEEDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/cadastro")
public class CadastroServlet extends HttpServlet {
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
        System.out.println("Iniciando processo de cadastro...");

        String tipo = request.getParameter("tipo");
        String identificacao = request.getParameter("identificacao");
        String senha = request.getParameter("senha");
        String confirmarSenha = request.getParameter("confirmarSenha");

        System.out.println("Tipo: " + tipo);
        System.out.println("Identificação: " + identificacao);
        System.out.println("Senha: " + senha);
        System.out.println("Confirmar Senha: " + confirmarSenha);

        // Verificar se as senhas coincidem
        if (!senha.equals(confirmarSenha)) {
            request.setAttribute("mensagemErro", "As senhas não coincidem");
            request.getRequestDispatcher("/templates/usuarios/cadastro.jsp").forward(request, response);
            return;
        }
        Connection conn = (Connection) getServletContext().getAttribute("conexao");

        if (conn == null) {
            request.setAttribute("mensagemErro", "Erro de conexão com o banco de dados");
            request.getRequestDispatcher("/templates/usuarios/cadastro.jsp").forward(request, response);
            return;
        }

        try {
            boolean sucesso = false;
            String mensagemSucesso = "";
            String mensagemErro = "";

            if ("aluno".equals(tipo)) {
                System.out.println("Processando cadastro de aluno...");
                boolean existe = usuarioAlunoDAO.existeMatricula(identificacao);
                System.out.println("Matrícula existe? " + existe);
                if (existe) {
                    sucesso = usuarioAlunoDAO.criarUsuario(identificacao, senha);
                    System.out.println("Usuário aluno criado? " + sucesso);
                    mensagemSucesso = "Conta de aluno criada com sucesso!";
                } else {
                    mensagemErro = "Matrícula não encontrada. Você deve estar cadastrado como aluno.";
                }
            }
            else if ("professor".equals(tipo)) {
                usuarioProfessorDAO = new UsuarioProfessorDAO(conn);
                if (usuarioProfessorDAO.existeSiape(identificacao)) {
                    sucesso = usuarioProfessorDAO.criarUsuario(identificacao, senha);
                    mensagemSucesso = "Conta de professor criada com sucesso!";
                } else {
                    mensagemErro = "SIAPE não encontrado. Você deve estar cadastrado como professor.";
                }
            }
            else if ("professorAEE".equals(tipo)) {
                usuarioProfessorAEEDAO = new UsuarioProfessorAEEDAO(conn);
                if (usuarioProfessorAEEDAO.existeSiape(identificacao)) {
                    sucesso = usuarioProfessorAEEDAO.criarUsuario(identificacao, senha);
                    mensagemSucesso = "Conta de professor AEE criada com sucesso!";
                } else {
                    mensagemErro = "SIAPE não encontrado. Você deve estar cadastrado como professor AEE.";
                }
            }

            if (sucesso) {
                request.setAttribute("mensagemSucesso", mensagemSucesso);
                request.getRequestDispatcher("/templates/usuarios/login.jsp").forward(request, response);
            } else {
                if (mensagemErro.isEmpty()) {
                    mensagemErro = "Não foi possível criar a conta. Tente novamente mais tarde.";
                }
                request.setAttribute("mensagemErro", mensagemErro);
                request.getRequestDispatcher("/templates/usuarios/cadastro.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Mensagem mais específica para erro de duplicidade
            if (e.getMessage().contains("Duplicate entry")) {
                request.setAttribute("mensagemErro", "Este usuário já possui cadastro no sistema");
            } else {
                request.setAttribute("mensagemErro", "Erro no banco de dados: " + e.getMessage());
            }
            request.getRequestDispatcher("/templates/usuarios/cadastro.jsp").forward(request, response);
        }
    }
}