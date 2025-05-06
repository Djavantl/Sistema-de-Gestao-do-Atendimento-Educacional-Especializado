package org.incluemais.model.entities;

import java.util.ArrayList;
import java.util.List;

public class Deficiencia {
    private int id;
    private String descricao;
    private String tipoDeficiencia;
    private RecursoFisicoArquitetonico recursoFisicoArquitetonico;
    private RecursosComunicacaoEInformacao comunicacaoEInformacao;
    private RecursosPedagogicos recursosPedagogicos;
    private List<String> adaptacoes = new ArrayList<>();

    public Deficiencia(String descricao, String tipoDeficiencia) {
        this.descricao = descricao;
        this.tipoDeficiencia = tipoDeficiencia;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getTipoDeficiencia() {
        return tipoDeficiencia;
    }

    public void setTipoDeficiencia(String tipoDeficiencia) {
        this.tipoDeficiencia = tipoDeficiencia;
    }

    public List<String> getAdaptacoes() {
        return adaptacoes;
    }

    public void setAdaptacoes(List<String> adaptacoes) {
        this.adaptacoes = adaptacoes;
    }

    public RecursoFisicoArquitetonico getRecursoFisicoArquitetonico() {
        return recursoFisicoArquitetonico;
    }

    public void setRecursoFisicoArquitetonico(RecursoFisicoArquitetonico recursoFisicoArquitetonico) {
        this.recursoFisicoArquitetonico = recursoFisicoArquitetonico;
    }

    public RecursosComunicacaoEInformacao getComunicacaoEInformacao() {
        return comunicacaoEInformacao;
    }

    public void setComunicacaoEInformacao(RecursosComunicacaoEInformacao comunicacaoEInformacao) {
        this.comunicacaoEInformacao = comunicacaoEInformacao;
    }

    public RecursosPedagogicos getRecursosPedagogicos() {
        return recursosPedagogicos;
    }

    public void setRecursosPedagogicos(RecursosPedagogicos recursosPedagogicos) {
        this.recursosPedagogicos = recursosPedagogicos;
    }

}
