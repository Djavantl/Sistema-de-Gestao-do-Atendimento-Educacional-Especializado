package org.incluemais.model.entities;

import java.sql.Connection;
import java.time.LocalDate;
import java.time.LocalTime;
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

    public ProfessorAEE(Connection conn) {
    }

    public ProfessorAEE() {

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

    public SessaoAtendimento marcarSessao(Aluno aluno, LocalDate data, LocalTime horario, String local){
        SessaoAtendimento sessao = new SessaoAtendimento(aluno, data, horario, local);

        return sessao;
    }

    public PlanoAEE criarPlano(ProfessorAEE professor, Aluno aluno, LocalDate dataInicio, String recomendacoes, String observacoes){
        PlanoAEE novoPlano = new PlanoAEE(professor, aluno, dataInicio, recomendacoes, observacoes);

        return novoPlano;
    }

    public Aluno criarAluno(String nome, LocalDate dataNascimento, String email, String sexo, String naturalidade, String telefone, String matricula, String responsavel,
                           String telResponsavel, String telTrabalho, String curso, String turma){
        Aluno aluno = new Aluno(nome, dataNascimento, email, sexo, naturalidade, telefone, matricula, responsavel, telResponsavel, telTrabalho, curso, turma);

        return aluno;
    }

    public Meta criarMeta(String descricao, String status) {
        Meta meta = new Meta(descricao, status);

        return meta;
    }


    public OrganizacaoAtendimento criarOrganizacaoAtendimento(
            String periodo, String duracao, String frequencia, String composicao, String tipo) {
        OrganizacaoAtendimento org = new OrganizacaoAtendimento(periodo, duracao, frequencia, composicao, tipo);

        return org;
    }


    public RecursoFisicoArquitetonico criarRecursoFisicoArquitetonico(
            boolean usoCadeiraDeRodas, boolean auxilioTranscricaoEscrita, boolean mesaAdaptadaCadeiraDeRodas,
            boolean usoDeMuleta, boolean outrosFisicoArquitetonico, String outrosEspecificado) {
        RecursoFisicoArquitetonico recursoFisicoArquitetonico = new RecursoFisicoArquitetonico(
                usoCadeiraDeRodas, auxilioTranscricaoEscrita, mesaAdaptadaCadeiraDeRodas,
                usoDeMuleta, outrosFisicoArquitetonico, outrosEspecificado);

        return recursoFisicoArquitetonico;
    }

    public RecursosComunicacaoEInformacao criarRecursosComunicacaoEInformacao(
            boolean comunicacaoAlternativa, boolean tradutorInterprete, boolean leitorTranscritor,
            boolean interpreteOralizador, boolean guiaInterprete, boolean materialDidaticoBraille,
            boolean materialDidaticoTextoAmpliado, boolean materialDidaticoRelevo, boolean leitorDeTela,
            boolean fonteTamanhoEspecifico) {
        RecursosComunicacaoEInformacao recursosComunicacaoEInformacao = new RecursosComunicacaoEInformacao(
                comunicacaoAlternativa, tradutorInterprete, leitorTranscritor, interpreteOralizador,
                guiaInterprete, materialDidaticoBraille, materialDidaticoTextoAmpliado, materialDidaticoRelevo,
                leitorDeTela, fonteTamanhoEspecifico);

        return recursosComunicacaoEInformacao;
    }

    public RecursosPedagogicos criarRecursosPedagogicos(
            boolean adaptacaoDidaticaAulasAvaliacoes, boolean materialDidaticoAdaptado,
            boolean usoTecnologiaAssistiva, boolean tempoEmpregadoAtividadesAvaliacoes) {
        RecursosPedagogicos recursosPedagogicos = new RecursosPedagogicos(
                adaptacaoDidaticaAulasAvaliacoes, materialDidaticoAdaptado, usoTecnologiaAssistiva,
                tempoEmpregadoAtividadesAvaliacoes);

        return recursosPedagogicos;
    }


    public List<ProfessorAEE> buscarTodos() {
        return List.of();
    }

    public ProfessorAEE buscarPorSiape(String professorAEE) {
        return null;
    }
}
