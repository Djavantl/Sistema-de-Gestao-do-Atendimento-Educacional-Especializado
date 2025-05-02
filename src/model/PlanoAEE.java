package model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PlanoAEE {
    private int id;
    private Aluno aluno;
    private LocalDate dataInicio;
    private List<Meta> metas = new ArrayList<>();
    private List<PropostaPedagogica> propostaPedagogicas = new ArrayList<>();
    private AvaliacaoInicial avaliacao;
    private String recomendacoes;

    public PlanoAEE(Aluno aluno, LocalDate dataInicio, AvaliacaoInicial avaliacao, String recomendacoes) {
        this.aluno = aluno;
        this.dataInicio = dataInicio;
        this.avaliacao = avaliacao;
        this.recomendacoes = recomendacoes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public LocalDate getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(LocalDate dataInicio) {
        this.dataInicio = dataInicio;
    }

    public List<Meta> getMetas() {
        return metas;
    }

    public void setMetas(List<Meta> metas) {
        this.metas = metas;
    }

    public List<PropostaPedagogica> getPropostaPedagogicas() {
        return propostaPedagogicas;
    }

    public void setPropostaPedagogicas(List<PropostaPedagogica> propostaPedagogicas) {
        this.propostaPedagogicas = propostaPedagogicas;
    }

    public AvaliacaoInicial getAvaliacao() {
        return avaliacao;
    }

    public void setAvaliacao(AvaliacaoInicial avaliacao) {
        this.avaliacao = avaliacao;
    }

    public String getRecomendacoes() {
        return recomendacoes;
    }

    public void setRecomendacoes(String recomendacoes) {
        this.recomendacoes = recomendacoes;
    }

    public void  adicionarProposta(PropostaPedagogica proposta){
        propostaPedagogicas.add(proposta);
    }

    public void adicionarMeta(Meta meta){
        metas.add(meta);
    }

}
