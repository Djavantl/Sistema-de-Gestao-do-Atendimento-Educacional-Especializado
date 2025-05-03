package model;

public class AvaliacaoProcessual {
    private int id;
    private String avancosArea;
    private String dificuldadesArea;
    private String encaminhamentos;

    public AvaliacaoProcessual(String avancosArea, String dificuldadesArea, String encaminhamentos) {
        this.avancosArea = avancosArea;
        this.dificuldadesArea = dificuldadesArea;
        this.encaminhamentos = encaminhamentos;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getAvancosArea() {
        return avancosArea;
    }

    public void setAvancosArea(String avancosArea) {
        this.avancosArea = avancosArea;
    }

    public String getDificuldadesArea() {
        return dificuldadesArea;
    }

    public void setDificuldadesArea(String dificuldadesArea) {
        this.dificuldadesArea = dificuldadesArea;
    }

    public String getEncaminhamentos() {
        return encaminhamentos;
    }

    public void setEncaminhamentos(String encaminhamentos) {
        this.encaminhamentos = encaminhamentos;
    }

    public void adicionarNoRelatorio(Relatorio relatorio, AvaliacaoProcessual avaliacaoProcessual){
        relatorio.setAvaliacaoProcessual(avaliacaoProcessual);
    }
}
