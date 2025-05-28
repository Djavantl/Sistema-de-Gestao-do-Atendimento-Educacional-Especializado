package org.incluemais.model.entities;

import java.time.LocalDate;

public class ProfessorAEE extends Pessoa {
    private String siape;
    private String especialidade;

    public ProfessorAEE(String nome, LocalDate dataNascimento, String email,
                        String sexo, String naturalidade, String telefone,
                        String siape, String especialidade) {
        super(nome, dataNascimento, email, sexo, naturalidade, telefone);
        this.siape = siape;
        this.especialidade = especialidade;
    }

    public ProfessorAEE() {
        super("", LocalDate.now(), "", "", "", "");
    }

    public String getSiape() {
        return siape;
    }

    public void setSiape(String siape) {
        this.siape = siape;
    }

    public String getEspecialidade() {
        return especialidade;
    }

    public void setEspecialidade(String especialidade) {
        this.especialidade = especialidade;
    }
}