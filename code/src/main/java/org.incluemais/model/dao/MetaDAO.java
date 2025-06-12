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

    // --------------------- CRIAÇÃO ---------------------

    public void insert(int planoId, Meta meta) throws SQLException {
        String sqlMeta = "INSERT INTO Meta (descricao, status, plano_id) VALUES (?, ?, ?)";

        try (PreparedStatement stmtMeta = conn.prepareStatement(sqlMeta, Statement.RETURN_GENERATED_KEYS)) {
            stmtMeta.setString(1, meta.getDescricao());
            stmtMeta.setString(2, meta.getStatus());
            stmtMeta.setInt(3, planoId);
            stmtMeta.executeUpdate();

            try (ResultSet generatedKeys = stmtMeta.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    meta.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    // --------------------- LEITURA ---------------------

    public Meta find(int metaId) throws SQLException {
        String sql = "SELECT * FROM Meta WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, metaId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Meta meta = new Meta();
                    meta.setId(rs.getInt("id"));
                    meta.setDescricao(rs.getString("descricao"));
                    meta.setStatus(rs.getString("status"));
                    return meta;
                }
            }
        }
        return null;
    }

    public List<Meta> buscarMetasPorPlanoId(int planoId) throws SQLException {
        List<Meta> metas = new ArrayList<>();
        String sql = "SELECT id, descricao, status FROM Meta WHERE plano_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, planoId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Meta meta = new Meta();
                meta.setId(rs.getInt("id"));
                meta.setDescricao(rs.getString("descricao"));
                meta.setStatus(rs.getString("status"));
                metas.add(meta);
            }
        }
        return metas;
    }

    // --------------------- ATUALIZAÇÃO ---------------------

    public boolean update(Meta meta) throws SQLException {
        String sql = "UPDATE Meta SET descricao = ?, status = ? WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, meta.getDescricao());
            stmt.setString(2, meta.getStatus());
            stmt.setInt(3, meta.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    // --------------------- EXCLUSÃO ---------------------

    public boolean delete(int metaId) throws SQLException {
        String sql = "DELETE FROM Meta WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, metaId);
            return stmt.executeUpdate() > 0;
        }
    }

}
