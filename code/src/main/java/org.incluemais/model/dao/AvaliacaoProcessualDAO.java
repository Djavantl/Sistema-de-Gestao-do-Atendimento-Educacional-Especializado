package org.incluemais.model.dao;
import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.AvaliacaoProcessual;
import java.util.ArrayList;
import java.sql.*;
import java.util.List;

public class AvaliacaoProcessualDAO {

    //Métodos
    public void create(AvaliacaoProcessual avaliacaoProcessual) throws SQLException {
        String sql = "INSERT INTO AvaliacaoProcessual (avancosArea, dificuldadesArea, encaminhamentos) " +
                "VALUES (?, ?, ?)";
        try(Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(2, avaliacaoProcessual.getAvancosArea());
            stmt.setString(3, avaliacaoProcessual.getDificuldadesArea());
            stmt.setString(4, avaliacaoProcessual.getEncaminhamentos());
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }

    public void upDate(AvaliacaoProcessual avaliacaoProcessual) throws SQLException{
        String sql = "UPDATE AvaliacaoProcessual SET avancosArea = ?, dificuldadeArea = ?, encaminhamentos = ? WHERE id = ?";

        try(DBConnection conn = BDConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, avaliacaoProcessual.getAvancosArea());
            stmt.setString(2, avaliacaoProcessual.getDificuldadeArea());
            stmt.setString(3, avaliacaoProcessual.getEncaminhamentos());
            stmt.setInt(4, avaliacaoProcessual.getId());
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }

    public List<AvaliacaoProcessual> listReviews() throws SQLException{
        String sql = "SELECT FROM * AvaliacaoProcessual";

        try(DBConnection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)){
            while (rs.next()){
                list.add(new AvaliacaoProcessual(
                        rs.getString("avancosArea"),
                        rs.getString("dificuldadeArea"),
                        rs.getString("encaminhamentos")
                ));
            }
            return list;
        }
        conn.close();
        stmt.close();
        rs.close();
    }

    public void delet(int id) throws SQLException{
        String sql = "DELETE FROM AvaliacaoProcessual WHERE id = ?";

        try(DBConnection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }
}