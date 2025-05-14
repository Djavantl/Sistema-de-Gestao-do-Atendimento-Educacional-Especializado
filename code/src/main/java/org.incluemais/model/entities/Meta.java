package org.incluemais.model.entities;

import java.time.LocalDate;

public class Meta {
    private int id;
    private String descricao;
    private String status;

    public Meta(){
    }

    public Meta(String descricao, String status) {
        this.descricao = descricao;
        this.status = status;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void adicionarAoPlano(PlanoAEE plano, Meta meta){
        plano.adicionarMeta(meta);
    }
}
