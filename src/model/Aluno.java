package model;
import java.time.LocalDate;

public class Aluno extends Pessoa {
    private String matricula;
    private String responsavel;
    private String telResponsavel;
    private String telTrabalho;

    public Aluno(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade,
                 String telefone,String matricula, String telResponsavel, String responsavel, String telTrabalho) {
        super(nome, dataNascimento, email, sexo, naturalidade, telefone);
        this.setTelefone(telefone);
        this.matricula = matricula;
        this.telResponsavel = telResponsavel;
        this.responsavel = responsavel;
        this.telTrabalho = telTrabalho;
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
}
