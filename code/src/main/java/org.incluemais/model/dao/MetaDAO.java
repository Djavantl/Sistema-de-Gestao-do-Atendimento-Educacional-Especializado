package org.incluemais.model.dao;

import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.Meta;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MetaDAO {
    private static final Logger logger = Logger.getLogger(MetaDAO.class.getName());
    private final Connection conn;

    public MetaDAO(Connection conn) {
        this.conn = conn;
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

    public List<Meta> buscarMetasPorPlanoId(int planoId) throws SQLException {
        List<Meta> metas = new ArrayList<>();
        String sql = """
            SELECT m.id, m.descricao, m.status
            FROM Meta m
            JOIN PlanoAEE_Meta pm ON m.id = pm.meta_id
            WHERE pm.plano_id = ?
            """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, planoId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Meta meta = new Meta();
                    meta.setId(rs.getInt("id"));
                    meta.setDescricao(rs.getString("descricao"));
                    meta.setStatus(rs.getString("status"));
                    metas.add(meta);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar metas por plano", e);
            throw e;
        }
        return metas;
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
