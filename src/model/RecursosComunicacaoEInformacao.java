package model;

public class RecursosComunicacaoEInformacao {
    private int id;
    private boolean comunicacaoAlternativa;
    private boolean tradutorInterprete;
    private boolean leitorTranscritor;
    private boolean interpreteOralizador;
    private boolean guiaInterprete;
    private boolean materialDidaticoBraille;
    private boolean materialDidaticoTextoAmpliado;
    private boolean materialDidaticoRelevo;
    private boolean leitorDeTela;
    private boolean fonteTamanhoEspecifico;

    public RecursosComunicacaoEInformacao() {
        this.comunicacaoAlternativa = false;
        this.tradutorInterprete = false;
        this.leitorTranscritor = false;
        this.interpreteOralizador = false;
        this.guiaInterprete = false;
        this.materialDidaticoBraille = false;
        this.materialDidaticoTextoAmpliado = false;
        this.materialDidaticoRelevo = false;
        this.leitorDeTela = false;
        this.fonteTamanhoEspecifico = false;
    }

    public RecursosComunicacaoEInformacao(boolean comunicacaoAlternativa, boolean tradutorInterprete, boolean leitorTranscritor,
                                          boolean interpreteOralizador, boolean guiaInterprete, boolean materialDidaticoBraille,
                                          boolean materialDidaticoTextoAmpliado, boolean materialDidaticoRelevo, boolean leitorDeTela,
                                          boolean fonteTamanhoEspecifico) {
        this.comunicacaoAlternativa = comunicacaoAlternativa;
        this.tradutorInterprete = tradutorInterprete;
        this.leitorTranscritor = leitorTranscritor;
        this.interpreteOralizador = interpreteOralizador;
        this.guiaInterprete = guiaInterprete;
        this.materialDidaticoBraille = materialDidaticoBraille;
        this.materialDidaticoTextoAmpliado = materialDidaticoTextoAmpliado;
        this.materialDidaticoRelevo = materialDidaticoRelevo;
        this.leitorDeTela = leitorDeTela;
        this.fonteTamanhoEspecifico = fonteTamanhoEspecifico;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public boolean isComunicacaoAlternativa() { return comunicacaoAlternativa; }
    public void setComunicacaoAlternativa(boolean comunicacaoAlternativa) { this.comunicacaoAlternativa = comunicacaoAlternativa; }

    public boolean isTradutorInterprete() { return tradutorInterprete; }
    public void setTradutorInterprete(boolean tradutorInterprete) { this.tradutorInterprete = tradutorInterprete; }

    public boolean isLeitorTranscritor() { return leitorTranscritor; }
    public void setLeitorTranscritor(boolean leitorTranscritor) { this.leitorTranscritor = leitorTranscritor; }

    public boolean isInterpreteOralizador() { return interpreteOralizador; }
    public void setInterpreteOralizador(boolean interpreteOralizador) { this.interpreteOralizador = interpreteOralizador; }

    public boolean isGuiaInterprete() { return guiaInterprete; }
    public void setGuiaInterprete(boolean guiaInterprete) { this.guiaInterprete = guiaInterprete; }

    public boolean isMaterialDidaticoBraille() { return materialDidaticoBraille; }
    public void setMaterialDidaticoBraille(boolean materialDidaticoBraille) { this.materialDidaticoBraille = materialDidaticoBraille; }

    public boolean isMaterialDidaticoTextoAmpliado() { return materialDidaticoTextoAmpliado; }
    public void setMaterialDidaticoTextoAmpliado(boolean materialDidaticoTextoAmpliado) { this.materialDidaticoTextoAmpliado = materialDidaticoTextoAmpliado; }

    public boolean isMaterialDidaticoRelevo() { return materialDidaticoRelevo; }
    public void setMaterialDidaticoRelevo(boolean materialDidaticoRelevo) { this.materialDidaticoRelevo = materialDidaticoRelevo; }

    public boolean isLeitorDeTela() { return leitorDeTela; }
    public void setLeitorDeTela(boolean leitorDeTela) { this.leitorDeTela = leitorDeTela; }

    public boolean isFonteTamanhoEspecifico() { return fonteTamanhoEspecifico; }
    public void setFonteTamanhoEspecifico(boolean fonteTamanhoEspecifico) { this.fonteTamanhoEspecifico = fonteTamanhoEspecifico; }

    public void adicionaNaDeficiencia(Deficiencia deficiencia, RecursosComunicacaoEInformacao recursosComunicacaoEInformacao){
        deficiencia.setComunicacaoEInformacao(recursosComunicacaoEInformacao);
    }
}
