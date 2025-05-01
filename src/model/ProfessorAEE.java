package model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ProfessorAEE extends Pessoa {
    private String siape;
    private String especialidade;
    private List<Aluno> alunos = new ArrayList<>();

    public ProfessorAEE(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade, String telefone, String siape, String especialidade) {
        super(nome, dataNascimento, email, sexo, naturalidade, telefone);
        this.siape = siape;
        this.especialidade = especialidade;
    }

    public List<Aluno> getAlunos() {
        return alunos;
    }

    public void setAlunos(List<Aluno> alunos) {
        this.alunos = alunos;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
    }

    public String getSiape() {
        return siape;
    }

    public void setSiape(String siape) {
        this.siape = siape;
    }

    public void adicionarAluno(Aluno aluno){
        alunos.add(aluno);
    }

    public void marcarSessao(PlanoAEE plano,LocalDate data, String conteudo){
        SessaoAtendimento sessao = new SessaoAtendimento(data, conteudo);
        plano.registrarSessao(sessao);
    }

    public PlanoAEE criarPlano(Aluno aluno, LocalDate dataInicio, LocalDate dataFim, String estrategias){
        PlanoAEE novoPlano = new PlanoAEE(dataInicio, dataFim, estrategias);
        aluno.adicionarPlano(novoPlano);
        return novoPlano;
    }
}
