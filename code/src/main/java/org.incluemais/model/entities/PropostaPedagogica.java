package org.incluemais.model.entities;

public class PropostaPedagogica {
    private int id;
    private String objetivos;
    private String metodologias;
    private RecursosPedagogicos recursoP;
    private RecursoFisicoArquitetonico recursoFA;
    private RecursosComunicacaoEInformacao recursoCI;
    private int planoAEEId;

    public PropostaPedagogica() {
    }

    public PropostaPedagogica(String objetivos, String metodologias, RecursosPedagogicos recursoP, RecursoFisicoArquitetonico recursoFA, RecursosComunicacaoEInformacao recursoCI, int planoAEEId) {
        this.objetivos = objetivos;
        this.metodologias = metodologias;
        this.recursoP = recursoP;
        this.recursoFA = recursoFA;
        this.recursoCI = recursoCI;
        this.planoAEEId = planoAEEId;
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

    public int getPlanoAEEId() {
        return planoAEEId;
    }

    public void setPlanoAEEId(int planoAEEId) {
        this.planoAEEId = planoAEEId;
    }
}
