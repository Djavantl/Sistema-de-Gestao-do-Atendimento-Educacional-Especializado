package dao;

import model.RecursosPedagogicos;
import java.sql.*;

public class RecursoPedagogicosDAO {
    private Connection connection;

    public RecursoPedagogicosDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RecursosPedagogicos rp) throws SQLException {
        String sql = "INSERT INTO recursospedagogicos (adaptacao_didatica, material_adaptado, tecnologia_assistiva, tempo_empregado) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setBoolean(1, rp.isAdaptacaoDidaticaAulasAvaliacoes());
        stmt.setBoolean(2, rp.isMaterialDidaticoAdaptado());
        stmt.setBoolean(3, rp.isUsoTecnologiaAssistiva());
        stmt.setBoolean(4, rp.isTempoEmpregadoAtividadesAvaliacoes());
        stmt.executeUpdate();
    }

    public RecursosPedagogicos buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM recursospedagogicos WHERE id=?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            RecursosPedagogicos rp = new RecursosPedagogicos();
            rp.setAdaptacaoDidaticaAulasAvaliacoes(rs.getBoolean("adaptacao_didatica"));
            rp.setMaterialDidaticoAdaptado(rs.getBoolean("material_adaptado"));
            rp.setUsoTecnologiaAssistiva(rs.getBoolean("tecnologia_assistiva"));
            rp.setTempoEmpregadoAtividadesAvaliacoes(rs.getBoolean("tempo_empregado"));
            return rp;
        }
        return null;
    }

    public void atualizar(RecursosPedagogicos rp) throws SQLException {
        String sql = "UPDATE recursospedagogicos SET adaptacao_didatica=?, material_adaptado=?, tecnologia_assistiva=?, tempo_empregado=? WHERE id=?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setBoolean(1, rp.isAdaptacaoDidaticaAulasAvaliacoes());
        stmt.setBoolean(2, rp.isMaterialDidaticoAdaptado());
        stmt.setBoolean(3, rp.isUsoTecnologiaAssistiva());
        stmt.setBoolean(4, rp.isTempoEmpregadoAtividadesAvaliacoes());
        stmt.executeUpdate();
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM recursospedagogicos WHERE id=?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }
}
