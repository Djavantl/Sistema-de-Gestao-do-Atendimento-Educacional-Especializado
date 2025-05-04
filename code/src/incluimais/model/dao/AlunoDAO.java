package dao;

import connection.DBConnection;
import entities.Aluno;
import entities.Deficiencia;
import entities.Pessoa;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlunoDAO {
    private final PessoaDAO pessoaDAO = new PessoaDAO();
    private final DeficienciaDAO deficienciaDAO = new DeficienciaDAO();

    // INSERT
    public void insert(Aluno aluno) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Insere Pessoa
            int pessoaId = pessoaDAO.insert(conn, aluno);

            // Insere Aluno
            String sqlAluno = "INSERT INTO Aluno (matricula, pessoa_id, responsavel, telResponsavel, telTrabalho, curso, turma) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sqlAluno)) {
                stmt.setString(1, aluno.getMatricula());
                stmt.setInt(2, pessoaId);
                stmt.setString(3, aluno.getResponsavel());
                stmt.setString(4, aluno.getTelResponsavel());
                stmt.setString(5, aluno.getTelTrabalho());
                stmt.setString(6, aluno.getCurso());
                stmt.setString(7, aluno.getTurma());
                stmt.executeUpdate();
            }

            // Insere Deficiências
            if (!aluno.getDeficiencias().isEmpty()) {
                inserirDeficiencias(conn, aluno.getMatricula(), aluno.getDeficiencias());
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }

    // GET BY MATRICULA
    public Aluno getByMatricula(String matricula) throws SQLException {
        Aluno aluno = null;
        String sql = "SELECT a.*, p.* FROM Aluno a " +
                "JOIN Pessoa p ON a.pessoa_id = p.id " +
                "WHERE a.matricula = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, matricula);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    aluno = mapearAluno(rs);
                    aluno.setDeficiencias(getDeficiencias(conn, matricula));
                }
            }
        }
        return aluno;
    }

    // GET ALL
    public List<Aluno> getAll() throws SQLException {
        List<Aluno> alunos = new ArrayList<>();
        String sql = "SELECT a.*, p.* FROM Aluno a " +
                "JOIN Pessoa p ON a.pessoa_id = p.id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Aluno aluno = mapearAluno(rs);
                aluno.setDeficiencias(getDeficiencias(conn, aluno.getMatricula()));
                alunos.add(aluno);
            }
        }
        return alunos;
    }

    // UPDATE
    public void update(Aluno aluno) throws SQLException {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Atualiza Pessoa
            pessoaDAO.update(conn, aluno, aluno.getId());

            // Atualiza Aluno
            String sqlAluno = "UPDATE Aluno SET responsavel = ?, telResponsavel = ?, " +
                    "telTrabalho = ?, curso = ?, turma = ? WHERE matricula = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sqlAluno)) {
                stmt.setString(1, aluno.getResponsavel());
                stmt.setString(2, aluno.getTelResponsavel());
                stmt.setString(3, aluno.getTelTrabalho());
                stmt.setString(4, aluno.getCurso());
                stmt.setString(5, aluno.getTurma());
                stmt.setString(6, aluno.getMatricula());
                stmt.executeUpdate();
            }

            // Atualiza Deficiências
            removerDeficiencias(conn, aluno.getMatricula());
            if (!aluno.getDeficiencias().isEmpty()) {
                inserirDeficiencias(conn, aluno.getMatricula(), aluno.getDeficiencias());
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) conn.rollback();
            throw e;
        } finally {
            if (conn != null) conn.close();
        }
    }

    // DELETE
    public void delete(String matricula) throws SQLException {
        String sql = "DELETE FROM Aluno WHERE matricula = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            stmt.executeUpdate();
        }
    }

    // ADICIONAR PROFESSOR
    public void adicionarProfessor(String matricula, String siape) throws SQLException {
        String sql = "INSERT INTO Professor_Aluno (professor_siape, aluno_matricula) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, siape);
            stmt.setString(2, matricula);
            stmt.executeUpdate();
        }
    }

    // REMOVER PROFESSOR
    public void removerProfessor(String matricula, String siape) throws SQLException {
        String sql = "DELETE FROM Professor_Aluno WHERE professor_siape = ? AND aluno_matricula = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, siape);
            stmt.setString(2, matricula);
            stmt.executeUpdate();
        }
    }

    // MÉTODOS AUXILIARES
    private Aluno mapearAluno(ResultSet rs) throws SQLException {
        Aluno aluno = new Aluno(
                rs.getString("matricula"),
                rs.getString("responsavel"),
                rs.getString("telResponsavel"),
                rs.getString("telTrabalho"),
                rs.getString("curso"),
                rs.getString("turma")
        );

        // Dados da Pessoa
        aluno.setId(rs.getInt("pessoa_id"));
        aluno.setNome(rs.getString("nome"));
        aluno.setDataNascimento(rs.getDate("dataNascimento").toLocalDate());
        aluno.setEmail(rs.getString("email"));
        aluno.setSexo(rs.getString("sexo"));
        aluno.setNaturalidade(rs.getString("naturalidade"));
        aluno.setTelefone(rs.getString("telefone"));

        return aluno;
    }

    private void inserirDeficiencias(Connection conn, String matricula, List<Deficiencia> deficiencias) throws SQLException {
        String sql = "INSERT INTO Aluno_Deficiencia (aluno_matricula, deficiencia_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (Deficiencia deficiencia : deficiencias) {
                stmt.setString(1, matricula);
                stmt.setInt(2, deficiencia.getId());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    private List<Deficiencia> getDeficiencias(Connection conn, String matricula) throws SQLException {
        List<Deficiencia> deficiencias = new ArrayList<>();
        String sql = "SELECT d.id FROM Deficiencia d " +
                "JOIN Aluno_Deficiencia ad ON d.id = ad.deficiencia_id " +
                "WHERE ad.aluno_matricula = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    deficiencias.add(deficienciaDAO.getById(rs.getInt("id")));
                }
            }
        }
        return deficiencias;
    }

    private void removerDeficiencias(Connection conn, String matricula) throws SQLException {
        String sql = "DELETE FROM Aluno_Deficiencia WHERE aluno_matricula = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            stmt.executeUpdate();
        }
    }
}