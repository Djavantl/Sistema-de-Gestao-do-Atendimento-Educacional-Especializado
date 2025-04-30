package model;
import java.time.LocalDate;

public class Pessoa {
    private String nome;
    private LocalDate dataNascimento;
    private String email;
    private String sexo;
    private String naturalidade;
    private String telefone;

    public Pessoa(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade, String telefone) {
        this.nome = nome;
        this.dataNascimento = dataNascimento;
        this.email = email;
        this.sexo = sexo;
        this.naturalidade = naturalidade;
        this.telefone = telefone;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }

    public String getNaturalidade() {
        return naturalidade;
    }

    public void setNaturalidade(String naturalidade) {
        this.naturalidade = naturalidade;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
}
