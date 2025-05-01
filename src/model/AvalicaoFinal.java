package model;

public class AvalicaoFinal {
    private String alcancadoArea;
    private String naoAlcancadoArea;
    private String relatorioFinal;

    public AvalicaoFinal(String alcancadoArea, String naoAlcancadoArea, String relatorioFinal) {
        this.alcancadoArea = alcancadoArea;
        this.naoAlcancadoArea = naoAlcancadoArea;
        this.relatorioFinal = relatorioFinal;
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
}
