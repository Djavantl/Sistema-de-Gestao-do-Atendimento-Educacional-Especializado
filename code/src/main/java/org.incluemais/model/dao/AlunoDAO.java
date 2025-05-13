package org.incluemais.model.dao;

import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.OrganizacaoAtendimento;
import org.incluemais.model.entities.PlanoAEE;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AlunoDAO {
    private static final Logger logger = Logger.getLogger(AlunoDAO.class.getName());
    private final Connection conn;

    public AlunoDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
    }

    // Método único para inserção
    public boolean salvarAluno(Aluno aluno) {
        String sqlPessoa = "INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlAluno = "INSERT INTO Aluno (matricula, pessoa_id, responsavel, telResponsavel, telTrabalho, organizacao_id, curso, turma, plano_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn.setAutoCommit(false);

            int pessoaId = inserirPessoa(aluno, sqlPessoa);
            if (pessoaId == 0) return false;

            if (!inserirDadosAluno(aluno, pessoaId, sqlAluno)) return false;

            conn.commit();
            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao salvar aluno", e);
            return false;
        } finally {
            resetAutoCommit(conn);
        }
    }

    private int inserirPessoa(Aluno aluno, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, aluno.getNome());
            stmt.setDate(2, Date.valueOf(aluno.getDataNascimento()));
            stmt.setString(3, aluno.getEmail());
            stmt.setString(4, aluno.getSexo());
            stmt.setString(5, aluno.getNaturalidade());
            stmt.setString(6, aluno.getTelefone());

            if (stmt.executeUpdate() == 0) return 0;

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                return generatedKeys.next() ? generatedKeys.getInt(1) : 0;
            }
        }
    }

    private boolean inserirDadosAluno(Aluno aluno, int pessoaId, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, aluno.getMatricula());
            stmt.setInt(2, pessoaId);
            stmt.setString(3, aluno.getResponsavel());
            stmt.setString(4, aluno.getTelResponsavel());
            stmt.setString(5, aluno.getTelTrabalho());
            stmt.setObject(6, aluno.getOrganizacao() != null ? aluno.getOrganizacao().getId() : null, Types.INTEGER);
            stmt.setString(7, aluno.getCurso());
            stmt.setString(8, aluno.getTurma());
            stmt.setObject(9, aluno.getPlano() != null ? aluno.getPlano().getId() : null, Types.INTEGER);

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean atualizarAluno(Aluno aluno) {
        String sqlPessoa = "UPDATE Pessoa SET nome=?, dataNascimento=?, email=?, sexo=?, naturalidade=?, telefone=? WHERE id=?";
        String sqlAluno = "UPDATE Aluno SET matricula=?, responsavel=?, telResponsavel=?, telTrabalho=?, organizacao_id=?, curso=?, turma=?, plano_id=? WHERE pessoa_id=?";

        try {
            conn.setAutoCommit(false);

            if (!atualizarPessoa(aluno, sqlPessoa)) return false;
            if (!atualizarDadosAluno(aluno, sqlAluno)) return false;

            conn.commit();
            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao atualizar aluno", e);
            return false;
        } finally {
            resetAutoCommit(conn);
        }
    }

    private boolean atualizarPessoa(Aluno aluno, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, aluno.getNome());
            stmt.setDate(2, Date.valueOf(aluno.getDataNascimento()));
            stmt.setString(3, aluno.getEmail());
            stmt.setString(4, aluno.getSexo());
            stmt.setString(5, aluno.getNaturalidade());
            stmt.setString(6, aluno.getTelefone());
            stmt.setInt(7, aluno.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    private boolean atualizarDadosAluno(Aluno aluno, String sql) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, aluno.getMatricula());
            stmt.setString(2, aluno.getResponsavel());
            stmt.setString(3, aluno.getTelResponsavel());
            stmt.setString(4, aluno.getTelTrabalho());
            stmt.setObject(5, aluno.getOrganizacao() != null ? aluno.getOrganizacao().getId() : null, Types.INTEGER);
            stmt.setString(6, aluno.getCurso());
            stmt.setString(7, aluno.getTurma());
            stmt.setObject(8, aluno.getPlano() != null ? aluno.getPlano().getId() : null, Types.INTEGER);
            stmt.setInt(9, aluno.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean excluirAluno(int alunoId) {
        String sqlAluno = "DELETE FROM Aluno WHERE pessoa_id=?";
        String sqlPessoa = "DELETE FROM Pessoa WHERE id=?";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtAluno = conn.prepareStatement(sqlAluno)) {
                stmtAluno.setInt(1, alunoId);
                if (stmtAluno.executeUpdate() == 0) {
                    conn.rollback();
                    return false;
                }
            }

            try (PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa)) {
                stmtPessoa.setInt(1, alunoId);
                if (stmtPessoa.executeUpdate() == 0) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao excluir aluno", e);
            return false;
        } finally {
            resetAutoCommit(conn);
        }
    }

    public Aluno buscarPorMatricula(String matricula) {
        String sql = """
            SELECT p.*, a.* 
            FROM Aluno a
            INNER JOIN Pessoa p ON a.pessoa_id = p.id
            WHERE a.matricula = ?
            """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? mapearAluno(rs) : null;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar por matrícula", e);
            return null;
        }
    }

    public List<Aluno> buscarPorNome(String nome) {
        String sql = """
            SELECT p.*, a.* 
            FROM Aluno a
            INNER JOIN Pessoa p ON a.pessoa_id = p.id
            WHERE p.nome LIKE ?
            """;

        List<Aluno> alunos = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + nome + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    alunos.add(mapearAluno(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar por nome", e);
        }
        return alunos;
    }

    private Aluno mapearAluno(ResultSet rs) throws SQLException {
        Aluno aluno = new Aluno();
        // Mapeamento de Pessoa
        aluno.setId(rs.getInt("id"));
        aluno.setNome(rs.getString("nome"));
        aluno.setDataNascimento(rs.getDate("dataNascimento").toLocalDate());
        aluno.setEmail(rs.getString("email"));
        aluno.setSexo(rs.getString("sexo"));
        aluno.setNaturalidade(rs.getString("naturalidade"));
        aluno.setTelefone(rs.getString("telefone"));

        // Mapeamento de Aluno
        aluno.setMatricula(rs.getString("matricula"));
        aluno.setResponsavel(rs.getString("responsavel"));
        aluno.setTelResponsavel(rs.getString("telResponsavel"));
        aluno.setTelTrabalho(rs.getString("telTrabalho"));
        aluno.setCurso(rs.getString("curso"));
        aluno.setTurma(rs.getString("turma"));

        // Relacionamentos (implementar conforme necessidade)
        Integer organizacaoId = rs.getInt("organizacao_id");
        if (organizacaoId != null) {
            aluno.setOrganizacao(buscarOrganizacao(organizacaoId));
        }

        return aluno;
    }

    // Métodos auxiliares de transação
    private void rollback(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.rollback();
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Erro ao fazer rollback", e);
        }
    }

    private void resetAutoCommit(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Erro ao resetar auto-commit", e);
        }
    }

    // Métodos para buscar relacionamentos (implementar)
    private OrganizacaoAtendimento buscarOrganizacao(int id) {
        // Implementar lógica de busca
        return null;
    }

    private PlanoAEE buscarPlano(int id) {
        // Implementar lógica de busca
        return null;
    }
}