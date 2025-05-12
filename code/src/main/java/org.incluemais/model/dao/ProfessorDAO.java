package org.incluemais.model.dao;

import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.Professor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfessorDAO {
    public void insert(Professor professor) {
        PessoaDAO pessoaDAO = new PessoaDAO();
        String sql = "INSERT INTO Professor (siape, pessoa_id, especialidade) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            int pessoaId = pessoaDAO.inserirPessoa(professor);
            stmt.setString(1, professor.getSiape());
            stmt.setInt(2, pessoaId);
            stmt.setString(3, professor.getEspecialidade());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir professor: " + e.getMessage(), e);
        }
    }

    public Professor getBySiape(String siape) {
        String sql = "SELECT p.*, pr.especialidade FROM Pessoa p " +
                "JOIN Professor pr ON p.id = pr.pessoa_id " +
                "WHERE pr.siape = ?";

        Professor professor = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, siape);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    professor = new Professor(
                            rs.getString("nome"),
                            rs.getDate("dataNascimento").toLocalDate(),
                            rs.getString("email"),
                            rs.getString("sexo"),
                            rs.getString("naturalidade"),
                            rs.getString("telefone"),
                            siape,
                            rs.getString("especialidade")
                    );
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar professor por SIAPE: " + e.getMessage(), e);
        }
        return professor;
    }

    public List<Professor> getAll() {
        String sql = "SELECT p.*, pr.siape, pr.especialidade FROM Pessoa p " +
                "JOIN Professor pr ON p.id = pr.pessoa_id";
        List<Professor> professores = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Professor professor = new Professor(
                        rs.getString("nome"),
                        rs.getDate("dataNascimento").toLocalDate(),
                        rs.getString("email"),
                        rs.getString("sexo"),
                        rs.getString("naturalidade"),
                        rs.getString("telefone"),
                        rs.getString("siape"),
                        rs.getString("especialidade")
                );
                professores.add(professor);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar professores: " + e.getMessage(), e);
        }
        return professores;
    }

    public void update(Professor professor) {
        String sqlPessoa = "UPDATE Pessoa SET nome = ?, dataNascimento = ?, email = ?, sexo = ?, naturalidade = ?, telefone = ? " +
                "WHERE id = (SELECT pessoa_id FROM Professor WHERE siape = ?)";
        String sqlProfessor = "UPDATE Professor SET especialidade = ? WHERE siape = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa);
             PreparedStatement stmtProfessor = conn.prepareStatement(sqlProfessor)) {

            stmtPessoa.setString(1, professor.getNome());
            stmtPessoa.setDate(2, Date.valueOf(professor.getDataNascimento()));
            stmtPessoa.setString(3, professor.getEmail());
            stmtPessoa.setString(4, professor.getSexo());
            stmtPessoa.setString(5, professor.getNaturalidade());
            stmtPessoa.setString(6, professor.getTelefone());
            stmtPessoa.setString(7, professor.getSiape());
            stmtPessoa.executeUpdate();

            stmtProfessor.setString(1, professor.getEspecialidade());
            stmtProfessor.setString(2, professor.getSiape());
            stmtProfessor.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar professor: " + e.getMessage(), e);
        }
    }

    public void delete(String siape) {
        String sql = "DELETE FROM Professor WHERE siape = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, siape);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao deletar professor: " + e.getMessage(), e);
        }
    }
}