package entities;

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


    public Meta criarMeta(String descricao, String status) {
        Meta meta = new Meta(descricao, status);

        return meta;
    }


    public OrganizacaoAtendimento criarOrganizacaoAtendimento(
            String periodo, String duracao, String frequencia, String composicao, String tipo) {
        OrganizacaoAtendimento org = new OrganizacaoAtendimento(periodo, duracao, frequencia, composicao, tipo);

        return org;
    }

    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias);

        return proposta;
    }

    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias, RecursosPedagogicos recursos) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias, recursos);

        return proposta;
    }

    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias, RecursoFisicoArquitetonico recursos) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias, recursos);

        return proposta;
    }

    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias, RecursosComunicacaoEInformacao recursos) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias, recursos);

        return proposta;
    }

    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias, RecursosPedagogicos recursosP ,RecursosComunicacaoEInformacao recursosCI) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias, recursosP, recursosCI);

        return proposta;
    }

    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias, RecursosPedagogicos recursosP ,RecursoFisicoArquitetonico recursosFA) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias, recursosP, recursosFA);

        return proposta;
    }

    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias, RecursoFisicoArquitetonico recursosFA, RecursosComunicacaoEInformacao recursosCI) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias, recursosFA, recursosCI);

        return proposta;
    }

    public PropostaPedagogica criarPropostaPedagogica(
            String area, String objetivos, String metodologias, RecursosPedagogicos recursosP, RecursoFisicoArquitetonico recursosFA, RecursosComunicacaoEInformacao recursosCI) {
        PropostaPedagogica proposta = new PropostaPedagogica(area, objetivos, metodologias, recursosP, recursosFA, recursosCI);

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

}
