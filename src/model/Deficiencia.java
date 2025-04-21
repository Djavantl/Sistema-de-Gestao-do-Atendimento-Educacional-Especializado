package model;
import java.util.ArrayList;
import java.util.List;

public class Deficiencia {
    private String nome;
    private String descricao;
    private String tipoDeficiciencia;
    private List<String> adaptacoes = new ArrayList<>();

    public Deficiencia(String nome, String descricao, String tipoDeficiciencia) {
        this.nome = nome;
        this.descricao = descricao;
        this.tipoDeficiciencia = tipoDeficiciencia;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getTipoDeficiciencia() {
        return tipoDeficiciencia;
    }

    public void setTipoDeficiciencia(String tipoDeficiciencia) {
        this.tipoDeficiciencia = tipoDeficiciencia;
    }

    public void definirAdaptacoes(String adaptacao){
        adaptacoes.add(adaptacao);
    }

}
