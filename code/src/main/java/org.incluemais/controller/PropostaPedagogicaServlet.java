package org.incluemais.controller;

import org.incluemais.model.dao.*;
import org.incluemais.model.entities.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

@WebServlet("/propostas")
public class PropostaPedagogicaServlet extends HttpServlet {

    private PropostaPedagogicaDAO propostaDAO;
    private RecursosPedagogicosDAO recursosPDAO;
    private RecursoFisicoArquitetonicoDAO recursosFADAO;
    private RecursosComunicacaoEInformacaoDAO recursosCIDAO;

    @Override
    public void init() throws ServletException {
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/incluemaisDB");
            Connection conn = ds.getConnection();

            propostaDAO = new PropostaPedagogicaDAO(conn);
            recursosPDAO = new RecursosPedagogicosDAO(conn);
            recursosFADAO = new RecursoFisicoArquitetonicoDAO(conn);
            recursosCIDAO = new RecursosComunicacaoEInformacaoDAO(conn);
        } catch (NamingException | SQLException e) {
            throw new ServletException("Erro ao inicializar conexões", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/proposta.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String objetivos = request.getParameter("objetivos");
        String metodologias = request.getParameter("metodologias");

        RecursosPedagogicos recursosP = processarRecursosPedagogicos(request);
        RecursoFisicoArquitetonico recursosFA = processarRecursosFA(request);
        RecursosComunicacaoEInformacao recursosCI = processarRecursosCI(request);

        PropostaPedagogica proposta = new PropostaPedagogica(objetivos, metodologias);
        proposta.setRecursoP(recursosP);
        proposta.setRecursoFA(recursosFA);
        proposta.setRecursoCI(recursosCI);

        try {
            boolean salvo = propostaDAO.salvarProposta(proposta);
            if (salvo) {
                response.sendRedirect(request.getContextPath() + "/propostas?success=true");
            } else {
                redirecionarComErro(request, response, "Falha ao salvar proposta");
            }
        } catch (Exception e) {
            redirecionarComErro(request, response, "Erro no servidor: " + e.getMessage());
        }
    }

    private RecursosPedagogicos processarRecursosPedagogicos(HttpServletRequest request) {
        RecursosPedagogicos recursos = new RecursosPedagogicos();
        recursos.setAdaptacaoDidaticaAulasAvaliacoes(verificarParametro(request, "recursoP_adaptacaoDidaticaAulasAvaliacoes"));
        recursos.setMaterialDidaticoAdaptado(verificarParametro(request, "recursoP_materialDidaticoAdaptado"));
        recursos.setUsoTecnologiaAssistiva(verificarParametro(request, "recursoP_usoTecnologiaAssistiva"));
        recursos.setTempoEmpregadoAtividadesAvaliacoes(verificarParametro(request, "recursoP_tempoEmpregadoAtividadesAvaliacoes"));

        if (recursos.temRecursos()) {
            try {
                recursosPDAO.inserir(recursos);
                return recursos;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    private RecursoFisicoArquitetonico processarRecursosFA(HttpServletRequest request) {
        RecursoFisicoArquitetonico recursos = new RecursoFisicoArquitetonico();
        recursos.setUsoCadeiraDeRodas(verificarParametro(request, "recursoFA_usoCadeiraDeRodas"));
        recursos.setAuxilioTranscricaoEscrita(verificarParametro(request, "recursoFA_auxilioTranscricaoEscrita"));
        recursos.setMesaAdaptadaCadeiraDeRodas(verificarParametro(request, "recursoFA_mesaAdaptadaCadeiraDeRodas"));
        recursos.setUsoDeMuleta(verificarParametro(request, "recursoFA_usoDeMuleta"));
        boolean outros = verificarParametro(request, "recursoFA_outrosFisicoArquitetonico");
        recursos.setOutrosFisicoArquitetonico(outros);
        if (outros) {
            recursos.setOutrosEspecificado(request.getParameter("recursoFA_outrosEspecificado"));
        }

        if (recursos.temRecursos()) {
            try {
                recursosFADAO.inserir(recursos);
                return recursos;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    private RecursosComunicacaoEInformacao processarRecursosCI(HttpServletRequest request) {
        RecursosComunicacaoEInformacao recursos = new RecursosComunicacaoEInformacao();
        recursos.setComunicacaoAlternativa(verificarParametro(request, "recursoCI_comunicacaoAlternativa"));
        recursos.setTradutorInterprete(verificarParametro(request, "recursoCI_tradutorInterprete"));
        recursos.setLeitorTranscritor(verificarParametro(request, "recursoCI_leitorTranscritor"));
        recursos.setInterpreteOralizador(verificarParametro(request, "recursoCI_interpreteOralizador"));
        recursos.setGuiaInterprete(verificarParametro(request, "recursoCI_guiaInterprete"));
        recursos.setMaterialDidaticoBraille(verificarParametro(request, "recursoCI_materialDidaticoBraille"));
        recursos.setMaterialDidaticoTextoAmpliado(verificarParametro(request, "recursoCI_materialDidaticoTextoAmpliado"));
        recursos.setMaterialDidaticoRelevo(verificarParametro(request, "recursoCI_materialDidaticoRelevo"));
        recursos.setLeitorDeTela(verificarParametro(request, "recursoCI_leitorDeTela"));
        recursos.setFonteTamanhoEspecifico(verificarParametro(request, "recursoCI_fonteTamanhoEspecifico"));

        if (recursos.temRecursos()) {
            try {
                recursosCIDAO.inserir(recursos);
                return recursos;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    private boolean verificarParametro(HttpServletRequest request, String param) {
        return "on".equals(request.getParameter(param));
    }

    private void redirecionarComErro(HttpServletRequest request, HttpServletResponse response, String mensagem)
            throws ServletException, IOException {
        request.setAttribute("error", mensagem);
        request.getRequestDispatcher("/WEB-INF/proposta.jsp").forward(request, response);
    }
}