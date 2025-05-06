package org.incluemais.model.entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Professor extends Pessoa {
    private String siape;
    private String especialidade;
    private List<Aluno> alunos = new ArrayList<>();

    public Professor(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade, String telefone, String siape, String especialidade) {
        super(nome, dataNascimento, email, sexo, naturalidade, telefone);
        this.siape = siape;
        this.especialidade = especialidade;
    }

    public Professor() {
        super("", LocalDate.now(), "", "", "", "");
    }

    public String getSiape() {
        return siape;
    }

    public void setSiape(String siape) {
        this.siape = siape;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
    }

    public List<Aluno> getAlunos() {
        return alunos;
    }

    public void setAlunos(List<Aluno> alunos) {
        this.alunos = alunos;
    }

    public void adicionarAluno(Aluno aluno) {
        alunos.add(aluno);
    }

    public void removerAluno(String matricula) {
        alunos.removeIf(aluno -> aluno.getMatricula().equals(matricula));
    }

    public Aluno consultarAluno(String matricula) {
        for (Aluno aluno : alunos) {
            if (aluno.getMatricula().equals(matricula)) {
                return aluno;
            }
        }
        return null;
    }

    public void adicionarAoAluno(Aluno aluno, Professor professor){
        aluno.adicionarProfessor(professor);
    }
}
