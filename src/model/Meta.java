package model;

import java.time.LocalDate;

public class Meta {
    private int id;
    private String descricao;
    private LocalDate dataLimite;
    private String status;

    public Meta(String descricao, LocalDate dataLimite, String status) {
        this.descricao = descricao;
        this.dataLimite = dataLimite;
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

    public LocalDate getDataLimite() {
        return dataLimite;
    }

    public void setDataLimite(LocalDate dataLimite) {
        this.dataLimite = dataLimite;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void atualizarStatus(String novoStatus){
        this.setStatus(novoStatus);
    }
}
