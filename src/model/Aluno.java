package model;


import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Aluno {
    private String nome;
    private String cpf;
    private String endereco;
    private LocalDate dataNascimento;
    private Deficiencia deficiencia;
    private List<PlanoAEE> planos = new ArrayList<>();
    private List<SessaoAtendimento> sessoes = new ArrayList<>();

    public Aluno(String nome, String cpf, String endereco, LocalDate dataNascimento, Deficiencia deficiencia) {
        this.endereco = endereco;
        this.dataNascimento = dataNascimento;
        this.deficiencia = deficiencia;
        this.cpf = cpf;
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
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

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }


}
