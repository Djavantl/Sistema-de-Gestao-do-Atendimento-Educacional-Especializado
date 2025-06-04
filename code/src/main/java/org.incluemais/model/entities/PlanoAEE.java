package org.incluemais.model.entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PlanoAEE {
    private int id;
    private ProfessorAEE professorAEE;
    private Aluno aluno;
    private LocalDate dataInicio;
    private String recomendacoes;
    private String observacoes;
    private List<Meta> metas;
    private PropostaPedagogica proposta;

    public PlanoAEE() {
    }

    // Construtor atualizado
    public PlanoAEE(ProfessorAEE professorAEE, Aluno aluno, LocalDate dataInicio,
                    String recomendacoes, String observacoes) {
        this.professorAEE = professorAEE;
        this.aluno = aluno;
        this.dataInicio = dataInicio;
        this.recomendacoes = recomendacoes;
        this.observacoes = observacoes;
    }

    // Getters e Setters atualizados
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ProfessorAEE getProfessorAEE() {
        return professorAEE;
    }

    public void setProfessorAEE(ProfessorAEE professorAEE) {
        this.professorAEE = professorAEE;
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

    public String getRecomendacoes() {
        return recomendacoes;
    }

    public void setRecomendacoes(String recomendacoes) {
        this.recomendacoes = recomendacoes;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public List<Meta> getMetas() {
        return metas;
    }

    public void setMetas(List<Meta> metas) {
        this.metas = metas;
    }

    public PropostaPedagogica getProposta() {
        return proposta;
    }

    public void setProposta(PropostaPedagogica proposta) {
        this.proposta = proposta;
    }

    public void adicionarMeta(Meta meta) {
        this.metas.add(meta);
    }

    public void removerMeta(Meta meta) {
        this.metas.remove(meta);
    }
}