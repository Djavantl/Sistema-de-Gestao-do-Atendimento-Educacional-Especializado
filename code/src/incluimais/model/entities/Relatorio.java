package entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Relatorio {
    private int id;
    private String titulo;
    private LocalDate dataGeracao;
    private Aluno aluno;
    private ProfessorAEE professorAEE;
    private AvaliacaoInicial avaliacaoInicial;
    private AvaliacaoProcessual avaliacaoProcessual;
    private AvaliacaoFinal avaliacaoFinal;
    private String resumo;
    private List<SessaoAtendimento> sessoes = new ArrayList<>();

    public Relatorio(String titulo, LocalDate dataGeracao, Aluno aluno, ProfessorAEE professorAEE, String resumo) {
        this.titulo = titulo;
        this.dataGeracao = dataGeracao;
        this.aluno = aluno;
        this.professorAEE = professorAEE;
        this.resumo = resumo;
    }

    public Relatorio(String titulo, LocalDate dataGeracao, Aluno aluno, ProfessorAEE professorAEE, AvaliacaoInicial avaliacaoInicial, String resumo) {
        this.titulo = titulo;
        this.dataGeracao = dataGeracao;
        this.aluno = aluno;
        this.professorAEE = professorAEE;
        this.avaliacaoInicial = avaliacaoInicial;
        this.resumo = resumo;
    }

    public Relatorio(String titulo, LocalDate dataGeracao, Aluno aluno, ProfessorAEE professorAEE, AvaliacaoInicial avaliacaoInicial, AvaliacaoProcessual avaliacaoProcessual, String resumo) {
        this.titulo = titulo;
        this.dataGeracao = dataGeracao;
        this.aluno = aluno;
        this.professorAEE = professorAEE;
        this.avaliacaoInicial = avaliacaoInicial;
        this.avaliacaoProcessual = avaliacaoProcessual;
        this.resumo = resumo;
    }

    public Relatorio(String titulo, LocalDate dataGeracao, Aluno aluno, ProfessorAEE professorAEE, AvaliacaoInicial avaliacaoInicial, AvaliacaoProcessual avaliacaoProcessual, AvaliacaoFinal avaliacaoFinal, String resumo) {
        this.titulo = titulo;
        this.dataGeracao = dataGeracao;
        this.aluno = aluno;
        this.professorAEE = professorAEE;
        this.avaliacaoInicial = avaliacaoInicial;
        this.avaliacaoProcessual = avaliacaoProcessual;
        this.avaliacaoFinal = avaliacaoFinal;
        this.resumo = resumo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public LocalDate getDataGeracao() {
        return dataGeracao;
    }

    public void setDataGeracao(LocalDate dataGeracao) {
        this.dataGeracao = dataGeracao;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public ProfessorAEE getProfessorAEE() {
        return professorAEE;
    }

    public void setProfessorAEE(ProfessorAEE professorAEE) {
        this.professorAEE = professorAEE;
    }

    public AvaliacaoInicial getAvaliacaoInicial() {
        return avaliacaoInicial;
    }

    public void setAvaliacaoInicial(AvaliacaoInicial avaliacaoInicial) {
        this.avaliacaoInicial = avaliacaoInicial;
    }

    public AvaliacaoProcessual getAvaliacaoProcessual() {
        return avaliacaoProcessual;
    }

    public void setAvaliacaoProcessual(AvaliacaoProcessual avaliacaoProcessual) {
        this.avaliacaoProcessual = avaliacaoProcessual;
    }

    public AvaliacaoFinal getAvaliacaoFinal() {
        return avaliacaoFinal;
    }

    public void setAvaliacaoFinal(AvaliacaoFinal avaliacaoFinal) {
        this.avaliacaoFinal = avaliacaoFinal;
    }

    public String getResumo() {
        return resumo;
    }

    public void setResumo(String resumo) {
        this.resumo = resumo;
    }

    public List<SessaoAtendimento> getSessoes() {
        return sessoes;
    }

    public void setSessoes(List<SessaoAtendimento> sessoes) {
        this.sessoes = sessoes;
    }

    public void registrarSessao(SessaoAtendimento sessao){
        sessoes.add(sessao);
    }

    public void removerSessao(SessaoAtendimento sessao){
        sessoes.remove(sessao);
    }

    public void adicionarAoAluno(Aluno aluno, Relatorio relatorio){
        aluno.adicionarRelatorio(relatorio);
    }
}
