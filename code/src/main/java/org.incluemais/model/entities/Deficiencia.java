package org.incluemais.model.entities;

import java.util.ArrayList;
import java.util.List;

public class Deficiencia {
    private int id;
    private String nome;
    private String descricao;
    private  String grauSeveridade;
    private String cid;
    private Aluno aluno;


    public Deficiencia(int id, String nome, String descricao, String grauSeveridade, String cid, Aluno aluno) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.grauSeveridade = grauSeveridade;
        this.cid = cid;
        this.aluno = aluno;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getGrauSeveridade() {
        return grauSeveridade;
    }

    public void setGrauSeveridade(String grauSeveridade) {
        this.grauSeveridade = grauSeveridade;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public Aluno getAluno() {
        return aluno;
    }

    public void setAluno(Aluno aluno) {
        this.aluno = aluno;
    }
}
