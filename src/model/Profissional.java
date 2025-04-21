package model;
import model.Aluno;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Profissional {
    private int id;
    private String nome;
    private String especialidade;
    private String email;
    private List<Aluno> alunos = new ArrayList<>();

    public Profissional(String nome, String especialidade, String email) {
        this.nome = nome;
        this.especialidade = especialidade;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public PlanoAEE criarPlano(Aluno aluno, LocalDate dataInicio, LocalDate dataFim, String estrategias){
        PlanoAEE novoPlano = new PlanoAEE(dataInicio, dataFim, estrategias);
        aluno.adicionarPlano(novoPlano);
        return novoPlano;
    }
}
