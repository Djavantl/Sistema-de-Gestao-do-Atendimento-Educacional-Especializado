package model;

public class DeficienciaAuditiva extends Deficiencia {
    private boolean usarLibras;
    private boolean usaAparelhoAuditivo;
    private boolean temOralizacao;

    public DeficienciaAuditiva(String descricao, boolean usarLibras, boolean usaAparelhoAuditivo, boolean temOralizacao) {
        super(descricao, "Auditiva");
        this.usarLibras = usarLibras;
        this.usaAparelhoAuditivo = usaAparelhoAuditivo;
        this.temOralizacao = temOralizacao;
    }

    public boolean isUsarLibras() {
        return usarLibras;
    }

    public void setUsarLibras(boolean usarLibras) {
        this.usarLibras = usarLibras;
    }

    public boolean isUsaAparelhoAuditivo() {
        return usaAparelhoAuditivo;
    }

    public void setUsaAparelhoAuditivo(boolean usaAparelhoAuditivo) {
        this.usaAparelhoAuditivo = usaAparelhoAuditivo;
    }

    public boolean isTemOralizacao() {
        return temOralizacao;
    }

    public void setTemOralizacao(boolean temOralizacao) {
        this.temOralizacao = temOralizacao;
    }

    public void definirAdaptacoes() {
        if (usarLibras) {
            getAdaptacoes().add("Intérprete de Libras");
        }
        if (usaAparelhoAuditivo) {
            getAdaptacoes().add("Uso de aparelho auditivo");
        }
        if (!temOralizacao) {
            getAdaptacoes().add("Material com apoio visual");
        }
        getAdaptacoes().add("Vídeos legendados");
    }
}
