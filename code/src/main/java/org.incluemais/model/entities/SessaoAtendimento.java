package org.incluemais.model.entities;

import java.time.LocalDate;
import java.time.LocalTime;

public class SessaoAtendimento {
    private int id;
    private Aluno aluno;
    private LocalDate data;
    private LocalTime horario;
    private String local;
    private boolean presenca;
    private String observacoes;

    public SessaoAtendimento(Aluno aluno, LocalDate data, LocalTime horario, String local) {
        this.aluno = aluno;
        this.data = data;
        this.horario = horario;
        this.local = local;
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

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public LocalTime getHorario() {
        return horario;
    }

    public void setHorario(LocalTime horario) {
        this.horario = horario;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        this.local = local;
    }

    public boolean isPresenca() {
        return presenca;
    }

    public void setPresenca(boolean presenca) {
        this.presenca = presenca;
    }

    public String getObservacoes() {
        return observacoes;
    }

    public void setObservacoes(String observacoes) {
        this.observacoes = observacoes;
    }
}