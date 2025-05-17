package org.incluemais.model.entities;

public class PropostaPedagogica {
    private int id;
    private String objetivos;
    private String metodologias;
    private RecursosPedagogicos recursoP;
    private RecursoFisicoArquitetonico recursoFA;
    private RecursosComunicacaoEInformacao recursoCI;


    public PropostaPedagogica(String objetivos, String metodologias) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
    }

    public PropostaPedagogica(String objetivos, String metodologias, RecursosPedagogicos recursoP) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursoP = recursoP;
    }

    public PropostaPedagogica(String objetivos, String metodologias, RecursoFisicoArquitetonico recursoFA) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursoFA = recursoFA;
    }

    public PropostaPedagogica(String objetivos, String metodologias, RecursosComunicacaoEInformacao recursoCI) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursoCI = recursoCI;
    }

    public PropostaPedagogica(String objetivos, String metodologias, RecursosPedagogicos recursoP, RecursoFisicoArquitetonico recursoFA) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursoP = recursoP;
        this.recursoFA = recursoFA;
    }

    public PropostaPedagogica(String objetivos, String metodologias, RecursosPedagogicos recursoP, RecursoFisicoArquitetonico recursoFA, RecursosComunicacaoEInformacao recursoCI) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursoP = recursoP;
        this.recursoFA = recursoFA;
        this.recursoCI = recursoCI;
    }

    public PropostaPedagogica(String objetivos, String metodologias, RecursosPedagogicos recursoP, RecursosComunicacaoEInformacao recursoCI) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursoP = recursoP;
        this.recursoCI = recursoCI;
    }

    public PropostaPedagogica(String objetivos, String metodologias, RecursoFisicoArquitetonico recursoFA, RecursosComunicacaoEInformacao recursoCI) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursoFA = recursoFA;
        this.recursoCI = recursoCI;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getObjetivos() {
        return objetivos;
    }

    public void setObjetivos(String objetivos) {
        this.objetivos = objetivos;
    }

    public String getMetodologias() {
        return metodologias;
    }

    public void setMetodologias(String metodologias) {
        this.metodologias = metodologias;
    }

    public RecursosPedagogicos getRecursoP() {
        return recursoP;
    }

    public void setRecursoP(RecursosPedagogicos recursoP) {
        this.recursoP = recursoP;
    }

    public RecursoFisicoArquitetonico getRecursoFA() {
        return recursoFA;
    }

    public void setRecursoFA(RecursoFisicoArquitetonico recursoFA) {
        this.recursoFA = recursoFA;
    }

    public RecursosComunicacaoEInformacao getRecursoCI() {
        return recursoCI;
    }

    public void setRecursoCI(RecursosComunicacaoEInformacao recursoCI) {
        this.recursoCI = recursoCI;
    }

    public void adicionarAoPlano(PlanoAEE plano, PropostaPedagogica proposta){
        plano.adicionarProposta(proposta);
    }
}
