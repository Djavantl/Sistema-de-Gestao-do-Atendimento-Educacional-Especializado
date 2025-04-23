package model;

import java.time.LocalDate;

public class SessaoAtendimento {
    private int id;
    private LocalDate data;
    private String conteudo;
    private String observacoes;

    public SessaoAtendimento(LocalDate data, String conteudo, String observacoes) {
        this.data = data;
        this.conteudo = conteudo;
        this.observacoes = observacoes;
    }

    public SessaoAtendimento(LocalDate data, String conteudo) {
        this.data = data;
        this.conteudo = conteudo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public String getConteudo() {
        return conteudo;
    }

    public void setConteudo(String conteudo) {
        this.conteudo = conteudo;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }
}
