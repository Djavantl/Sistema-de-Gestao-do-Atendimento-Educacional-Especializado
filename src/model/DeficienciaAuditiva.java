package model;

class DeficienciaAuditiva extends Deficiencia {
    private boolean comunicacaoAlternativa;
    private boolean interpreteLibras;
    private boolean interpreteOralizador;
    private boolean guiaInterprete;

    public DeficienciaAuditiva(String descricao,
                               boolean comunicacaoAlternativa, boolean interpreteLibras,
                               boolean interpreteOralizador, boolean guiaInterprete) {
        super(descricao, "Auditiva");
        this.comunicacaoAlternativa = comunicacaoAlternativa;
        this.interpreteLibras = interpreteLibras;
        this.interpreteOralizador = interpreteOralizador;
        this.guiaInterprete = guiaInterprete;
    }

    public boolean isComunicacaoAlternativa() {
        return comunicacaoAlternativa;
    }

    public void setComunicacaoAlternativa(boolean comunicacaoAlternativa) {
        this.comunicacaoAlternativa = comunicacaoAlternativa;
    }

    public boolean isInterpreteLibras() {
        return interpreteLibras;
    }

    public void setInterpreteLibras(boolean interpreteLibras) {
        this.interpreteLibras = interpreteLibras;
    }

    public boolean isInterpreteOralizador() {
        return interpreteOralizador;
    }

    public void setInterpreteOralizador(boolean interpreteOralizador) {
        this.interpreteOralizador = interpreteOralizador;
    }

    public boolean isGuiaInterprete() {
        return guiaInterprete;
    }

    public void setGuiaInterprete(boolean guiaInterprete) {
        this.guiaInterprete = guiaInterprete;
    }

    public void definirAdaptacoes() {
        if (comunicacaoAlternativa) getAdaptacoes().add("Comunicação Aumentativa e Alternativa");
        if (interpreteLibras) getAdaptacoes().add("Tradutor Intérprete de Língua de Sinais");
        if (interpreteOralizador) getAdaptacoes().add("Intérprete oralizador");
        if (guiaInterprete) getAdaptacoes().add("Guia intérprete");
    }
}
