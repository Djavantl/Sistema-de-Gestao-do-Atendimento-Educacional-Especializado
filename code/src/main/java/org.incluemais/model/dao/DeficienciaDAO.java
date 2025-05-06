package org.incluemais.model.dao;

import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.Deficiencia;
import org.incluemais.model.entities.RecursoFisicoArquitetonico;
import org.incluemais.model.entities.RecursosComunicacaoEInformacao;
import org.incluemais.model.entities.RecursosPedagogicos;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeficienciaDAO {

    public int insert(Deficiencia deficiencia) throws SQLException {
        String sql = "INSERT INTO Deficiencia (descricao, tipoDeficiencia, recursoFisico_id, " +
                "recursoComunicacao_id, recursoPedagogico_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, deficiencia.getDescricao());
            stmt.setString(2, deficiencia.getTipoDeficiencia());
            setRecursoId(stmt, 3, deficiencia.getRecursoFisicoArquitetonico());
            setRecursoId(stmt, 4, deficiencia.getComunicacaoEInformacao());
            setRecursoId(stmt, 5, deficiencia.getRecursosPedagogicos());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    inserirAdaptacoes(id, deficiencia.getAdaptacoes());
                    return id;
                }
            }
        }
        return -1;
    }

    private void setRecursoId(PreparedStatement stmt, int index, Object recurso) throws SQLException {
        if (recurso != null) {
            stmt.setInt(index, ((RecursoFisicoArquitetonico) recurso).getId());
        } else {
            stmt.setNull(index, Types.INTEGER);
        }
    }

    private void inserirAdaptacoes(int deficienciaId, List<String> adaptacoes) throws SQLException {
        String sql = "INSERT INTO Deficiencia_Adaptacoes (deficiencia_id, adaptacao) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (String adaptacao : adaptacoes) {
                stmt.setInt(1, deficienciaId);
                stmt.setString(2, adaptacao);
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    public Deficiencia getById(int id) throws SQLException {
        String sql = "SELECT * FROM Deficiencia WHERE id = ?";
        Deficiencia deficiencia = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    deficiencia = new Deficiencia(
                            rs.getString("descricao"),
                            rs.getString("tipoDeficiencia")
                    );
                    deficiencia.setId(id);
                    deficiencia.setAdaptacoes(getAdaptacoes(id));
                    // Carregar recursos relacionados se necessário
                }
            }
        }
        return deficiencia;
    }

    private List<String> getAdaptacoes(int deficienciaId) throws SQLException {
        String sql = "SELECT adaptacao FROM Deficiencia_Adaptacoes WHERE deficiencia_id = ?";
        List<String> adaptacoes = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deficienciaId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    adaptacoes.add(rs.getString("adaptacao"));
                }
            }
        }
        return adaptacoes;
    }

    public void update(Deficiencia deficiencia) throws SQLException {
        String sql = "UPDATE Deficiencia SET descricao = ?, tipoDeficiencia = ?, " +
                "recursoFisico_id = ?, recursoComunicacao_id = ?, recursoPedagogico_id = ? " +
                "WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, deficiencia.getDescricao());
            stmt.setString(2, deficiencia.getTipoDeficiencia());
            setRecursoId(stmt, 3, deficiencia.getRecursoFisicoArquitetonico());
            setRecursoId(stmt, 4, deficiencia.getComunicacaoEInformacao());
            setRecursoId(stmt, 5, deficiencia.getRecursosPedagogicos());
            stmt.setInt(6, deficiencia.getId());

            stmt.executeUpdate();

            // Atualizar adaptações
            atualizarAdaptacoes(deficiencia);
        }
    }

    private void atualizarAdaptacoes(Deficiencia deficiencia) throws SQLException {
        removerAdaptacoes(deficiencia.getId());
        inserirAdaptacoes(deficiencia.getId(), deficiencia.getAdaptacoes());
    }

    private void removerAdaptacoes(int deficienciaId) throws SQLException {
        String sql = "DELETE FROM Deficiencia_Adaptacoes WHERE deficiencia_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, deficienciaId);
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
}