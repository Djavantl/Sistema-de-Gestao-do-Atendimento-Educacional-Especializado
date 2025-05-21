package org.incluemais.model.dao;

import org.incluemais.model.entities.RecursoFisicoArquitetonico;
import java.sql.*;

public class RecursoFisicoArquitetonicoDAO {
    private final Connection conn;

    public RecursoFisicoArquitetonicoDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
    }

    public void inserir(RecursoFisicoArquitetonico recurso) throws SQLException {
        String sql = "INSERT INTO RecursoFisicoArquitetonico ("
                + "usoCadeiraDeRodas, auxilioTranscricaoEscrita, mesaAdaptadaCadeiraDeRodas, "
                + "usoDeMuleta, outrosFisicoArquitetonico, outrosEspecificado) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setBoolean(1, recurso.isUsoCadeiraDeRodas());
            stmt.setBoolean(2, recurso.isAuxilioTranscricaoEscrita());
            stmt.setBoolean(3, recurso.isMesaAdaptadaCadeiraDeRodas());
            stmt.setBoolean(4, recurso.isUsoDeMuleta());
            stmt.setBoolean(5, recurso.isOutrosFisicoArquitetonico());

            if (recurso.getOutrosEspecificado() != null) {
                stmt.setString(6, recurso.getOutrosEspecificado());
            } else {
                stmt.setNull(6, Types.VARCHAR);
            }

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Falha na inserção, nenhuma linha afetada.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    recurso.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Falha na inserção, nenhum ID obtido.");
                }
            }
        }
    }
}