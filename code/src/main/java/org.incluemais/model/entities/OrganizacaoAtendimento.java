package org.incluemais.model.entities;

public class OrganizacaoAtendimento {
    private int id;
    private String periodo;
    private String duracao;
    private String frequencia;
    private String composicao;
    private String tipo;

    public OrganizacaoAtendimento(String periodo, String duracao, String frequencia, String composicao, String tipo) {
        this.periodo = periodo;
        this.duracao = duracao;
        this.frequencia = frequencia;
        this.composicao = composicao;
        this.tipo = tipo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPeriodo() {
        return periodo;
    }

    public void setPeriodo(String periodo) {
        this.periodo = periodo;
    }

    public String getDuracao() {
        return duracao;
    }

    public void setDuracao(String duracao) {
        this.duracao = duracao;
    }

    public String getFrequencia() {
        return frequencia;
    }

    public void setFrequencia(String frequencia) {
        this.frequencia = frequencia;
    }

    public String getComposicao() {
        return composicao;
    }

    public void setComposicao(String composicao) {
        this.composicao = composicao;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public void inserirEmAluno(Aluno aluno, OrganizacaoAtendimento organizacaoAtendimento){
        aluno.setOrganizacao(organizacaoAtendimento);
    }
}
