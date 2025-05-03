package model;

import java.time.LocalDate;
import java.time.LocalTime;

public class RegistroAusencia {
    private int id;
    private Aluno aluno;
    private LocalDate data;
    private String motivos;
    private String encaminhamento;

    public RegistroAusencia(Aluno aluno, LocalDate data, String motivos, String encaminhamento) {
        this.aluno = aluno;
        this.data = data;
        this.motivos = motivos;
        this.encaminhamento = encaminhamento;
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

    public String getMotivos() {
        return motivos;
    }

    public void setMotivos(String motivos) {
        this.motivos = motivos;
    }

    public String getEncaminhamento() {
        return encaminhamento;
    }

    public void setEncaminhamento(String encaminhamento) {
        this.encaminhamento = encaminhamento;
    }

    public void adicionarNaSessao(SessaoAtendimento sessao, RegistroAusencia ausencia){
        sessao.setAusencia(ausencia);
    }
}
