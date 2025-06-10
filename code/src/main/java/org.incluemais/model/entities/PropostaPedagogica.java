package org.incluemais.model.entities;

public class PropostaPedagogica {
    private int id;
    private String objetivos;
    private String metodologias;
    private String observacoes;
    private RecursosPedagogicos recursoP;
    private RecursoFisicoArquitetonico recursoFA;
    private RecursosComunicacaoEInformacao recursoCI;
    private PlanoAEE planoAEE; // Composição

    public PropostaPedagogica() {
    }

    public PropostaPedagogica(String objetivos, String metodologias, String observacoes,
                              RecursosPedagogicos recursoP, RecursoFisicoArquitetonico recursoFA,
                              RecursosComunicacaoEInformacao recursoCI, PlanoAEE planoAEE) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.observacoes = observacoes;
        this.recursoP = recursoP;
        this.recursoFA = recursoFA;
        this.recursoCI = recursoCI;
        this.planoAEE = planoAEE;
    }

    public PropostaPedagogica(int id, String objetivos, String metodologias, String observacoes,
                              RecursosPedagogicos recursoP, RecursoFisicoArquitetonico recursoFA,
                              RecursosComunicacaoEInformacao recursoCI, PlanoAEE planoAEE) {
        this.id = id;
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.observacoes = observacoes;
        this.recursoP = recursoP;
        this.recursoFA = recursoFA;
        this.recursoCI = recursoCI;
        this.planoAEE = planoAEE;
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

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
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

    public PlanoAEE getPlanoAEE() {
        return planoAEE;
    }

    public void setPlanoAEE(PlanoAEE planoAEE) {
        this.planoAEE = planoAEE;
    }
}
