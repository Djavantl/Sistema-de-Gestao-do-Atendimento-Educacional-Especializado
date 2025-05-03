package model;

import java.time.LocalDate;
import java.time.LocalTime;

public class SessaoAtendimento {
    private int id;
    private Aluno aluno;
    private LocalDate data;
    private LocalTime horario;
    private String local;
    private RegistroPresenca presenca;
    private RegistroAusencia ausencia;
    private String participantes;

    public SessaoAtendimento(Aluno aluno, LocalDate data, LocalTime horario, String local, String participantes) {
        this.aluno = aluno;
        this.data = data;
        this.horario = horario;
        this.local = local;
        this.participantes = participantes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public LocalTime getHorario() {
        return horario;
    }

    public void setHorario(LocalTime horario) {
        this.horario = horario;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        this.local = local;
    }

    public RegistroPresenca getPresenca() {
        return presenca;
    }

    public void setPresenca(RegistroPresenca presenca) {
        this.presenca = presenca;
    }

    public RegistroAusencia getAusencia() {
        return ausencia;
    }

    public void setAusencia(RegistroAusencia ausencia) {
        this.ausencia = ausencia;
    }

    public String getParticipantes() {
        return participantes;
    }

    public void setParticipantes(String participantes) {
        this.participantes = participantes;
    }

    public void adionarNoRelatorio(Relatorio relatorio, SessaoAtendimento sessao){
        relatorio.registrarSessao(sessao);
    }
}
