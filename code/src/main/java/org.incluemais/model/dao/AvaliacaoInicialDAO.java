package org.incluemais.model.dao;

import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.AvaliacaoInicial;

import java.sql.*;

public class AvaliacaoInicialDAO {

    //Métodos
    public void create(AvaliacaoInicial avaliacaoInicial) throws SQLException{
        String sql = "INSERT INTO AvaliacaoInicial (area, desempenhoVerificado, observacoes) " +
                "VALUES (?, ?, ?)";
        try(Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(2, avaliacaoInicial.getArea());
            stmt.setString(3, avaliacaoInicial.getDesempenhoVerificado());
            stmt.setString(4, avaliacaoInicial.getObservacoes());
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }

    public void upDate(AvaliacaoInicial avaliacaoInicial) throws SQLException{
        String sql = "UPDATE AvaliacaoInicial SET area = ?, desempenhoVerificado = ?, observacoes = ? WHERE id = ?";

        try(DBConnection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setString(1, avaliacaoInicial.getArea());
            stmt.setString(2, avaliacaoInicial.getDesempenhoVerificado());
            stmt.setString(3, avaliacaoInicial.getObservacoes());
            stmt.setInt(4, avaliacaoInicial.getId());
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }

    public List<AvaliacaoInicial> listReviews() throws SQLException{
        String sql = "SELECT FROM * AvaliacaoInicial";

        try(DBConnection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql)){
            while (rs.next()){
                list.add(new AvaliacaoInicial(
                        rs.getString("area"),
                        rs.getString("desempenhoVerificado"),
                        rs.getString("observacoes")
                ));
            }
            return list;
        }
        conn.close();
        stmt.close();
        rs.close();
    }

    public void delet(int id) throws SQLException{
        String sql = "DELETE FROM AvaliacaoInicial WHERE id = ?";

        try(DBConnection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)){
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
        conn.close();
        stmt.close();
    }
}