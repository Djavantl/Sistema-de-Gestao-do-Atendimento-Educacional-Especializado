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


            stmt.executeUpdate();

        }
        return -1;
    }

}