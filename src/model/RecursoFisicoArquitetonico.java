package model;

public class RecursoFisicoArquitetonico {
    private boolean usoCadeiraDeRodas;
    private boolean auxilioTranscricaoEscrita;
    private boolean mesaAdaptadaCadeiraDeRodas;
    private boolean usoDeMuleta;
    private boolean outrosFisicoArquitetonico;
    private String outrosEspecificado;

    public RecursoFisicoArquitetonico() {
        this.usoCadeiraDeRodas = false;
        this.auxilioTranscricaoEscrita = false;
        this.mesaAdaptadaCadeiraDeRodas = false;
        this.usoDeMuleta = false;
        this.outrosFisicoArquitetonico = false;
        this.outrosEspecificado = null;
    }

    public RecursoFisicoArquitetonico(boolean usoCadeiraDeRodas, boolean auxilioTranscricaoEscrita, boolean mesaAdaptadaCadeiraDeRodas,
                                      boolean usoDeMuleta, boolean outrosFisicoArquitetonico, String outrosEspecificado) {
        this.usoCadeiraDeRodas = usoCadeiraDeRodas;
        this.auxilioTranscricaoEscrita = auxilioTranscricaoEscrita;
        this.mesaAdaptadaCadeiraDeRodas = mesaAdaptadaCadeiraDeRodas;
        this.usoDeMuleta = usoDeMuleta;
        this.outrosFisicoArquitetonico = outrosFisicoArquitetonico;
        this.outrosEspecificado = outrosEspecificado;
    }

    public boolean isUsoCadeiraDeRodas() { return usoCadeiraDeRodas; }
    public void setUsoCadeiraDeRodas(boolean usoCadeiraDeRodas) { this.usoCadeiraDeRodas = usoCadeiraDeRodas; }

    public boolean isAuxilioTranscricaoEscrita() { return auxilioTranscricaoEscrita; }
    public void setAuxilioTranscricaoEscrita(boolean auxilioTranscricaoEscrita) { this.auxilioTranscricaoEscrita = auxilioTranscricaoEscrita; }

    public boolean isMesaAdaptadaCadeiraDeRodas() { return mesaAdaptadaCadeiraDeRodas; }
    public void setMesaAdaptadaCadeiraDeRodas(boolean mesaAdaptadaCadeiraDeRodas) { this.mesaAdaptadaCadeiraDeRodas = mesaAdaptadaCadeiraDeRodas; }

    public boolean isUsoDeMuleta() { return usoDeMuleta; }
    public void setUsoDeMuleta(boolean usoDeMuleta) { this.usoDeMuleta = usoDeMuleta; }

    public boolean isOutrosFisicoArquitetonico() { return outrosFisicoArquitetonico; }
    public void setOutrosFisicoArquitetonico(boolean outrosFisicoArquitetonico) { this.outrosFisicoArquitetonico = outrosFisicoArquitetonico; }

    public String getOutrosEspecificado() { return outrosEspecificado; }
    public void setOutrosEspecificado(String outrosEspecificado) { this.outrosEspecificado = outrosEspecificado; }

    public void adicionaNaDeficiencia(Deficiencia deficiencia, RecursoFisicoArquitetonico recurso ){
        deficiencia.setRecursoFisicoArquitetonico(recurso);
    }
}
