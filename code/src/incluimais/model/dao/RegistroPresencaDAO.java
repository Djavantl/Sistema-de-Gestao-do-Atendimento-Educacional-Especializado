package dao;

import entities.RegistroPresenca;
import java.sql.*;

public class RegistroPresencaDAO {
    private Connection connection;

    public RegistroPresencaDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RegistroPresenca registro) throws SQLException {
        String sql = "INSERT INTO RegistroPresenca (aluno_matricula, data, horiario, sinteseAtividades) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, registro.getAluno().getMatricula());
            stmt.setDate(2, Date.valueOf(registro.getData()));
            stmt.setTime(3, Time.valueOf(registro.getHorario()));
            stmt.setString(4, registro.getSinteseAtividades());
            stmt.executeUpdate();
        }
    }

    public void atualizar(RegistroPresenca registro) throws SQLException {
        String sql = "UPDATE RegistroPresenca SET aluno_matricula = ?, data = ?, horiario = ?, sinteseAtividades = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, registro.getAluno().getMatricula());
            stmt.setDate(2, Date.valueOf(registro.getData()));
            stmt.setTime(3, Time.valueOf(registro.getHorario()));
            stmt.setString(4, registro.getSinteseAtividades());
            stmt.setInt(5, registro.getId());
            stmt.executeUpdate();
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM RegistroPresenca WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
