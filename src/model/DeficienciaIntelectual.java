package model;

public class DeficienciaIntelectual extends Deficiencia {
    private boolean necessitaApoioConstante;
    private boolean dificuldadeConcentracao;

    public DeficienciaIntelectual(String descricao, boolean necessitaApoioConstante, boolean dificuldadeConcentracao) {
        super(descricao, "Intelectual");
        this.necessitaApoioConstante = necessitaApoioConstante;
        this.dificuldadeConcentracao = dificuldadeConcentracao;
    }

    public boolean isNecessitaApoioConstante() {
        return necessitaApoioConstante;
    }

    public void setNecessitaApoioConstante(boolean necessitaApoioConstante) {
        this.necessitaApoioConstante = necessitaApoioConstante;
    }

    public boolean isDificuldadeConcentracao() {
        return dificuldadeConcentracao;
    }

    public void setDificuldadeConcentracao(boolean dificuldadeConcentracao) {
        this.dificuldadeConcentracao = dificuldadeConcentracao;
    }

    public void definirAdaptacoes() {
        if (necessitaApoioConstante) {
            getAdaptacoes().add("Apoio constante durante as atividades");
        }
        if (dificuldadeConcentracao) {
            getAdaptacoes().add("Conteúdo simplificado e com reforço constante");
        }
        getAdaptacoes().add("Apoio na organização das ideias");
        getAdaptacoes().add("Material de apoio visual");
        getAdaptacoes().add("Atividades práticas para facilitar o aprendizado");
        getAdaptacoes().add("Quebra de tarefas complexas em etapas menores");
        getAdaptacoes().add("Avaliações simplificadas com tempo reduzido");
        getAdaptacoes().add("Uso de tecnologia assistiva, como softwares educativos");
    }
}
