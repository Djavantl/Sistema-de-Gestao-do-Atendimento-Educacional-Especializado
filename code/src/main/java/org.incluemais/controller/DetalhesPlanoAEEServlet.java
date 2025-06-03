package org.incluemais.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.incluemais.model.dao.*;
import org.incluemais.model.entities.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import static org.incluemais.model.connection.DBConnection.getConnection;

@WebServlet(name = "DetalhesPlanoAEEServlet",
        urlPatterns = {"/templates/aee/detalhes-plano"})
public class DetalhesPlanoAEEServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(DetalhesPlanoAEEServlet.class.getName());

    private PlanoAEEDAO planoAEEDAO;
    private AlunoDAO alunoDAO;
    private ProfessorAEEDAO professorAEEDAO;
    private PropostaPedagogicaDAO propostaDAO;
    private MetaDAO metaDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = (Connection) getServletContext().getAttribute("conexao");
        this.planoAEEDAO = new PlanoAEEDAO(conn);
        this.alunoDAO = new AlunoDAO(conn);
        this.professorAEEDAO = new ProfessorAEEDAO(conn);
        this.propostaDAO = new PropostaPedagogicaDAO(conn);
        this.metaDAO = new MetaDAO(conn);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/templates/aee/detalhes-plano".equals(path)) {
            String idParam = request.getParameter("id");
            System.out.println(idParam);
            if (idParam == null || idParam.isEmpty()) {
                System.out.println(idParam + "IF");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID do plano não fornecido");
                return;
            }

            try {
                int planoId = Integer.parseInt(idParam);
                PlanoAEE plano = planoAEEDAO.buscarPorId(planoId);

                if (plano == null) {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Plano não encontrado");
                    return;
                }

                Aluno aluno = alunoDAO.buscarPorMatricula(plano.getAlunoMatricula());
                ProfessorAEE professor = professorAEEDAO.getBySiape(plano.getProfessorSiape());
                PropostaPedagogica proposta = propostaDAO.buscarPorPlanoId(planoId);
                List<Meta> metas = metaDAO.buscarMetasPorPlanoId(planoId);

                plano.setProposta(proposta);
                plano.setMetas(metas);

                request.setAttribute("plano", plano);
                request.setAttribute("aluno", aluno);
                request.setAttribute("professor", professor);

                if (request.getParameter("success") != null) {
                    request.setAttribute("success", request.getParameter("success"));
                }
                if (request.getParameter("erro") != null) {
                    request.setAttribute("erro", request.getParameter("erro"));
                }

                request.getRequestDispatcher("/templates/aee/DetalhesPlanoAEE.jsp").forward(request, response);

            } catch (NumberFormatException | SQLException e) {
                logger.log(Level.SEVERE, "Erro ao carregar detalhes do plano", e);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro interno do servidor");
            }
        }
    }
}
