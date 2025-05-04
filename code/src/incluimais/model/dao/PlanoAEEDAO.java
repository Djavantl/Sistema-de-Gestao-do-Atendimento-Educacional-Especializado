package dao;

import connection.DBConnection;
import entities.PlanoAEE;
import entities.AvaliacaoInicial;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PlanoAEEDAO {
    public int insert(PlanoAEE plano) throws SQLException {
        String sql = "INSERT INTO PlanoAEE (dataInicio, avaliacao_id, recomendacoes) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setDate(1, Date.valueOf(plano.getDataInicio()));

            if (plano.getAvaliacao() != null) {
                AvaliacaoInicialDAO avaliacaoDAO = new AvaliacaoInicialDAO();
                int avaliacaoId = avaliacaoDAO.insert(plano.getAvaliacao());
                stmt.setInt(2, avaliacaoId);
            } else {
                stmt.setNull(2, Types.INTEGER);
            }

            stmt.setString(3, plano.getRecomendacoes());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    public PlanoAEE getById(int id) throws SQLException {
        String sql = "SELECT * FROM PlanoAEE WHERE id = ?";
        PlanoAEE plano = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    plano = new PlanoAEE(
                            null, // Aluno será configurado depois
                            rs.getDate("dataInicio").toLocalDate(),
                            null, // Avaliação será configurada depois
                            rs.getString("recomendacoes")
                    );
                    plano.setId(id);

                    // Configurar avaliação se existir
                    int avaliacaoId = rs.getInt("avaliacao_id");
                    if (!rs.wasNull()) {
                        AvaliacaoInicialDAO avaliacaoDAO = new AvaliacaoInicialDAO();
                        plano.setAvaliacao(avaliacaoDAO.getById(avaliacaoId));
                    }
                }
            }
        }
        return plano;
    }

    public List<PlanoAEE> getAll() throws SQLException {
        String sql = "SELECT * FROM PlanoAEE";
        List<PlanoAEE> planos = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                PlanoAEE plano = new PlanoAEE(
                        null, // Aluno será configurado depois
                        rs.getDate("dataInicio").toLocalDate(),
                        null, // Avaliação será configurada depois
                        rs.getString("recomendacoes")
                );
                plano.setId(rs.getInt("id"));

                // Configurar avaliação se existir
                int avaliacaoId = rs.getInt("avaliacao_id");
                if (!rs.wasNull()) {
                    AvaliacaoInicialDAO avaliacaoDAO = new AvaliacaoInicialDAO();
                    plano.setAvaliacao(avaliacaoDAO.getById(avaliacaoId));
                }

                planos.add(plano);
            }
        }
        return planos;
    }

    public void update(PlanoAEE plano) throws SQLException {
        String sql = "UPDATE PlanoAEE SET dataInicio = ?, avaliacao_id = ?, recomendacoes = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setDate(1, Date.valueOf(plano.getDataInicio()));

            if (plano.getAvaliacao() != null) {
                AvaliacaoInicialDAO avaliacaoDAO = new AvaliacaoInicialDAO();
                if (plano.getAvaliacao().getId() == 0) {
                    int avaliacaoId = avaliacaoDAO.insert(plano.getAvaliacao());
                    plano.getAvaliacao().setId(avaliacaoId);
                } else {
                    avaliacaoDAO.update(plano.getAvaliacao());
                }
                stmt.setInt(2, plano.getAvaliacao().getId());
            } else {
                stmt.setNull(2, Types.INTEGER);
            }

            stmt.setString(3, plano.getRecomendacoes());
            stmt.setInt(4, plano.getId());

            stmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        // Primeiro deleta as associações com metas e propostas
        String sqlDeleteMetas = "DELETE FROM PlanoAEE_Meta WHERE plano_id = ?";
        String sqlDeletePropostas = "DELETE FROM PlanoAEE_PropostaPedagogica WHERE plano_id = ?";
        String sqlDeletePlano = "DELETE FROM PlanoAEE WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmtMetas = conn.prepareStatement(sqlDeleteMetas);
             PreparedStatement stmtPropostas = conn.prepareStatement(sqlDeletePropostas);
             PreparedStatement stmtPlano = conn.prepareStatement(sqlDeletePlano)) {

            // Deleta associações com metas
            stmtMetas.setInt(1, id);
            stmtMetas.executeUpdate();

            // Deleta associações com propostas
            stmtPropostas.setInt(1, id);
            stmtPropostas.executeUpdate();

            // Deleta o plano
            stmtPlano.setInt(1, id);
            stmtPlano.executeUpdate();
        }
    }

    public void adicionarMeta(int planoId, int metaId) throws SQLException {
        String sql = "INSERT INTO PlanoAEE_Meta (plano_id, meta_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, planoId);
            stmt.setInt(2, metaId);
            stmt.executeUpdate();
        }
    }

    public void removerMeta(int planoId, int metaId) throws SQLException {
        String sql = "DELETE FROM PlanoAEE_Meta WHERE plano_id = ? AND meta_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, planoId);
            stmt.setInt(2, metaId);
            stmt.executeUpdate();
        }
    }

    public void adicionarProposta(int planoId, int propostaId) throws SQLException {
        String sql = "INSERT INTO PlanoAEE_PropostaPedagogica (plano_id, proposta_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, planoId);
            stmt.setInt(2, propostaId);
            stmt.executeUpdate();
        }
    }

    public void removerProposta(int planoId, int propostaId) throws SQLException {
        String sql = "DELETE FROM PlanoAEE_PropostaPedagogica WHERE plano_id = ? AND proposta_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, planoId);
            stmt.setInt(2, propostaId);
            stmt.executeUpdate();
        }
    }
}
