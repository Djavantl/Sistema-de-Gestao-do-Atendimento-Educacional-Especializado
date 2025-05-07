package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.PessoaDAO;
import org.incluemais.model.entities.Pessoa;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/pessoas")
public class PessoaServlet extends HttpServlet {
    private PessoaDAO pessoaDAO = new PessoaDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        List<Pessoa> pessoas = pessoaDAO.listarPessoas();
        out.println("<html><head><title>Lista de Pessoas</title></head><body>");
        out.println("<h2>Lista de Pessoas</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>Nome</th><th>Data de Nascimento</th><th>Email</th><th>Sexo</th><th>Naturalidade</th><th>Telefone</th><th>Ações</th></tr>");
        for (Pessoa pessoa : pessoas) {
            out.println("<tr><td>" + pessoa.getNome() + "</td><td>" + pessoa.getDataNascimento() + "</td><td>" + pessoa.getEmail() + "</td><td>" + pessoa.getSexo() + "</td><td>" + pessoa.getNaturalidade() + "</td><td>" + pessoa.getTelefone() + "</td>");
            out.println("<td><a href='pessoas?acao=excluir&id=" + pessoa.getId() + "'>Excluir</a></td></tr>");
        }
        out.println("</table>");
        out.println("<h3>Adicionar Pessoa</h3>");
        out.println("<form action='pessoas' method='post'>");
        out.println("Nome: <input type='text' name='nome'><br>");
        out.println("Data de Nascimento: <input type='date' name='dataNascimento'><br>");
        out.println("Email: <input type='text' name='email'><br>");
        out.println("Sexo: <input type='text' name='sexo'><br>");
        out.println("Naturalidade: <input type='text' name='naturalidade'><br>");
        out.println("Telefone: <input type='text' name='telefone'><br>");
        out.println("<input type='submit' value='Salvar'>");
        out.println("</form>");
        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nome = request.getParameter("nome");
        LocalDate dataNascimento = LocalDate.parse(request.getParameter("dataNascimento"));
        String email = request.getParameter("email");
        String sexo = request.getParameter("sexo");
        String naturalidade = request.getParameter("naturalidade");
        String telefone = request.getParameter("telefone");

        Pessoa pessoa = new Pessoa(nome, dataNascimento, email, sexo, naturalidade, telefone);
        pessoaDAO.inserirPessoa(pessoa);

        response.sendRedirect("/pessoas");
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        pessoaDAO.excluirPessoa(id);
        response.sendRedirect("/ListarPessoas.jsp");
    }
}
