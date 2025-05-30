package org.incluemais.model.dao;

import org.incluemais.model.entities.Professor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ProfessorDAO {

    private static final Logger logger = Logger.getLogger(AlunoDAO.class.getName());
    private final Connection conn;

    public ProfessorDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
    }

    public boolean salvarProfessor(Professor professor) {
        String sqlPessoa = "INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlProfessor = "INSERT INTO Professor (siape, pessoa_id, especialidade) VALUES (?, ?, ?)";
        try {
            conn.setAutoCommit(false);
            int pessoaId = inserirPessoa(professor, sqlPessoa);
            if (pessoaId == 0) {
                conn.rollback();
                return false;
            }

            try (PreparedStatement stmtProfessor = conn.prepareStatement(sqlProfessor)) {
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
            logger.log(Level.SEVERE, "Erro ao salvar professor", e);
            return false;
        }
    }

    private int inserirPessoa(Professor professor, String sql) throws SQLException {
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

    public Professor getBySiape(String siape) {
        String sql = "SELECT p.*, pr.especialidade FROM Pessoa p " +
                "JOIN Professor pr ON p.id = pr.pessoa_id " +
                "WHERE pr.siape = ?";

        try (PreparedStatement stmt = this.conn.prepareStatement(sql)) { // Usa this.conn
            stmt.setString(1, siape);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ?
                        new Professor(
                                rs.getString("nome"),
                                rs.getDate("dataNascimento").toLocalDate(),
                                rs.getString("email"),
                                rs.getString("sexo"),
                                rs.getString("naturalidade"),
                                rs.getString("telefone"),
                                siape,
                                rs.getString("especialidade")
                        ) : null;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar professor por SIAPE", e);
            throw new RuntimeException("Erro ao buscar professor por SIAPE", e);
        }
    }

    public List<Professor> getAll() {
        logger.info("Executando query para buscar professores");
        String sql = "SELECT p.*, pr.siape, pr.especialidade FROM Pessoa p " +
                "JOIN Professor pr ON p.id = pr.pessoa_id";
        List<Professor> professores = new ArrayList<>();

        try (PreparedStatement stmt = this.conn.prepareStatement(sql);  // Usa a conexão existente
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

            logger.info("Professores encontrados: " + professores.size());

        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao listar professores", e);
            throw new RuntimeException("Erro ao listar professores", e);
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
        String sqlDeletePessoa = "DELETE FROM Pessoa WHERE id = (SELECT pessoa_id FROM Professor WHERE siape = ?)";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtDelPessoa = conn.prepareStatement(sqlDeletePessoa)) {
                stmtDelPessoa.setString(1, siape);
                stmtDelPessoa.executeUpdate();
            }

            conn.commit();

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                logger.log(Level.SEVERE, "Erro ao fazer rollback", ex);
            }
            throw new RuntimeException("Erro ao deletar professor: " + e.getMessage(), e);
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                logger.log(Level.SEVERE, "Erro ao restaurar autoCommit", e);
            }
        }
    }
}