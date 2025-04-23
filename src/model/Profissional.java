package model;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Profissional extends Pessoa{
    private int id;
    private String especialidade;
    private List<Aluno> alunos = new ArrayList<>();

    public Profissional(String nome, String cpf, String endereco, LocalDate dataNascimento, String email, int nmrTelefone, String especialidade) {
        super(nome, cpf, endereco, dataNascimento, email, nmrTelefone);
        this.especialidade = especialidade;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
    }

    public PlanoAEE criarPlano(Aluno aluno, LocalDate dataInicio, LocalDate dataFim, String estrategias){
        PlanoAEE novoPlano = new PlanoAEE(dataInicio, dataFim, estrategias);
        aluno.adicionarPlano(novoPlano);
        return novoPlano;
    }

    public void adicionarAluno(Aluno aluno){
        alunos.add(aluno);
    }

    public void marcarSessao(PlanoAEE plano,LocalDate data, String conteudo){
        SessaoAtendimento sessao = new SessaoAtendimento(data, conteudo);
        plano.registrarSessao(sessao);
    }
}
