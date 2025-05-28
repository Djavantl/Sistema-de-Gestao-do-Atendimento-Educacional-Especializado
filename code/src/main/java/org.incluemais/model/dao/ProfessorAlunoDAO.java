package org.incluemais.model.dao;



import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Professor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ProfessorAlunoDAO {
    private final Connection conn;

    public ProfessorAlunoDAO(Connection connection) {
        this.conn = connection;
    }

    public List<Professor> getProfessoresByAluno(String alunoMatricula) throws SQLException {
        List<Professor> professores = new ArrayList<>();
        String sql = "SELECT " +
                "prof.siape, " +
                "prof.especialidade, " +
                "pes.nome, " +
                "pes.dataNascimento, " +
                "pes.email, " +
                "pes.sexo, " +
                "pes.naturalidade, " +
                "pes.telefone " +
                "FROM Professor_Aluno pa " +
                "JOIN Professor prof ON pa.professor_siape = prof.siape " +
                "JOIN Pessoa pes ON prof.pessoa_id = pes.id " +
                "WHERE pa.aluno_matricula = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, alunoMatricula);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    String nome = rs.getString("nome");
                    LocalDate dataNascimento = rs.getDate("dataNascimento").toLocalDate();
                    String email = rs.getString("email");
                    String sexo = rs.getString("sexo");
                    String naturalidade = rs.getString("naturalidade");
                    String telefone = rs.getString("telefone");
                    String siape = rs.getString("siape");
                    String especialidade = rs.getString("especialidade");

                    Professor professor = new Professor(
                            nome, dataNascimento, email, sexo,
                            naturalidade, telefone, siape, especialidade
                    );

                    professores.add(professor);
                }
            }
        }

        return professores;
    }

    public List<Aluno> getAlunosByProfessor(String siape) throws SQLException {
        List<Aluno> alunos = new ArrayList<>();
        String sql = "SELECT " +
                "a.matricula, a.curso, a.turma, a.responsavel, " +
                "a.telResponsavel, a.telTrabalho, " +
                "p.nome, p.dataNascimento, p.email, p.sexo, " +
                "p.naturalidade, p.telefone " +
                "FROM Professor_Aluno pa " +
                "JOIN Aluno a ON pa.aluno_matricula = a.matricula " +
                "JOIN Pessoa p ON a.pessoa_id = p.id " +
                "WHERE pa.professor_siape = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String nome = rs.getString("nome");
                LocalDate data = rs.getDate("dataNascimento").toLocalDate();
                String email = rs.getString("email");
                String sexo = rs.getString("sexo");
                String naturalidade = rs.getString("naturalidade");
                String telefone = rs.getString("telefone");

                String matricula = rs.getString("matricula");
                String responsavel = rs.getString("responsavel");
                String telResponsavel = rs.getString("telResponsavel");
                String telTrabalho = rs.getString("telTrabalho");
                String curso = rs.getString("curso");
                String turma = rs.getString("turma");

                Aluno aluno = new Aluno(nome, data, email, sexo, naturalidade, telefone,
                        matricula, curso, turma, responsavel, telResponsavel, telTrabalho);
                alunos.add(aluno);
            }
        }

        return alunos;
    }

    public void vincularProfessor(String siape, String matricula) throws SQLException {
        String sql = "INSERT INTO Professor_Aluno (professor_siape, aluno_matricula) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            stmt.setString(2, matricula);
            stmt.executeUpdate();
        }
    }

    public void desvincularProfessor(String siape, String matricula) throws SQLException {
        String sql = "DELETE FROM Professor_Aluno WHERE professor_siape = ? AND aluno_matricula = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            stmt.setString(2, matricula);
            stmt.executeUpdate();
        }
    }
}
