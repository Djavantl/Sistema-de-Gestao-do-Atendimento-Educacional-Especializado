package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entities.Deficiencia;

public class DeficienciaDAO {
    private Connection connection;

    public DeficienciaDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(Deficiencia def) throws SQLException {
        String sql = "INSERT INTO Deficiencia (descricao, tipo_deficiencia) VALUES (?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, def.getDescricao());
        stmt.setString(2, def.getTipoDeficiencia());
        stmt.executeUpdate();
    }

    public void atualizar(Deficiencia def) throws SQLException {
        String sql = "UPDATE Deficiencia SET descricao = ?, tipo_deficiencia = ? WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, def.getDescricao());
        stmt.setString(2, def.getTipoDeficiencia());
        stmt.setInt(3, def.getId());
        stmt.executeUpdate();
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM Deficiencia WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public Deficiencia buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM Deficiencia WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            Deficiencia def = new Deficiencia(rs.getString("descricao"), rs.getString("tipo_deficiencia"));
            def.setId(rs.getInt("id"));
            return def;
        }
        return null;
    }

    public List<Deficiencia> listarTodos() throws SQLException {
        List<Deficiencia> lista = new ArrayList<>();
        String sql = "SELECT * FROM Deficiencia";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            Deficiencia def = new Deficiencia(rs.getString("descricao"), rs.getString("tipo_deficiencia"));
            def.setId(rs.getInt("id"));
            lista.add(def);
        }
        return lista;
    }
}
