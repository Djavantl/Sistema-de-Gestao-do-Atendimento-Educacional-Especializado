package model;


import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Aluno extends Pessoa{
    private int matricula;
    private Deficiencia deficiencia;
    private List<PlanoAEE> planos = new ArrayList<>();

    public Aluno(String nome, String cpf, String endereco, LocalDate dataNascimento, String email, int nmrTelefone, Deficiencia deficiencia ) {
       super(nome, cpf, endereco, dataNascimento, email, nmrTelefone);
       this.deficiencia = deficiencia;
    }

    public void adicionarPlano(PlanoAEE plano){
        planos.add(plano);
    }
}
