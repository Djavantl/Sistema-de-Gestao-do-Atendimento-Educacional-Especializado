package org.incluemais.model.dao;

import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Deficiencia;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeficienciaDAO {
    private final AlunoDAO alunoDAO;
    private final Connection conn;

    public DeficienciaDAO(Connection connection) {
        this.conn = connection;
        this.alunoDAO = new AlunoDAO(connection);
    }

    public int create(Deficiencia deficiencia) throws SQLException {
        String sql = "INSERT INTO Deficiencia (nome, descricao, grau_severidade, cid, aluno_matricula) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = this.conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, deficiencia.getNome());
            stmt.setString(2, deficiencia.getDescricao());
            stmt.setString(3, deficiencia.getGrauSeveridade());
            stmt.setString(4, deficiencia.getCid());
            stmt.setString(5, deficiencia.getAluno().getMatricula());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
            return -1;
        }
    }

    public void update(Deficiencia deficiencia) throws SQLException {
        String sql = "UPDATE Deficiencia SET nome = ?, descricao = ?, grau_severidade = ?, cid = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, deficiencia.getNome());
            stmt.setString(2, deficiencia.getDescricao());
            stmt.setString(3, deficiencia.getGrauSeveridade());
            stmt.setString(4, deficiencia.getCid());
            stmt.setInt(5, deficiencia.getId());

            stmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM Deficiencia WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Deficiencia> findByAlunoMatricula(String matricula) throws SQLException {
        List<Deficiencia> deficiencias = new ArrayList<>();
        String sql = "SELECT * FROM Deficiencia WHERE aluno_matricula = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
                    if(aluno != null) {
                        deficiencias.add(new Deficiencia(
                                rs.getInt("id"),
                                rs.getString("nome"),
                                rs.getString("descricao"),
                                rs.getString("grau_severidade"),
                                rs.getString("cid"),
                                aluno
                        ));
                    }
                }
            }
        }
        return deficiencias;
    }

    public Deficiencia findById(int id) throws SQLException {
        String sql = "SELECT * FROM Deficiencia WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String matriculaAluno = rs.getString("aluno_matricula");
                    AlunoDAO alunoDAO = new AlunoDAO(conn);
                    Aluno aluno = alunoDAO.buscarPorMatricula(matriculaAluno);
                    return new Deficiencia(
                            rs.getInt("id"),
                            rs.getString("nome"),
                            rs.getString("descricao"),
                            rs.getString("grau_severidade"),
                            rs.getString("cid"),
                            aluno
                    );
                }
            }
        }
        return null;
    }
}