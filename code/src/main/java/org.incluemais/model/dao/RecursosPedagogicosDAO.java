package org.incluemais.model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.incluemais.model.entities.RecursosPedagogicos;

public class RecursosPedagogicosDAO {
    private Connection connection;

    public RecursosPedagogicosDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RecursosPedagogicos r) throws SQLException {
        String sql = "INSERT INTO RecursosPedagogicos (adaptacaoDidaticaAulasAvaliacoes, materialDidaticoAdaptado, usoTecnologiaAssistiva, tempoEmpregadoAtividadesAvaliacoes) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setBoolean(1, r.isAdaptacaoDidaticaAulasAvaliacoes());
            stmt.setBoolean(2, r.isMaterialDidaticoAdaptado());
            stmt.setBoolean(3, r.isUsoTecnologiaAssistiva());
            stmt.setBoolean(4, r.isTempoEmpregadoAtividadesAvaliacoes());
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    r.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao inserir recurso pedagógico: " + e.getMessage(), e);
        }
    }

    public void atualizar(RecursosPedagogicos r) throws SQLException {
        String sql = "UPDATE RecursosPedagogicos SET adaptacaoDidaticaAulasAvaliacoes = ?, materialDidaticoAdaptado = ?, usoTecnologiaAssistiva = ?, tempoEmpregadoAtividadesAvaliacoes = ? WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, r.isAdaptacaoDidaticaAulasAvaliacoes());
            stmt.setBoolean(2, r.isMaterialDidaticoAdaptado());
            stmt.setBoolean(3, r.isUsoTecnologiaAssistiva());
            stmt.setBoolean(4, r.isTempoEmpregadoAtividadesAvaliacoes());
            stmt.setInt(5, r.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao atualizar recurso pedagógico: " + e.getMessage(), e);
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM RecursosPedagogicos WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao deletar recurso pedagógico: " + e.getMessage(), e);
        }
    }

    public RecursosPedagogicos buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM RecursosPedagogicos WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return construirRecurso(rs);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao buscar recurso pedagógico por ID: " + e.getMessage(), e);
        }
        return null;
    }

    public List<RecursosPedagogicos> listarTodos() throws SQLException {
        List<RecursosPedagogicos> lista = new ArrayList<>();
        String sql = "SELECT * FROM RecursosPedagogicos";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(construirRecurso(rs));
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao listar recursos pedagógicos: " + e.getMessage(), e);
        }
        return lista;
    }

    private RecursosPedagogicos construirRecurso(ResultSet rs) throws SQLException {
        RecursosPedagogicos r = new RecursosPedagogicos();
        r.setId(rs.getInt("id"));
        r.setAdaptacaoDidaticaAulasAvaliacoes(rs.getBoolean("adaptacaoDidaticaAulasAvaliacoes"));
        r.setMaterialDidaticoAdaptado(rs.getBoolean("materialDidaticoAdaptado"));
        r.setUsoTecnologiaAssistiva(rs.getBoolean("usoTecnologiaAssistiva"));
        r.setTempoEmpregadoAtividadesAvaliacoes(rs.getBoolean("tempoEmpregadoAtividadesAvaliacoes"));
        return r;
    }
}
