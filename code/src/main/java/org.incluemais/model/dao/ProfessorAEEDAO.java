package org.incluemais.model.dao;

import org.incluemais.model.entities.ProfessorAEE;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProfessorAEEDAO {
    private static final Logger logger = Logger.getLogger(ProfessorAEEDAO.class.getName());
    private final Connection conn;

    public ProfessorAEEDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
    }

    public boolean salvarProfessorAEE(ProfessorAEE professor) {
        String sqlPessoa = "INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlProfessorAEE = "INSERT INTO ProfessorAEE (siape, pessoa_id, especialidade) VALUES (?, ?, ?)";

        try {
            conn.setAutoCommit(false);
            int pessoaId = inserirPessoa(professor, sqlPessoa);

            if (pessoaId == 0) {
                conn.rollback();
                return false;
            }

            try (PreparedStatement stmtProfessor = conn.prepareStatement(sqlProfessorAEE)) {
                stmtProfessor.setString(1, professor.getSiape());
                stmtProfessor.setInt(2, pessoaId);
                stmtProfessor.setString(3, professor.getEspecialidade());

                if (stmtProfessor.executeUpdate() == 0) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao salvar ProfessorAEE", e);
            rollback();
            return false;
        } finally {
            restaurarAutoCommit();
        }
    }

    private int inserirPessoa(ProfessorAEE professor, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, professor.getNome());
            stmt.setDate(2, Date.valueOf(professor.getDataNascimento()));
            stmt.setString(3, professor.getEmail());
            stmt.setString(4, professor.getSexo());
            stmt.setString(5, professor.getNaturalidade());
            stmt.setString(6, professor.getTelefone());

            if (stmt.executeUpdate() == 0) return 0;

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                return generatedKeys.next() ? generatedKeys.getInt(1) : 0;
            }
        }
    }

    public ProfessorAEE getBySiape(String siape) {
        String sql = "SELECT p.*, pa.especialidade FROM Pessoa p " +
                "JOIN ProfessorAEE pa ON p.id = pa.pessoa_id " +
                "WHERE pa.siape = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new ProfessorAEE(
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
            return null;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar ProfessorAEE", e);
            throw new RuntimeException("Erro ao buscar ProfessorAEE", e);
        }
    }

    public List<ProfessorAEE> getAll() {
        String sql = "SELECT p.*, pa.siape, pa.especialidade FROM Pessoa p " +
                "JOIN ProfessorAEE pa ON p.id = pa.pessoa_id";
        List<ProfessorAEE> professores = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                professores.add(new ProfessorAEE(
                        rs.getString("nome"),
                        rs.getDate("dataNascimento").toLocalDate(),
                        rs.getString("email"),
                        rs.getString("sexo"),
                        rs.getString("naturalidade"),
                        rs.getString("telefone"),
                        rs.getString("siape"),
                        rs.getString("especialidade")
                ));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao listar ProfessoresAEE", e);
            throw new RuntimeException("Erro ao listar ProfessoresAEE", e);
        }
        return professores;
    }

    public void update(ProfessorAEE professor) {
        String sqlPessoa = "UPDATE Pessoa SET nome = ?, dataNascimento = ?, email = ?, " +
                "sexo = ?, naturalidade = ?, telefone = ? " +
                "WHERE id = (SELECT pessoa_id FROM ProfessorAEE WHERE siape = ?)";

        String sqlProfessorAEE = "UPDATE ProfessorAEE SET especialidade = ? WHERE siape = ?";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa)) {
                stmtPessoa.setString(1, professor.getNome());
                stmtPessoa.setDate(2, Date.valueOf(professor.getDataNascimento()));
                stmtPessoa.setString(3, professor.getEmail());
                stmtPessoa.setString(4, professor.getSexo());
                stmtPessoa.setString(5, professor.getNaturalidade());
                stmtPessoa.setString(6, professor.getTelefone());
                stmtPessoa.setString(7, professor.getSiape());
                stmtPessoa.executeUpdate();
            }

            try (PreparedStatement stmtProfessor = conn.prepareStatement(sqlProfessorAEE)) {
                stmtProfessor.setString(1, professor.getEspecialidade());
                stmtProfessor.setString(2, professor.getSiape());
                stmtProfessor.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao atualizar ProfessorAEE", e);
            rollback();
            throw new RuntimeException("Erro ao atualizar ProfessorAEE", e);
        } finally {
            restaurarAutoCommit();
        }
    }

    public void delete(String siape) {
        String sqlDeletePessoa = "DELETE FROM Pessoa WHERE id = (SELECT pessoa_id FROM ProfessorAEE WHERE siape = ?)";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement stmt = conn.prepareStatement(sqlDeletePessoa)) {
                stmt.setString(1, siape);
                stmt.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao deletar ProfessorAEE", e);
            rollback();
            throw new RuntimeException("Erro ao deletar ProfessorAEE", e);
        } finally {
            restaurarAutoCommit();
        }
    }

    private void rollback() {
        try {
            if (conn != null) conn.rollback();
        } catch (SQLException ex) {
            logger.log(Level.SEVERE, "Erro ao fazer rollback", ex);
        }
    }

    private void restaurarAutoCommit() {
        try {
            if (conn != null) conn.setAutoCommit(true);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao restaurar autoCommit", e);
        }
    }
}