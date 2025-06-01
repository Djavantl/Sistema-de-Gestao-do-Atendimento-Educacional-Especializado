package org.incluemais.model.dao;

import org.incluemais.model.entities.Avaliacao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AvaliacaoDAO {
    private final Connection conn;

    public AvaliacaoDAO(Connection conn) {
        this.conn = conn;
    }

    /**
     * Insere uma nova avaliação vinculada ao relatório de id = relatorioId.
     * Retorna true se a inserção ocorreu sem erros, ou false caso contrário.
     */
    public boolean inserir(Avaliacao avaliacao, int relatorioId) throws SQLException {
        // 1) Primeiro, insere na tabela Avaliacao (para gerar o ID).
        String sqlInsereAvaliacao =
                "INSERT INTO Avaliacao (area, desempenhoVerificado, observacoes) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sqlInsereAvaliacao, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, avaliacao.getArea());
            ps.setString(2, avaliacao.getDesempenhoVerificado());
            ps.setString(3, avaliacao.getObservacoes());

            int affected = ps.executeUpdate();
            if (affected == 0) {
                return false;
            }

            // Recupera o ID que acabou de ser gerado
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    int idGerado = rs.getInt(1);
                    avaliacao.setId(idGerado);
                } else {
                    return false; // não conseguiu obter chave
                }
            }
        }

        // 2) Agora que temos avaliacao.getId(), insere também em Relatorio_Avaliacao:
        String sqlVincula =
                "INSERT INTO Relatorio_Avaliacao (relatorio_id, avaliacao_id) VALUES (?, ?)";
        try (PreparedStatement ps2 = conn.prepareStatement(sqlVincula)) {
            ps2.setInt(1, relatorioId);
            ps2.setInt(2, avaliacao.getId());
            int affected2 = ps2.executeUpdate();
            return (affected2 > 0);
        }
    }

    /**
     * Busca uma avaliação pelo seu ID. Retorna Optional.empty() se não encontrar.
     */
    public Avaliacao buscarPorId(int id) throws SQLException {
        String sql =
                "SELECT id, area, desempenhoVerificado, observacoes " +
                        "FROM Avaliacao WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Avaliacao a = new Avaliacao();
                    a.setId(rs.getInt("id"));
                    a.setArea(rs.getString("area"));
                    a.setDesempenhoVerificado(rs.getString("desempenhoVerificado"));
                    a.setObservacoes(rs.getString("observacoes"));
                    return a;
                }
            }
        }
        return null;
    }

    /**
     * Atualiza todos os campos de uma avaliação (exceto relatorio_id, que não mudamos aqui).
     */
    public boolean atualizar(Avaliacao avaliacao) throws SQLException {
        String sql =
                "UPDATE Avaliacao " +
                        "SET area = ?, desempenhoVerificado = ?, observacoes = ? " +
                        "WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, avaliacao.getArea());
            ps.setString(2, avaliacao.getDesempenhoVerificado());
            ps.setString(3, avaliacao.getObservacoes());
            ps.setInt(4, avaliacao.getId());
            int rows = ps.executeUpdate();
            return (rows > 0);
        }
    }

    /**
     * Exclui uma avaliação pelo ID.
     */
    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM Avaliacao WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return (rows > 0);
        }
    }

    /**
     * Monta um objeto Avaliacao a partir do ResultSet na posição atual.
     */
    private Avaliacao montarAvaliacao(ResultSet rs) throws SQLException {
        Avaliacao a = new Avaliacao();
        a.setId(rs.getInt("id"));
        a.setArea(rs.getString("area"));
        a.setDesempenhoVerificado(rs.getString("desempenho_verificado"));
        a.setObservacoes(rs.getString("observacoes"));
        // Se seu construtor incluir relatorioId, você pode fazer:
        // a.setRelatorioId(rs.getInt("relatorio_id"));
        return a;
    }

    public boolean relatorioExiste(int id) throws SQLException {
        String sql = "SELECT 1 FROM Relatorio WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public List<Avaliacao> listarPorRelatorio(int relatorioId) throws SQLException {
        String sql =
                "SELECT a.id, a.area, a.desempenhoVerificado, a.observacoes " +
                        "FROM Avaliacao a " +
                        "INNER JOIN Relatorio_Avaliacao ra ON a.id = ra.avaliacao_id " +
                        "WHERE ra.relatorio_id = ?";
        List<Avaliacao> lista = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, relatorioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Avaliacao a = new Avaliacao();
                    a.setId(rs.getInt("id"));
                    a.setArea(rs.getString("area"));
                    a.setDesempenhoVerificado(rs.getString("desempenhoVerificado"));
                    a.setObservacoes(rs.getString("observacoes"));
                    lista.add(a);
                }
            }
        }
        return lista;
    }
}