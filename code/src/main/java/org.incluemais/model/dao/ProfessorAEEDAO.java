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

    // Método para inserir um novo ProfessorAEE
    public boolean salvarProfessor(ProfessorAEE professor) {
        String sqlPessoa = "INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlProfessor = "INSERT INTO ProfessorAEE (siape, especialidade, pessoa_id) VALUES (?, ?, ?)";

        try {
            conn.setAutoCommit(false);

            int pessoaId = inserirPessoa(professor, sqlPessoa);
            if (pessoaId == 0) return false;

            if (!inserirDadosProfessor(professor, pessoaId, sqlProfessor)) return false;

            conn.commit();
            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao salvar professor", e);
            return false;
        } finally {
            resetAutoCommit(conn);
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

    private boolean inserirDadosProfessor(ProfessorAEE professor, int pessoaId, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, professor.getSiape());
            stmt.setString(2, professor.getEspecialidade());
            stmt.setInt(3, pessoaId);

            return stmt.executeUpdate() > 0;
        }
    }

    // Método para atualizar um ProfessorAEE existente
    public boolean atualizarProfessor(ProfessorAEE professor) {
        String sqlPessoa = "UPDATE Pessoa SET nome=?, dataNascimento=?, email=?, sexo=?, naturalidade=?, telefone=? WHERE id=?";
        String sqlProfessor = "UPDATE ProfessorAEE SET siape=?, especialidade=? WHERE pessoa_id=?";

        try {
            conn.setAutoCommit(false);

            if (!atualizarPessoa(professor, sqlPessoa)) return false;
            if (!atualizarDadosProfessor(professor, sqlProfessor)) return false;

            conn.commit();
            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao atualizar professor", e);
            return false;
        } finally {
            resetAutoCommit(conn);
        }
    }

    private boolean atualizarPessoa(ProfessorAEE professor, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, professor.getNome());
            stmt.setDate(2, Date.valueOf(professor.getDataNascimento()));
            stmt.setString(3, professor.getEmail());
            stmt.setString(4, professor.getSexo());
            stmt.setString(5, professor.getNaturalidade());
            stmt.setString(6, professor.getTelefone());
            stmt.setInt(7, professor.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    private boolean atualizarDadosProfessor(ProfessorAEE professor, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, professor.getSiape());
            stmt.setString(2, professor.getEspecialidade());
            stmt.setInt(3, professor.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    // Método para excluir um ProfessorAEE
    public boolean excluirProfessor(int professorId) {
        String sqlProfessor = "DELETE FROM ProfessorAEE WHERE pessoa_id=?";
        String sqlPessoa = "DELETE FROM Pessoa WHERE id=?";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtProfessor = conn.prepareStatement(sqlProfessor)) {
                stmtProfessor.setInt(1, professorId);
                if (stmtProfessor.executeUpdate() == 0) {
                    conn.rollback();
                    return false;
                }
            }

            try (PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa)) {
                stmtPessoa.setInt(1, professorId);
                if (stmtPessoa.executeUpdate() == 0) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao excluir professor", e);
            return false;
        } finally {
            resetAutoCommit(conn);
        }
    }

    // Método para buscar um ProfessorAEE por ID
    public ProfessorAEE buscarPorId(int id) {
        String sql = "SELECT p.*, pr.siape, pr.especialidade FROM Pessoa p " +
                "JOIN ProfessorAEE pr ON p.id = pr.pessoa_id WHERE p.id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return criarProfessorAPartirResultSet(rs);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar professor por ID", e);
        }
        return null;
    }

    // Método para buscar um ProfessorAEE por SIAPE
    public ProfessorAEE buscarPorSiape(String siape) {
        String sql = "SELECT p.*, pr.siape, pr.especialidade FROM Pessoa p " +
                "JOIN ProfessorAEE pr ON p.id = pr.pessoa_id WHERE pr.siape = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return criarProfessorAPartirResultSet(rs);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar professor por SIAPE", e);
        }
        return null;
    }

    // Método para listar todos os ProfessoresAEE
    public List<ProfessorAEE> buscarTodos() {
        List<ProfessorAEE> professores = new ArrayList<>();
        String sql = "SELECT p.*, pr.siape, pr.especialidade FROM Pessoa p " +
                "JOIN ProfessorAEE pr ON p.id = pr.pessoa_id";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                professores.add(criarProfessorAPartirResultSet(rs));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar todos os professores", e);
        }
        return professores;
    }

    // Método para buscar ProfessoresAEE por nome (usando LIKE)
    public List<ProfessorAEE> buscarPorNome(String nome) {
        List<ProfessorAEE> professores = new ArrayList<>();
        String sql = "SELECT p.*, pr.siape, pr.especialidade FROM Pessoa p " +
                "JOIN ProfessorAEE pr ON p.id = pr.pessoa_id WHERE p.nome LIKE ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + nome + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    professores.add(criarProfessorAPartirResultSet(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar professores por nome", e);
        }
        return professores;
    }

    private ProfessorAEE criarProfessorAPartirResultSet(ResultSet rs) throws SQLException {
        ProfessorAEE professor = new ProfessorAEE(
                rs.getString("nome"),
                rs.getDate("dataNascimento").toLocalDate(),
                rs.getString("email"),
                rs.getString("sexo"),
                rs.getString("naturalidade"),
                rs.getString("telefone"),
                rs.getString("siape"),
                rs.getString("especialidade")
        );
        professor.setId(rs.getInt("id"));
        return professor;
    }

    private void rollback(Connection conn) {
        try {
            if (conn != null) conn.rollback();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao fazer rollback", e);
        }
    }

    private void resetAutoCommit(Connection conn) {
        try {
            if (conn != null) conn.setAutoCommit(true);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao resetar autoCommit", e);
        }
    }
}
