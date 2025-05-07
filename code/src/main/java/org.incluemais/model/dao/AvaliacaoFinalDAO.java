package org.incluemais.model.dao;

import java.sql.*;
import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.AvaliacaoFinal;
import java.util.ArrayList;
import java.util.List;

public class AvaliacaoFinalDAO {

    //Métodos
    public void create(AvaliacaoFinal avaliacaoFinal) throws SQLException{
        String sql = "INSERT INTO AvaliacaoFinal (alcancadoArea, naoAlcancadoArea, relatorioFinal) " +
                "VALUES (?, ?, ?)";
        try(Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(2, avaliacaoFinal.getAlacancadoArea());
            stmt.setString(3, avaliacaoFinal.getNaoAlcancadoArea());
            stmt.setString(4, avaliacaoFinal.getRelatorioFinal());
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }

    public void upDate(AvaliacaoFinal avaliacaoFinal) throws SQLException{
        String sql = "UPDATE AvaliacaoFinal SET alcancadoArea = ?, naoAlcancadoArea = ?, relatorioFinal = ? WHERE id = ?";

        try(DBConnection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, avaliacaoFinal.getAlcancadoArea());
            stmt.setString(2, avaliacaoFinal.getNaoAlcancadoArea());
            stmt.setString(3, avaliacaoFinal.getRelatorioFinal());
            stmt.setInt(4, avaliacaoFinal.getId());
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }

    public List<AvaliacaoFinal> listReviews() throws SQLException{
        String sql = "SELECT FROM * AvaliacaoFinal";

        try(DBConnection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)){
            while (rs.next()){
                list.add(new AvaliacaoFinal(
                        rs.getString("alcancadoArea"),
                        rs.getString("naoAlcancadoArea"),
                        rs.getString("relatorioFinal")
                ));
            }
            return list;
        }
        conn.close();
        stmt.close();
        rs.close();
    }

    public void delet(int idDelete) throws SQLException{
        String sql = "DELETE FROM AvaliacaoFinal WHERE id = ?";

        try(DBConnection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setInt(1, idDelete);
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }
}
