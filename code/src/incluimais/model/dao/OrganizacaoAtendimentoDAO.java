package dao;

import connection.DBConnection;
import entities.OrganizacaoAtendimento;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrganizacaoAtendimentoDAO {
    public int insert(OrganizacaoAtendimento org) throws SQLException {
        String sql = "INSERT INTO OrganizacaoAtendimento (periodo, duracao, frequencia, composicao, tipo) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, org.getPeriodo());
            stmt.setString(2, org.getDuracao());
            stmt.setString(3, org.getFrequencia());
            stmt.setString(4, org.getComposicao());
            stmt.setString(5, org.getTipo());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    public OrganizacaoAtendimento getById(int id) throws SQLException {
        String sql = "SELECT * FROM OrganizacaoAtendimento WHERE id = ?";
        OrganizacaoAtendimento org = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    org = new OrganizacaoAtendimento(
                            rs.getString("periodo"),
                            rs.getString("duracao"),
                            rs.getString("frequencia"),
                            rs.getString("composicao"),
                            rs.getString("tipo")
                    );
                    org.setId(id);
                }
            }
        }
        return org;
    }

    public List<OrganizacaoAtendimento> getAll() throws SQLException {
        String sql = "SELECT * FROM OrganizacaoAtendimento";
        List<OrganizacaoAtendimento> organizacoes = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                OrganizacaoAtendimento org = new OrganizacaoAtendimento(
                        rs.getString("periodo"),
                        rs.getString("duracao"),
                        rs.getString("frequencia"),
                        rs.getString("composicao"),
                        rs.getString("tipo")
                );
                org.setId(rs.getInt("id"));
                organizacoes.add(org);
            }
        }
        return organizacoes;
    }

    public void update(OrganizacaoAtendimento org) throws SQLException {
        String sql = "UPDATE OrganizacaoAtendimento SET periodo = ?, duracao = ?, frequencia = ?, " +
                "composicao = ?, tipo = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, org.getPeriodo());
            stmt.setString(2, org.getDuracao());
            stmt.setString(3, org.getFrequencia());
            stmt.setString(4, org.getComposicao());
            stmt.setString(5, org.getTipo());
            stmt.setInt(6, org.getId());

            stmt.executeUpdate();
        }
    }

    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM OrganizacaoAtendimento WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}