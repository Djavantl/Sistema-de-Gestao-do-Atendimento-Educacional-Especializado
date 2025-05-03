package model;

class DeficienciaVisual extends Deficiencia {
    private boolean leitorTela;
    private boolean ledor;
    private boolean ledorOralizador;
    private boolean braille;
    private boolean relevo;
    private boolean textoAmpliado;
    private String tamanhoFonte;

    public DeficienciaVisual(String descricao,
                             boolean leitorTela, boolean ledor,
                             boolean ledorOralizador, boolean braille,
                             boolean relevo, boolean textoAmpliado, String tamanhoFonte) {
        super(descricao, "Visual");
        this.leitorTela = leitorTela;
        this.ledor = ledor;
        this.ledorOralizador = ledorOralizador;
        this.braille = braille;
        this.relevo = relevo;
        this.textoAmpliado = textoAmpliado;
        this.tamanhoFonte = tamanhoFonte;
    }

    public boolean isLeitorTela() {
        return leitorTela;
    }

    public void setLeitorTela(boolean leitorTela) {
        this.leitorTela = leitorTela;
    }

    public boolean isLedor() {
        return ledor;
    }

    public void setLedor(boolean ledor) {
        this.ledor = ledor;
    }

    public boolean isLedorOralizador() {
        return ledorOralizador;
    }

    public void setLedorOralizador(boolean ledorOralizador) {
        this.ledorOralizador = ledorOralizador;
    }

    public boolean isBraille() {
        return braille;
    }

    public void setBraille(boolean braille) {
        this.braille = braille;
    }

    public boolean isRelevo() {
        return relevo;
    }

    public void setRelevo(boolean relevo) {
        this.relevo = relevo;
    }

    public boolean isTextoAmpliado() {
        return textoAmpliado;
    }

    public void setTextoAmpliado(boolean textoAmpliado) {
        this.textoAmpliado = textoAmpliado;
    }

    public String getTamanhoFonte() {
        return tamanhoFonte;
    }

    public void setTamanhoFonte(String tamanhoFonte) {
        this.tamanhoFonte = tamanhoFonte;
    }

    public void definirAdaptacoes() {
        if (leitorTela) getAdaptacoes().add("Leitor de tela");
        if (ledor) getAdaptacoes().add("Ledor / Transcritor");
        if (ledorOralizador) getAdaptacoes().add("Ledor oralizador");
        if (braille) getAdaptacoes().add("Material didático em Braille");
        if (relevo) getAdaptacoes().add("Material didático em relevo");
        if (textoAmpliado) {
            String texto = "Material didático com texto ampliado";
            if (tamanhoFonte != null && !tamanhoFonte.isBlank()) {
                texto += " (Fonte tamanho: " + tamanhoFonte + ")";
            }
            getAdaptacoes().add(texto);
        }
    }
}
