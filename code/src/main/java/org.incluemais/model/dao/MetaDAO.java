package org.incluemais.model.dao;

import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.Meta;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MetaDAO {

    public void create(Meta meta) throws SQLException {
        String sql = "INSERT INTO Meta (descricao, status) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, meta.getDescricao());
            stmt.setString(2, meta.getStatus());
            stmt.executeUpdate();
        }
    }

    public void update(Meta meta) throws SQLException {
        String sql = "UPDATE Meta SET descricao = ?, status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, meta.getDescricao());
            stmt.setString(2, meta.getStatus());
            stmt.setInt(3, meta.getId());
            stmt.executeUpdate();
        }
    }

    public List<Meta> listAll() throws SQLException {
        String sql = "SELECT * FROM Meta";
        List<Meta> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Meta meta = new Meta();
                meta.setDescricao(rs.getString("descricao"));
                meta.setStatus(rs.getString("status"));
                meta.setId(rs.getInt("id"));
                list.add(meta);
            }
        }
        return list;
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM Meta WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
