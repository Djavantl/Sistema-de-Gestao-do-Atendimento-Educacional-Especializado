package dao;

import model.Deficiencia;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeficienciaDAO {
    private Connection connection;

    public DeficienciaDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(Deficiencia def) throws SQLException {
        String sql = "INSERT INTO deficiencia (descricao, tipo_deficiencia) VALUES (?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, def.getDescricao());
        stmt.setString(2, def.getTipoDeficiencia());
        stmt.executeUpdate();
    }

    public Deficiencia buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM deficiencia WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            Deficiencia def = new Deficiencia(rs.getString("descricao"), rs.getString("tipo_deficiencia"));
            def.setId(id);
            return def;
        }
        return null;
    }

    public void atualizar(Deficiencia def) throws SQLException {
        String sql = "UPDATE deficiencia SET descricao = ?, tipo_deficiencia = ? WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, def.getDescricao());
        stmt.setString(2, def.getTipoDeficiencia());
        stmt.setInt(3, def.getId());
        stmt.executeUpdate();
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM deficiencia WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }
}
