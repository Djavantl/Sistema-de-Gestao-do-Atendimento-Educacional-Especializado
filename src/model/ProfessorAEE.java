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

    public SessaoAtendimento marcarSessao(Aluno aluno, LocalDate data, LocalTime horario, String local, String participantes, Relatorio realtorio ){
        SessaoAtendimento sessao = new SessaoAtendimento(aluno, data, horario, local, participantes);
        realtorio.registrarSessao(sessao);

        return sessao;
    }

    public PlanoAEE criarPlano(Aluno aluno, LocalDate dataInicio, AvaliacaoInicial avaliacao, String recomendacoes){
        PlanoAEE novoPlano = new PlanoAEE(aluno, dataInicio, avaliacao, recomendacoes);
        aluno.adicionarPlano(novoPlano);

        return novoPlano;
    }

    public Aluno criarAluno(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade, String telefone, String matricula, String responsavel,
                           String telResponsavel, String telTrabalho, String curso, String turma){
        Aluno aluno = new Aluno(nome, dataNascimento, email, sexo, naturalidade, telefone, matricula, responsavel, telResponsavel, telTrabalho, curso, turma);

        return aluno;
    }

    public AvaliacaoInicial criarAvaliacaoInicial(String area, String desempenhoVerificado, String observacoes) {
        AvaliacaoInicial avaliacao = new AvaliacaoInicial(area, desempenhoVerificado, observacoes);

        return avaliacao;
    }


    public AvaliacaoFinal criarAvaliacaoFinal(String alcancadoArea, String naoAlcancadoArea, String relatorioFinal) {
        AvaliacaoFinal avaliacao = new AvaliacaoFinal(alcancadoArea, naoAlcancadoArea, relatorioFinal);

        return avaliacao;
    }


    public Meta criarMeta(String descricao, LocalDate dataLimite, String status) {
        Meta meta = new Meta(descricao, dataLimite, status);

        return meta;
    }


    public OrganizacaoAtendimento criarOrganizacaoAtendimento(
            String periodo, String duracao, String frequencia, String composicao, String tipo) {
        OrganizacaoAtendimento org = new OrganizacaoAtendimento(periodo, duracao, frequencia, composicao, tipo);

        return org;
    }


    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias, RecursosPedagogicos recursos) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias, recursos);

        return proposta;
    }


    public RegistroAusencia criarRegistroAusencia(Aluno aluno, LocalDate data, String motivos, String encaminhamento) {
        RegistroAusencia registro = new RegistroAusencia(aluno, data, motivos, encaminhamento);

        return registro;
    }


    public RegistroPresenca criarRegistroPresenca(Aluno aluno, LocalDate data, LocalTime horario, String sinteseAtividades) {
        RegistroPresenca registro = new RegistroPresenca(aluno, data, horario, sinteseAtividades);

        return registro;
    }

    // **Relatório**
    public Relatorio criarRelatorio(String titulo, LocalDate dataGeracao, Aluno aluno, String resumo) {
        Relatorio relatorio = new Relatorio(titulo, dataGeracao, aluno, this, resumo);

        return relatorio;
    }


    public Relatorio criarRelatorioComAvaliacaoInicial(
            String titulo, LocalDate dataGeracao, Aluno aluno, AvaliacaoInicial avaliacaoInicial, String resumo) {
        Relatorio relatorio = new Relatorio(titulo, dataGeracao, aluno, this, avaliacaoInicial, resumo);

        return relatorio;
    }

    public Relatorio criarRelatorioComAvaliacoes(String titulo, LocalDate dataGeracao, Aluno aluno, AvaliacaoInicial avaliacaoInicial, AvaliacaoProcessual avaliacaoProcessual, String resumo) {
        Relatorio relatorio = new Relatorio(titulo, dataGeracao, aluno, this, avaliacaoInicial, avaliacaoProcessual, resumo);

        return relatorio;
    }



    public Relatorio criarRelatorioCompleto(
            String titulo, LocalDate dataGeracao, Aluno aluno,
            AvaliacaoInicial avaliacaoInicial, AvaliacaoProcessual avaliacaoProcessual,
            AvaliacaoFinal avaliacaoFinal, String resumo) {
        Relatorio relatorio = new Relatorio(
                titulo, dataGeracao, aluno, this, avaliacaoInicial, avaliacaoProcessual, avaliacaoFinal, resumo);

        return relatorio;
    }
}
