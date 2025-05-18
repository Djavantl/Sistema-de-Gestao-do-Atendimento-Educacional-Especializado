package org.incluemais.model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.incluemais.model.entities.RecursoFisicoArquitetonico;

public class RecursoFisicoArquitetonicoDAO {
    private Connection connection;

    public RecursoFisicoArquitetonicoDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RecursoFisicoArquitetonico r) throws SQLException {
        String sql = "INSERT INTO RecursoFisicoArquitetonico (usoCadeiraDeRodas, auxilioTranscricaoEscrita, mesaAdaptadaCadeiraDeRodas, usoDeMuleta, outrosFisicoArquitetonico, outrosEspecificado) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setBoolean(1, r.isUsoCadeiraDeRodas());
            stmt.setBoolean(2, r.isAuxilioTranscricaoEscrita());
            stmt.setBoolean(3, r.isMesaAdaptadaCadeiraDeRodas());
            stmt.setBoolean(4, r.isUsoDeMuleta());
            stmt.setBoolean(5, r.isOutrosFisicoArquitetonico());
            stmt.setString(6, r.getOutrosEspecificado() != null ? r.getOutrosEspecificado() : "");
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    r.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao inserir recurso físico arquitetônico: " + e.getMessage(), e);
        }
    }

    public void atualizar(RecursoFisicoArquitetonico r) throws SQLException {
        String sql = "UPDATE RecursoFisicoArquitetonico SET usoCadeiraDeRodas = ?, auxilioTranscricaoEscrita = ?, mesaAdaptadaCadeiraDeRodas = ?, usoDeMuleta = ?, outrosFisicoArquitetonico = ?, outrosEspecificado = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, r.isUsoCadeiraDeRodas());
            stmt.setBoolean(2, r.isAuxilioTranscricaoEscrita());
            stmt.setBoolean(3, r.isMesaAdaptadaCadeiraDeRodas());
            stmt.setBoolean(4, r.isUsoDeMuleta());
            stmt.setBoolean(5, r.isOutrosFisicoArquitetonico());
            stmt.setString(6, r.getOutrosEspecificado());
            stmt.setInt(7, r.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao atualizar recurso físico arquitetônico: " + e.getMessage(), e);
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM RecursoFisicoArquitetonico WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao deletar recurso físico arquitetônico: " + e.getMessage(), e);
        }
    }

    public RecursoFisicoArquitetonico buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM RecursoFisicoArquitetonico WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return construirRecurso(rs);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao buscar recurso físico arquitetônico por ID: " + e.getMessage(), e);
        }
        return null;
    }

    public List<RecursoFisicoArquitetonico> listarTodos() throws SQLException {
        List<RecursoFisicoArquitetonico> lista = new ArrayList<>();
        String sql = "SELECT * FROM RecursoFisicoArquitetonico";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(construirRecurso(rs));
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao listar recursos físicos arquitetônicos: " + e.getMessage(), e);
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
