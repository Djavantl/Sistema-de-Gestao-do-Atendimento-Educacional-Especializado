package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import conexao.Conexao;
import model.RecursoFisicoArquitetonico;

public class RecursoFisicoArquitetonicoDAO {
    private Connection connection;

    public RecursoFisicoArquitetonicoDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RecursoFisicoArquitetonico r) throws SQLException {
        String sql = "INSERT INTO RecursoFisicoArquitetonico (usoCadeiraDeRodas, auxilioTranscricaoEscrita, mesaAdaptadaCadeiraDeRodas, usoDeMuleta, outrosFisicoArquitetonico, outrosEspecificado) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setBoolean(1, r.isUsoCadeiraDeRodas());
        stmt.setBoolean(2, r.isAuxilioTranscricaoEscrita());
        stmt.setBoolean(3, r.isMesaAdaptadaCadeiraDeRodas());
        stmt.setBoolean(4, r.isUsoDeMuleta());
        stmt.setBoolean(5, r.isOutrosFisicoArquitetonico());
        stmt.setString(6, r.getOutrosEspecificado());
        stmt.executeUpdate();

        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            r.setId(rs.getInt(1));
        }
    }

    public void atualizar(RecursoFisicoArquitetonico r) throws SQLException {
        String sql = "UPDATE RecursoFisicoArquitetonico SET usoCadeiraDeRodas = ?, auxilioTranscricaoEscrita = ?, mesaAdaptadaCadeiraDeRodas = ?, usoDeMuleta = ?, outrosFisicoArquitetonico = ?, outrosEspecificado = ? WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setBoolean(1, r.isUsoCadeiraDeRodas());
        stmt.setBoolean(2, r.isAuxilioTranscricaoEscrita());
        stmt.setBoolean(3, r.isMesaAdaptadaCadeiraDeRodas());
        stmt.setBoolean(4, r.isUsoDeMuleta());
        stmt.setBoolean(5, r.isOutrosFisicoArquitetonico());
        stmt.setString(6, r.getOutrosEspecificado());
        stmt.setInt(7, r.getId());
        stmt.executeUpdate();
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM RecursoFisicoArquitetonico WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public RecursoFisicoArquitetonico buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM RecursoFisicoArquitetonico WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return construirRecurso(rs);
        }
        return null;
    }

    public List<RecursoFisicoArquitetonico> listarTodos() throws SQLException {
        List<RecursoFisicoArquitetonico> lista = new ArrayList<>();
        String sql = "SELECT * FROM RecursoFisicoArquitetonico";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            lista.add(construirRecurso(rs));
        }
        return lista;
    }

    private RecursoFisicoArquitetonico construirRecurso(ResultSet rs) throws SQLException {
        RecursoFisicoArquitetonico r = new RecursoFisicoArquitetonico();
        r.setId(rs.getInt("id"));
        r.setUsoCadeiraDeRodas(rs.getBoolean("usoCadeiraDeRodas"));
        r.setAuxilioTranscricaoEscrita(rs.getBoolean("auxilioTranscricaoEscrita"));
        r.setMesaAdaptadaCadeiraDeRodas(rs.getBoolean("mesaAdaptadaCadeiraDeRodas"));
        r.setUsoDeMuleta(rs.getBoolean("usoDeMuleta"));
        r.setOutrosFisicoArquitetonico(rs.getBoolean("outrosFisicoArquitetonico"));
        r.setOutrosEspecificado(rs.getString("outrosEspecificado"));
        return r;
    }
}
