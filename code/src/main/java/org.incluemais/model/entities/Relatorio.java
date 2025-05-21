package org.incluemais.model.entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Relatorio {
    private int id;
    private String titulo;
    private LocalDate dataGeracao;
    private Aluno aluno;
    private ProfessorAEE professorAEE;
    private List<Avaliacao> avaliacoes = new ArrayList<>();
    private String resumo;
    private String observacoes;

    public Relatorio(String titulo, LocalDate dataGeracao, Aluno aluno, ProfessorAEE professorAEE, String resumo, String observacoes) {
        this.titulo = titulo;
        this.dataGeracao = dataGeracao;
        this.aluno = aluno;
        this.professorAEE = professorAEE;
        this.resumo = resumo;
        this.observacoes = observacoes;
    }

    public Relatorio() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public LocalDate getDataGeracao() {
        return dataGeracao;
    }

    public void setDataGeracao(LocalDate dataGeracao) {
        this.dataGeracao = dataGeracao;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public ProfessorAEE getProfessorAEE() {
        return professorAEE;
    }

    public void setProfessorAEE(ProfessorAEE professorAEE) {
        this.professorAEE = professorAEE;
    }

    public String getResumo() {
        return resumo;
    }

    public List<Avaliacao> getAvaliacoes() {
        return avaliacoes;
    }

    public void setAvaliacoes(List<Avaliacao> avaliacoes) {
        this.avaliacoes = avaliacoes;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }

    public void setResumo(String resumo) {
        this.resumo = resumo;
    }

    public void adicionarAoAluno(Aluno aluno, Relatorio relatorio){
        aluno.adicionarRelatorio(relatorio);
    }
}
