package model;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PlanoAEE {
    private int id;
    private LocalDate dataInicio;
    private LocalDate dataFim;
    private String estrategias;
    private String avaliacao;
    private List<Meta> metas = new ArrayList<>();
    private List<SessaoAtendimento> sessoes = new ArrayList<>();

    public PlanoAEE(LocalDate dataInicio, LocalDate dataFim, String estrategias) {
        this.dataInicio = dataInicio;
        this.dataFim = dataFim;
        this.estrategias = estrategias;
    }

    public LocalDate getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(LocalDate dataInicio) {
        this.dataInicio = dataInicio;
    }

    public LocalDate getDataFim() {
        return dataFim;
    }

    public void setDataFim(LocalDate dataFim) {
        this.dataFim = dataFim;
    }

    public String getEstrategias() {
        return estrategias;
    }

    public void setEstrategias(String estrategias) {
        this.estrategias = estrategias;
    }

    public String getAvaliacao() {
        return avaliacao;
    }

    public void setAvaliacao(String avaliacao) {
        this.avaliacao = avaliacao;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


}
