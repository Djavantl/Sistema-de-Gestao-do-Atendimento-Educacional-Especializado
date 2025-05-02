package model;
import java.time.LocalDate;

public class Aluno extends Pessoa {
    private String matricula;
    private String responsavel;
    private String telResponsavel;
    private String telTrabalho;
    private OrganizacaoAtendimento organizacao;
    private String curso;
    private String turma;
    private PlanoAEE plano;

    public Aluno(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade, String telefone, String matricula, String responsavel,
                 String telResponsavel, String telTrabalho, OrganizacaoAtendimento organizacao, String curso, String turma) {
        super(nome, dataNascimento, email, sexo, naturalidade, telefone);
        this.matricula = matricula;
        this.responsavel = responsavel;
        this.telResponsavel = telResponsavel;
        this.telTrabalho = telTrabalho;
        this.organizacao = organizacao;
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

    public OrganizacaoAtendimento getOrganizacao() {
        return organizacao;
    }

    public void setOrganizacao(OrganizacaoAtendimento organizacao) {
        this.organizacao = organizacao;
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

    public PlanoAEE getPlano() {
        return plano;
    }

    public void setPlano(PlanoAEE plano) {
        this.plano = plano;
    }

    public void adicionarOrganizacao(OrganizacaoAtendimento org){
        this.organizacao = org;
    }

    public void adicionarPlano(PlanoAEE plano){
        this.plano = plano;
    }
}
