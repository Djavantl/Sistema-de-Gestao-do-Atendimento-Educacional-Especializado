package dao;

import model.RecursoFisicoArquitetonico;
import java.sql.*;

public class RecursoFisicoArquitetonicoDAO {
    private Connection connection;

    public RecursoFisicoArquitetonicoDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RecursoFisicoArquitetonico rfa) throws SQLException {
        String sql = "INSERT INTO recursofisicoarquitetonico (cadeira_rodas, transcricao_escrita, mesa_adaptada, muleta, outros, outros_especificado) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setBoolean(1, rfa.isUsoCadeiraDeRodas());
        stmt.setBoolean(2, rfa.isAuxilioTranscricaoEscrita());
        stmt.setBoolean(3, rfa.isMesaAdaptadaCadeiraDeRodas());
        stmt.setBoolean(4, rfa.isUsoDeMuleta());
        stmt.setBoolean(5, rfa.isOutrosFisicoArquitetonico());
        stmt.setString(6, rfa.getOutrosEspecificado());
        stmt.executeUpdate();
    }

    public RecursoFisicoArquitetonico buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM recursofisicoarquitetonico WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            RecursoFisicoArquitetonico rfa = new RecursoFisicoArquitetonico();
            rfa.setUsoCadeiraDeRodas(rs.getBoolean("cadeira_rodas"));
            rfa.setAuxilioTranscricaoEscrita(rs.getBoolean("transcricao_escrita"));
            rfa.setMesaAdaptadaCadeiraDeRodas(rs.getBoolean("mesa_adaptada"));
            rfa.setUsoDeMuleta(rs.getBoolean("muleta"));
            rfa.setOutrosFisicoArquitetonico(rs.getBoolean("outros"));
            rfa.setOutrosEspecificado(rs.getString("outros_especificado"));
            return rfa;
        }
        return null;
    }

    public void atualizar(RecursoFisicoArquitetonico rfa) throws SQLException {
        String sql = "UPDATE recursofisicoarquitetonico SET cadeira_rodas = ?, transcricao_escrita = ?, mesa_adaptada = ?, muleta = ?, outros = ?, outros_especificado = ? WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setBoolean(1, rfa.isUsoCadeiraDeRodas());
        stmt.setBoolean(2, rfa.isAuxilioTranscricaoEscrita());
        stmt.setBoolean(3, rfa.isMesaAdaptadaCadeiraDeRodas());
        stmt.setBoolean(4, rfa.isUsoDeMuleta());
        stmt.setBoolean(5, rfa.isOutrosFisicoArquitetonico());
        stmt.setString(6, rfa.getOutrosEspecificado());
        stmt.executeUpdate();
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM recursofisicoarquitetonico WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }
}
