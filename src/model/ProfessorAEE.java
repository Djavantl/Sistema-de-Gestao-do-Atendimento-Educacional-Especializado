package model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalTime;

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

    public void marcarSessao(Aluno aluno, LocalDate data, LocalTime horario, String local, String participantes, Relatorio realtorio ){
        SessaoAtendimento sessao = new SessaoAtendimento(aluno, data, horario, local, participantes);
        realtorio.registrarSessao(sessao);
    }

    public void criarPlano(Aluno aluno, LocalDate dataInicio, AvaliacaoInicial avaliacao, String recomendacoes){
        PlanoAEE novoPlano = new PlanoAEE(aluno, dataInicio, avaliacao, recomendacoes);
        aluno.adicionarPlano(novoPlano);
    }
}
