package model;

import java.util.ArrayList;
import java.util.List;

public class Deficiencia {
    private int id;
    private String descricao;
    private String tipoDeficiencia;
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

    public void setAdaptacoes(List<String> adaptacoes) {
        this.adaptacoes = adaptacoes;
    }

    public List<String> getAdaptacoes() { return adaptacoes; }

    public void definirAdaptacoes() {
        // Implementar nas subclasses
    }
}
