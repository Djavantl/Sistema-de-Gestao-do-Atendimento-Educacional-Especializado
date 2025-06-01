package org.incluemais.model.entities;

public class Avaliacao {
    private int id;
    private String area;
    private String desempenhoVerificado;
    private String observacoes;

    public Avaliacao() { }

    public Avaliacao(String area, String desempenhoVerificado, String observacoes) {
        this.area = area;
        this.desempenhoVerificado = desempenhoVerificado;
        this.observacoes = observacoes;
    }

    public Avaliacao(int id, String area, String desempenhoVerificado, String observacoes) {
        this.id = id;
        this.area = area;
        this.desempenhoVerificado = desempenhoVerificado;
        this.observacoes = observacoes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getDesempenhoVerificado() {
        return desempenhoVerificado;
    }

    public void setDesempenhoVerificado(String desempenhoVerificado) {
        this.desempenhoVerificado = desempenhoVerificado;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public void adicionarNoRelatorio(Relatorio relatorio, Avaliacao avaliacao){
        relatorio.getAvaliacoes().add(avaliacao);
    }
}
