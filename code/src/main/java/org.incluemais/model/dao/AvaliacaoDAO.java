package org.incluemais.model.dao;

import org.incluemais.model.entities.Avaliacao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AvaliacaoDAO {
    private static final Logger logger = Logger.getLogger(AvaliacaoDAO.class.getName());
    private final Connection connection;

    public AvaliacaoDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean inserir(Avaliacao avaliacao, int relatorioId) throws SQLException {
        String sql = "INSERT INTO Avaliacao (area, desempenhoVerificado, observacoes, relatorio_id) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, avaliacao.getArea());
            stmt.setString(2, avaliacao.getDesempenhoVerificado());
            stmt.setString(3, avaliacao.getObservacoes());
            stmt.setInt(4, relatorioId);

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        avaliacao.setId(generatedKeys.getInt(1));
                        return true;
                    }
                }
            }
            return false;
        }
    }

    public boolean atualizar(Avaliacao avaliacao) throws SQLException {
        String sql = "UPDATE Avaliacao SET area = ?, desempenhoVerificado = ?, observacoes = ? WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, avaliacao.getArea());
            stmt.setString(2, avaliacao.getDesempenhoVerificado());
            stmt.setString(3, avaliacao.getObservacoes());
            stmt.setInt(4, avaliacao.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM Avaliacao WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public Avaliacao buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM Avaliacao WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearAvaliacao(rs);
                }
            }
        }
        return null;
    }

    public List<Avaliacao> buscarPorRelatorioId(int relatorioId) throws SQLException {
        List<Avaliacao> avaliacoes = new ArrayList<>();
        String sql = "SELECT * FROM Avaliacao WHERE relatorio_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, relatorioId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    avaliacoes.add(mapearAvaliacao(rs));
                }
            }
        }
        return avaliacoes;
    }

    private Avaliacao mapearAvaliacao(ResultSet rs) throws SQLException {
        Avaliacao avaliacao = new Avaliacao(
                rs.getString("area"),
                rs.getString("desempenhoVerificado"),
                rs.getString("observacoes")
        );
        avaliacao.setId(rs.getInt("id"));
        return avaliacao;
    }

    public boolean excluirPorRelatorioId(int relatorioId) throws SQLException {
        String sql = "DELETE FROM Avaliacao WHERE relatorio_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, relatorioId);
            return stmt.executeUpdate() > 0;
        }
    }
}
