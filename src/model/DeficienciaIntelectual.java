package model;

class DeficienciaIntelectual extends Deficiencia {
    private boolean adaptacaoDidatica;
    private boolean materialAdaptado;
    private boolean tecnologiaAssistiva;
    private boolean tempoAmpliado;

    public DeficienciaIntelectual(String descricao,
                                  boolean adaptacaoDidatica, boolean materialAdaptado,
                                  boolean tecnologiaAssistiva, boolean tempoAmpliado) {
        super(descricao, "Intelectual");
        this.adaptacaoDidatica = adaptacaoDidatica;
        this.materialAdaptado = materialAdaptado;
        this.tecnologiaAssistiva = tecnologiaAssistiva;
        this.tempoAmpliado = tempoAmpliado;
    }

    public boolean isAdaptacaoDidatica() {
        return adaptacaoDidatica;
    }

    public void setAdaptacaoDidatica(boolean adaptacaoDidatica) {
        this.adaptacaoDidatica = adaptacaoDidatica;
    }

    public boolean isMaterialAdaptado() {
        return materialAdaptado;
    }

    public void setMaterialAdaptado(boolean materialAdaptado) {
        this.materialAdaptado = materialAdaptado;
    }

    public boolean isTecnologiaAssistiva() {
        return tecnologiaAssistiva;
    }

    public void setTecnologiaAssistiva(boolean tecnologiaAssistiva) {
        this.tecnologiaAssistiva = tecnologiaAssistiva;
    }

    public boolean isTempoAmpliado() {
        return tempoAmpliado;
    }

    public void setTempoAmpliado(boolean tempoAmpliado) {
        this.tempoAmpliado = tempoAmpliado;
    }

    public void definirAdaptacoes() {
        if (adaptacaoDidatica) getAdaptacoes().add("Adaptação didática durante as aulas e avaliações");
        if (materialAdaptado) getAdaptacoes().add("Material didático adaptado");
        if (tecnologiaAssistiva) getAdaptacoes().add("Uso de Tecnologia Assistiva durante as aulas ou avaliações");
        if (tempoAmpliado) getAdaptacoes().add("Tempo ampliado para realização de atividades e avaliações");
    }
}
