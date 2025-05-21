package org.incluemais.model.dao;

import org.incluemais.model.entities.RecursosComunicacaoEInformacao;
import java.sql.*;

public class RecursosComunicacaoEInformacaoDAO {
    private final Connection conn;

    public RecursosComunicacaoEInformacaoDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
    }

    public void inserir(RecursosComunicacaoEInformacao recurso) throws SQLException {
        String sql = "INSERT INTO RecursosComunicacaoEInformacao ("
                + "comunicacaoAlternativa, tradutorInterprete, leitorTranscritor, "
                + "interpreteOralizador, guiaInterprete, materialDidaticoBraille, "
                + "materialDidaticoTextoAmpliado, materialDidaticoRelevo, leitorDeTela, "
                + "fonteTamanhoEspecifico) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setBoolean(1, recurso.isComunicacaoAlternativa());
            stmt.setBoolean(2, recurso.isTradutorInterprete());
            stmt.setBoolean(3, recurso.isLeitorTranscritor());
            stmt.setBoolean(4, recurso.isInterpreteOralizador());
            stmt.setBoolean(5, recurso.isGuiaInterprete());
            stmt.setBoolean(6, recurso.isMaterialDidaticoBraille());
            stmt.setBoolean(7, recurso.isMaterialDidaticoTextoAmpliado());
            stmt.setBoolean(8, recurso.isMaterialDidaticoRelevo());
            stmt.setBoolean(9, recurso.isLeitorDeTela());
            stmt.setBoolean(10, recurso.isFonteTamanhoEspecifico());

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