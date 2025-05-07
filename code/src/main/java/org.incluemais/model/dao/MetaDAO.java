package org.incluemais.model.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MetaDAO {

    //Métodos
    public void insert(Meta meta) throws SQLException{
        String slq = "INSET INTO Meta (descricao, status) VALUES (?, ?)";

        try(BDConnection conn = BDConnection.getConnection; PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, meta.getDescricao());
            stmt.setString(2, meta.getStatus());
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }
}
