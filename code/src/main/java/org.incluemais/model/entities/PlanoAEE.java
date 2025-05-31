package org.incluemais.model.entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PlanoAEE {
    private int id;
    private String professorSiape; // pode ser null
    private String alunoMatricula;
    private LocalDate dataInicio;
    private String recomendacoes;
    private String observacoes;
    private List<Meta> metas = new ArrayList<>();
    private PropostaPedagogica proposta;

    public PlanoAEE() {
    }

    public PlanoAEE(String professorSiape, String alunoMatricula, LocalDate dataInicio,
                    String recomendacoes, String observacoes) {
        this.professorSiape = professorSiape;
        this.alunoMatricula = alunoMatricula;
        this.dataInicio = dataInicio;
        this.recomendacoes = recomendacoes;
        this.observacoes = observacoes;
    }

    // Getters e Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProfessorSiape() {
        return professorSiape;
    }

    public void setProfessorSiape(String professorSiape) {
        this.professorSiape = professorSiape;
    }

    public String getAlunoMatricula() {
        return alunoMatricula;
    }

    public void setAlunoMatricula(String alunoMatricula) {
        this.alunoMatricula = alunoMatricula;
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