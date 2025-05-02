package model;

public class DeficienciaVisual extends Deficiencia{
    private boolean usaBraille;
    private boolean usaRecursosAmpliacao;
    private boolean usaLeitorDeTela;
    private boolean usaCaoGuia;
    private boolean usaBengala;

    public DeficienciaVisual(String descricao, boolean usaBraille, boolean usaRecursosAmpliacao, boolean usaLeitorDeTela, boolean usaCaoGuia, boolean usaBengala) {
        super(descricao, "Visual");
        this.usaBraille = usaBraille;
        this.usaRecursosAmpliacao = usaRecursosAmpliacao;
        this.usaLeitorDeTela = usaLeitorDeTela;
        this.usaCaoGuia = usaCaoGuia;
        this.usaBengala = usaBengala;
    }


    public boolean isUsaBraille() {
        return usaBraille;
    }

    public void setUsaBraille(boolean usaBraille) {
        this.usaBraille = usaBraille;
    }

    public boolean isUsaRecursosAmpliacao() {
        return usaRecursosAmpliacao;
    }

    public void setUsaRecursosAmpliacao(boolean usaRecursosAmpliacao) {
        this.usaRecursosAmpliacao = usaRecursosAmpliacao;
    }

    public boolean isUsaLeitorDeTela() {
        return usaLeitorDeTela;
    }

    public void setUsaLeitorDeTela(boolean usaLeitorDeTela) {
        this.usaLeitorDeTela = usaLeitorDeTela;
    }

    public boolean isUsaCaoGuia() {
        return usaCaoGuia;
    }

    public void setUsaCaoGuia(boolean usaCaoGuia) {
        this.usaCaoGuia = usaCaoGuia;
    }

    public boolean isUsaBengala() {
        return usaBengala;
    }

    public void setUsaBengala(boolean usaBengala) {
        this.usaBengala = usaBengala;
    }

    public void definirAdaptacoes() {
        if (usaBraille) {
            getAdaptacoes().add("Leitura em braille");
        }
        if (usaRecursosAmpliacao) {
            getAdaptacoes().add("Impressos ampliados");
        }
        if (usaLeitorDeTela) {
            getAdaptacoes().add("Leitor de tela");
        }
        if (usaCaoGuia) {
            getAdaptacoes().add("Uso de cão-guia");
        }
        if (usaBengala) {
            getAdaptacoes().add("Uso de bengala");
        }
    }
}
