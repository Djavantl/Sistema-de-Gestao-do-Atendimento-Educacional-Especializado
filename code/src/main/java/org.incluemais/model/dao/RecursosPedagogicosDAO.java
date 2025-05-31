package org.incluemais.model.dao;

import org.incluemais.model.entities.RecursosPedagogicos;
import java.sql.*;

public class RecursosPedagogicosDAO {
    private final Connection conn;

    public RecursosPedagogicosDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
    }

    public void inserir(RecursosPedagogicos recurso) throws SQLException {
        String sql = "INSERT INTO RecursosPedagogicos ("
                + "adaptacaoDidaticaAulasAvaliacoes, materialDidaticoAdaptado, "
                + "usoTecnologiaAssistiva, tempoEmpregadoAtividadesAvaliacoes) "
                + "VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setBoolean(1, recurso.isAdaptacaoDidaticaAulasAvaliacoes());
            stmt.setBoolean(2, recurso.isMaterialDidaticoAdaptado());
            stmt.setBoolean(3, recurso.isUsoTecnologiaAssistiva());
            stmt.setBoolean(4, recurso.isTempoEmpregadoAtividadesAvaliacoes());

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

    public RecursosPedagogicos buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM RecursosPedagogicos WHERE id = ?";
        RecursosPedagogicos recurso = null;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    recurso = new RecursosPedagogicos();
                    recurso.setId(rs.getInt("id"));
                    recurso.setAdaptacaoDidaticaAulasAvaliacoes(rs.getBoolean("adaptacaoDidaticaAulasAvaliacoes"));
                    recurso.setMaterialDidaticoAdaptado(rs.getBoolean("materialDidaticoAdaptado"));
                    recurso.setUsoTecnologiaAssistiva(rs.getBoolean("usoTecnologiaAssistiva"));
                    recurso.setTempoEmpregadoAtividadesAvaliacoes(rs.getBoolean("tempoEmpregadoAtividadesAvaliacoes"));
                }
            }
        }
        return recurso;
    }

    public boolean excluirP(int id) throws SQLException {
        String sql = "DELETE FROM RecursosPedagogicos WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
}
