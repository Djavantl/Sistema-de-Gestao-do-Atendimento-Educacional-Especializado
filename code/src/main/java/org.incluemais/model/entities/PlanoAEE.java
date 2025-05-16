package org.incluemais.model.entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PlanoAEE {
    private int id;
    private ProfessorAEE professorResponsavel;
    private Aluno aluno;
    private LocalDate dataInicio;
    private List<Meta> metas = new ArrayList<>();
    private List<PropostaPedagogica> propostaPedagogicas = new ArrayList<>();
    private String recomendacoes;
    private String observacoes;

    public PlanoAEE(ProfessorAEE professor, Aluno aluno, LocalDate dataInicio, String recomendacoes, String observacoes) {
        this.professorResponsavel = professor;
        this.aluno = aluno;
        this.dataInicio = dataInicio;
        this.recomendacoes = recomendacoes;
        this.observacoes = observacoes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ProfessorAEE getProfessorResponsavel() { return professorResponsavel; }

    public void setProfessorResponsavel(ProfessorAEE professorResponsavel) { this.professorResponsavel = professorResponsavel; }

    public String getObservacoes() {return observacoes; }

    public void setObservacoes(String observacoes) { this.observacoes = observacoes; }

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

    public void setPropostaPedagogicas(List<PropostaPedagogica> propostaPedagogicas) { this.propostaPedagogicas = propostaPedagogicas; }

    public String getRecomendacoes() {
        return recomendacoes;
    }

    public void setRecomendacoes(String recomendacoes) {
        this.recomendacoes = recomendacoes;
    }

    public void  adicionarProposta(PropostaPedagogica proposta){
        this.propostaPedagogicas.add(proposta);
    }

    public void adicionarMeta(Meta meta){
        this.metas.add(meta);
    }

}
