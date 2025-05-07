package org.incluemais.controller;

import org.incluemais.model.dao.PessoaDAO;
import org.incluemais.model.entities.Pessoa;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/listarPessoas")
public class ListarPessoasServlet extends HttpServlet {
    private PessoaDAO pessoaDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        pessoaDAO = new PessoaDAO();  // Instância do DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera a lista de pessoas do banco de dados
        List<Pessoa> pessoas = pessoaDAO.listarPessoas();

        // Define a lista de pessoas como atributo na requisição
        request.setAttribute("pessoas", pessoas);

        // Direciona para a página JSP para exibir as pessoas
        request.getRequestDispatcher("/listar-pessoas.jsp").forward(request, response);
    }
}
