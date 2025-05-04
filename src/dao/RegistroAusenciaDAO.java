package dao;

import model.RegistroAusencia;
import java.sql.*;

public class RegistroAusenciaDAO {
    private Connection connection;

    public RegistroAusenciaDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RegistroAusencia ra) throws SQLException {
        String sql = "INSERT INTO RegistroAusencia (aluno_matricula, data, motivos, encaminhamento) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, ra.getAluno().getMatricula());
            stmt.setDate(2, Date.valueOf(ra.getData()));
            stmt.setString(3, ra.getMotivos());
            stmt.setString(4, ra.getEncaminhamento());
            stmt.executeUpdate();
        }
    }

    public void atualizar(RegistroAusencia ra) throws SQLException {
        String sql = "UPDATE RegistroAusencia SET aluno_matricula = ?, data = ?, motivos = ?, encaminhamento = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, ra.getAluno().getMatricula());
            stmt.setDate(2, Date.valueOf(ra.getData()));
            stmt.setString(3, ra.getMotivos());
            stmt.setString(4, ra.getEncaminhamento());
            stmt.setInt(5, ra.getId());
            stmt.executeUpdate();
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM RegistroAusencia WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
