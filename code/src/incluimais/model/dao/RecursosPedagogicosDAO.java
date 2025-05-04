package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import entities.RecursosPedagogicos;

public class RecursosPedagogicosDAO {
    private Connection connection;

    public RecursosPedagogicosDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RecursosPedagogicos r) throws SQLException {
        String sql = "INSERT INTO RecursosPedagogicos (adaptacaoDidaticaAulasAvaliacoes, materialDidaticoAdaptado, usoTecnologiaAssistiva, tempoEmpregadoAtividadesAvaliacoes) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        stmt.setBoolean(1, r.isAdaptacaoDidaticaAulasAvaliacoes());
        stmt.setBoolean(2, r.isMaterialDidaticoAdaptado());
        stmt.setBoolean(3, r.isUsoTecnologiaAssistiva());
        stmt.setBoolean(4, r.isTempoEmpregadoAtividadesAvaliacoes());
        stmt.executeUpdate();

        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            r.setId(rs.getInt(1));
        }
    }

    public void atualizar(RecursosPedagogicos r) throws SQLException {
        String sql = "UPDATE RecursosPedagogicos SET adaptacaoDidaticaAulasAvaliacoes = ?, materialDidaticoAdaptado = ?, usoTecnologiaAssistiva = ?, tempoEmpregadoAtividadesAvaliacoes = ? WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setBoolean(1, r.isAdaptacaoDidaticaAulasAvaliacoes());
        stmt.setBoolean(2, r.isMaterialDidaticoAdaptado());
        stmt.setBoolean(3, r.isUsoTecnologiaAssistiva());
        stmt.setBoolean(4, r.isTempoEmpregadoAtividadesAvaliacoes());
        stmt.setInt(5, r.getId());
        stmt.executeUpdate();
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM RecursosPedagogicos WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public RecursosPedagogicos buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM RecursosPedagogicos WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return construir(rs);
        }
        return null;
    }

    public List<RecursosPedagogicos> listarTodos() throws SQLException {
        List<RecursosPedagogicos> lista = new ArrayList<>();
        String sql = "SELECT * FROM RecursosPedagogicos";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            lista.add(construir(rs));
        }
        return lista;
    }

    private RecursosPedagogicos construir(ResultSet rs) throws SQLException {
        RecursosPedagogicos r = new RecursosPedagogicos();
        r.setId(rs.getInt("id"));
        r.setAdaptacaoDidaticaAulasAvaliacoes(rs.getBoolean("adaptacaoDidaticaAulasAvaliacoes"));
        r.setMaterialDidaticoAdaptado(rs.getBoolean("materialDidaticoAdaptado"));
        r.setUsoTecnologiaAssistiva(rs.getBoolean("usoTecnologiaAssistiva"));
        r.setTempoEmpregadoAtividadesAvaliacoes(rs.getBoolean("tempoEmpregadoAtividadesAvaliacoes"));
        return r;
    }
}
