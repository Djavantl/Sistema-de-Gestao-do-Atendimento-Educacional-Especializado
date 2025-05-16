package org.incluemais.model.entities;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Aluno extends Pessoa {
    private String matricula;
    private String responsavel;
    private String telResponsavel;
    private String telTrabalho;
    private String curso;
    private String turma;
    private List<Deficiencia> deficiencias = new ArrayList<>();
    private List<Relatorio> relatorios = new ArrayList<>();
    private List<Professor> professores = new ArrayList<>();

    public Aluno() {
    }

    public Aluno(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade, String telefone,
                 String matricula, String responsavel, String telResponsavel, String telTrabalho, String curso, String turma) {
        super(nome, dataNascimento, email, sexo, naturalidade, telefone);
        this.matricula = matricula;
        this.responsavel = responsavel;
        this.telResponsavel = telResponsavel;
        this.telTrabalho = telTrabalho;
        this.curso = curso;
        this.turma = turma;
    }

    public Aluno(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade, String telefone, String matricula, String responsavel, String telResponsavel, String curso, String turma) {
        super(nome, dataNascimento, email, sexo, naturalidade, telefone);
        this.matricula = matricula;
        this.responsavel = responsavel;
        this.telResponsavel = telResponsavel;
        this.curso = curso;
        this.turma = turma;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getResponsavel() {
        return responsavel;
    }

    public void setResponsavel(String responsavel) {
        this.responsavel = responsavel;
    }

    public String getTelResponsavel() {
        return telResponsavel;
    }

    public void setTelResponsavel(String telResponsavel) {
        this.telResponsavel = telResponsavel;
    }

    public String getTelTrabalho() {
        return telTrabalho;
    }

    public void setTelTrabalho(String telTrabalho) {
        this.telTrabalho = telTrabalho;
    }


    public String getCurso() {
        return curso;
    }

    public void setCurso(String curso) {
        this.curso = curso;
    }

    public String getTurma() {
        return turma;
    }

    public void setTurma(String turma) {
        this.turma = turma;
    }

    public List<Relatorio> getRelatorios() {
        return relatorios;
    }

    public void setRelatorios(List<Relatorio> relatorios) {
        this.relatorios = relatorios;
    }

    public List<Professor> getProfessores() {
        return professores;
    }

    public void setProfessores(List<Professor> professores) {
        this.professores = professores;
    }

    public List<Deficiencia> getDeficiencias() {
        return deficiencias;
    }

    public void setDeficiencias(List<Deficiencia> deficiencias) {
        this.deficiencias = deficiencias;
    }

    public void adicionarRelatorio(Relatorio relatorio){
        this.relatorios.add(relatorio);
    }

    public void adicionarProfessor(Professor professor){
        this.professores.add(professor);
    }

    public void adicionarDeficiencia(Deficiencia def){ this.deficiencias.add(def); }
}
