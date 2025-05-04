package entities;

public class AvaliacaoFinal {
    private int id;
    private String alcancadoArea;
    private String naoAlcancadoArea;
    private String relatorioFinal;

    public AvaliacaoFinal(String alcancadoArea, String naoAlcancadoArea, String relatorioFinal) {
        this.alcancadoArea = alcancadoArea;
        this.naoAlcancadoArea = naoAlcancadoArea;
        this.relatorioFinal = relatorioFinal;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAlcancadoArea() {
        return alcancadoArea;
    }

    public void setAlcancadoArea(String alcancadoArea) {
        this.alcancadoArea = alcancadoArea;
    }

    public String getNaoAlcancadoArea() {
        return naoAlcancadoArea;
    }

    public void setNaoAlcancadoArea(String naoAlcancadoArea) {
        this.naoAlcancadoArea = naoAlcancadoArea;
    }

    public String getRelatorioFinal() {
        return relatorioFinal;
    }

    public void setRelatorioFinal(String relatorioFinal) {
        this.relatorioFinal = relatorioFinal;
    }

    public void adicionarNoRelatorio(Relatorio relatorio, AvaliacaoFinal avaliacaoFinal){
        relatorio.setAvaliacaoFinal(avaliacaoFinal);
    }
}
