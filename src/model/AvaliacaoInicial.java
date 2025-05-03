package model;

public class AvaliacaoInicial {
    private int id;
    private String area;
    private String desempenhoVerificado;
    private String observacoes;

    public AvaliacaoInicial(String area, String desempenhoVerificado, String observacoes) {
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

    public void adicionarNoRelatorio(Relatorio relatorio, AvaliacaoInicial avaliacaoInicial){
        relatorio.setAvaliacaoInicial(avaliacaoInicial);
    }
}
