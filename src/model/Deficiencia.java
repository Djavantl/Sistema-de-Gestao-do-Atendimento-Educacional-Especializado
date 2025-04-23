package model;

import java.util.ArrayList;
import java.util.List;

public class Deficiencia{
	
	private int id;
    private String descricao;
    private String tipoDeficiciencia;
    private List<String> adaptacoes = new ArrayList<>();

    public Deficiencia(String descricao, String tipoDeficiciencia) {
        this.descricao = descricao;
        this.tipoDeficiciencia = tipoDeficiciencia;
    }

    public String getDescricao() {
        return descricao;
    }

    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getTipoDeficiciencia() {
        return tipoDeficiciencia;
    }

    public void setTipoDeficiciencia(String tipoDeficiciencia) {
        this.tipoDeficiciencia = tipoDeficiciencia;
    }

    public List<String> getAdaptacoes() {
        return adaptacoes;
    }

    public void definirAdaptacoes(){

    };
}
