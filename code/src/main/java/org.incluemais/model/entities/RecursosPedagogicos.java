package org.incluemais.model.entities;

public class RecursosPedagogicos {
    private int id;
    private boolean adaptacaoDidaticaAulasAvaliacoes;
    private boolean materialDidaticoAdaptado;
    private boolean usoTecnologiaAssistiva;
    private boolean tempoEmpregadoAtividadesAvaliacoes;

    public RecursosPedagogicos() {
        this.adaptacaoDidaticaAulasAvaliacoes = false;
        this.materialDidaticoAdaptado = false;
        this.usoTecnologiaAssistiva = false;
        this.tempoEmpregadoAtividadesAvaliacoes = false;
    }

    public RecursosPedagogicos(boolean adaptacaoDidaticaAulasAvaliacoes, boolean materialDidaticoAdaptado,
                               boolean usoTecnologiaAssistiva, boolean tempoEmpregadoAtividadesAvaliacoes) {
        this.adaptacaoDidaticaAulasAvaliacoes = adaptacaoDidaticaAulasAvaliacoes;
        this.materialDidaticoAdaptado = materialDidaticoAdaptado;
        this.usoTecnologiaAssistiva = usoTecnologiaAssistiva;
        this.tempoEmpregadoAtividadesAvaliacoes = tempoEmpregadoAtividadesAvaliacoes;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; } 

    public boolean isAdaptacaoDidaticaAulasAvaliacoes() { return adaptacaoDidaticaAulasAvaliacoes; }
    public void setAdaptacaoDidaticaAulasAvaliacoes(boolean adaptacaoDidaticaAulasAvaliacoes) { this.adaptacaoDidaticaAulasAvaliacoes = adaptacaoDidaticaAulasAvaliacoes; }

    public boolean isMaterialDidaticoAdaptado() { return materialDidaticoAdaptado; }
    public void setMaterialDidaticoAdaptado(boolean materialDidaticoAdaptado) { this.materialDidaticoAdaptado = materialDidaticoAdaptado; }

    public boolean isUsoTecnologiaAssistiva() { return usoTecnologiaAssistiva; }
    public void setUsoTecnologiaAssistiva(boolean usoTecnologiaAssistiva) { this.usoTecnologiaAssistiva = usoTecnologiaAssistiva; }

    public boolean isTempoEmpregadoAtividadesAvaliacoes() { return tempoEmpregadoAtividadesAvaliacoes; }
    public void setTempoEmpregadoAtividadesAvaliacoes(boolean tempoEmpregadoAtividadesAvaliacoes) { this.tempoEmpregadoAtividadesAvaliacoes = tempoEmpregadoAtividadesAvaliacoes; }

    public boolean temRecursos() {
        return adaptacaoDidaticaAulasAvaliacoes ||
                materialDidaticoAdaptado ||
                usoTecnologiaAssistiva ||
                tempoEmpregadoAtividadesAvaliacoes;
    }

}
