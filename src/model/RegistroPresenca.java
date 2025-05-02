package model;

import java.time.LocalDate;
import java.time.LocalTime;

public class RegistroPresenca {
    private int id;
    private Aluno aluno;
    private LocalDate data;
    private LocalTime horiario;
    private String sinteseAtividades;

    public RegistroPresenca(Aluno aluno, LocalDate data, LocalTime horiario, String sinteseAtividades) {
        this.aluno = aluno;
        this.data = data;
        this.horiario = horiario;
        this.sinteseAtividades = sinteseAtividades;
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

    public LocalTime getHoriario() {
        return horiario;
    }

    public void setHoriario(LocalTime horiario) {
        this.horiario = horiario;
    }

    public String getSinteseAtividades() {
        return sinteseAtividades;
    }

    public void setSinteseAtividades(String sinteseAtividades) {
        this.sinteseAtividades = sinteseAtividades;
    }
}
