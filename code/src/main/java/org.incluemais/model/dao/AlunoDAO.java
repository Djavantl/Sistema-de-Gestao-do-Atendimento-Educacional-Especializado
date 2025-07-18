package org.incluemais.model.dao;

import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.Aluno;

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
        String sqlAluno = "INSERT INTO Aluno (matricula, pessoa_id, responsavel, telResponsavel, telTrabalho,  curso, turma) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try {

            int pessoaId = inserirPessoa(aluno, sqlPessoa);
            if (pessoaId == 0) return false;

            if (!inserirDadosAluno(aluno, pessoaId, sqlAluno)) return false;

            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao salvar aluno", e);
            return false;
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
            stmt.setString(6, aluno.getCurso());
            stmt.setString(7, aluno.getTurma());


            return stmt.executeUpdate() > 0;
        }
    }



    public boolean atualizarAluno(Aluno aluno) {
        String sqlPessoa = "UPDATE Pessoa SET nome=?, dataNascimento=?, email=?, sexo=?, naturalidade=?, telefone=? WHERE id=?";
        String sqlAluno = "UPDATE Aluno SET matricula=?, responsavel=?, telResponsavel=?, telTrabalho=?, curso=?, turma=?  WHERE pessoa_id=?";

        try {


            if (!atualizarPessoa(aluno, sqlPessoa)) return false;
            if (!atualizarDadosAluno(aluno, sqlAluno)) return false;


            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao atualizar aluno", e);
            return false;
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
            stmt.setString(5, aluno.getCurso());
            stmt.setString(6, aluno.getTurma());
            stmt.setInt(7, aluno.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean excluirAluno(int alunoId) {
        String sqlAluno = "DELETE FROM Aluno WHERE pessoa_id=?";
        String sqlPessoa = "DELETE FROM Pessoa WHERE id=?";

        try {


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

            return true;

        } catch (SQLException e) {
            rollback(conn);
            logger.log(Level.SEVERE, "Erro ao excluir aluno", e);
            return false;
        }
    }

    //buscar por matricula
    public Aluno buscar(String matricula) {
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

    //buscar por id
    public Aluno buscar(int id) {
        String sql = """
        SELECT p.*, a.* 
        FROM Aluno a
        INNER JOIN Pessoa p ON a.pessoa_id = p.id
        WHERE p.id = ?
        """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? mapearAluno(rs) : null;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar aluno por ID", e);
            return null;
        }
    }



    //buscar todos
    public List<Aluno> buscar() throws SQLException {
        String sql = """
    SELECT p.*, a.* 
    FROM Aluno a
    INNER JOIN Pessoa p ON a.pessoa_id = p.id
    """;

        List<Aluno> alunos = new ArrayList<>(); // declarar aqui
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                alunos.add(mapearAluno(rs));
            }
        }
        logger.info("Alunos encontrados: " + alunos.size());
        return alunos;
    }

    //buscar por nome
    public List<Aluno> buscar(String nome, int id) {
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

    public Aluno mapearAluno(ResultSet rs) throws SQLException {
        Aluno aluno = new Aluno();

        // Mapeamento de Pessoa
        aluno.setId(rs.getInt("p.id"));
        aluno.setNome(rs.getString("p.nome"));
        aluno.setDataNascimento(rs.getDate("p.dataNascimento").toLocalDate());
        aluno.setEmail(rs.getString("p.email"));
        aluno.setSexo(rs.getString("p.sexo"));
        aluno.setNaturalidade(rs.getString("p.naturalidade"));
        aluno.setTelefone(rs.getString("p.telefone"));

        // Mapeamento de Aluno
        aluno.setMatricula(rs.getString("a.matricula"));
        aluno.setResponsavel(rs.getString("a.responsavel"));
        aluno.setTelResponsavel(rs.getString("a.telResponsavel"));
        aluno.setTelTrabalho(rs.getString("a.telTrabalho"));
        aluno.setCurso(rs.getString("a.curso"));
        aluno.setTurma(rs.getString("a.turma"));

        return aluno;
    }


    private void rollback(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.rollback();
            }
        } catch (SQLException e) {
            logger.log(Level.WARNING, "Erro ao fazer rollback", e);
        }
    }
}