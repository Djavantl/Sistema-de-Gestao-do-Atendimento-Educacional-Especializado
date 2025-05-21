
package org.incluemais.model.dao;
import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.OrganizacaoAtendimento;
import org.incluemais.model.connection.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class OrganizacaoAtendimentoDAO {
    private static final Logger logger = Logger.getLogger(AlunoDAO.class.getName());
    private final Connection conn;

    public OrganizacaoAtendimentoDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
    }

    public int insert(OrganizacaoAtendimento org) throws SQLException {
        String sql = "INSERT INTO OrganizacaoAtendimento (periodo, duracao, frequencia, composicao, tipo, aluno_matricula) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, org.getPeriodo());
            stmt.setString(2, org.getDuracao());
            stmt.setString(3, org.getFrequencia());
            stmt.setString(4, org.getComposicao());
            stmt.setString(5, org.getTipo());
            stmt.setString(6, org.getAluno().getMatricula());

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
        String sql = """
        SELECT 
            o.id,
            o.periodo,
            o.duracao,
            o.frequencia,
            o.composicao,
            o.tipo,
            a.pessoa_id,
            a.matricula
        FROM OrganizacaoAtendimento o
        INNER JOIN Aluno a ON o.aluno_matricula = a.matricula
        WHERE o.id = ?
        """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Aluno aluno = new Aluno();
                    aluno.setId(rs.getInt("pessoa_id"));
                    aluno.setMatricula(rs.getString("matricula"));
                    aluno.setNome(rs.getString("nome"));

                    OrganizacaoAtendimento org = new OrganizacaoAtendimento(
                            aluno,
                            rs.getString("periodo"),
                            rs.getString("duracao"),
                            rs.getString("frequencia"),
                            rs.getString("composicao"),
                            rs.getString("tipo")
                    );
                    org.setId(id);
                    return org;
                }
            }
        }
        return null;
    }


    public OrganizacaoAtendimento buscarPorAlunoMatricula(String matricula) throws SQLException {
        String sql = """
        SELECT o.*, p.*, a.* 
        FROM OrganizacaoAtendimento o
        INNER JOIN Aluno a ON o.aluno_matricula = a.matricula
        INNER JOIN Pessoa p ON a.pessoa_id = p.id
        WHERE o.aluno_matricula = ?
        """;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Aluno aluno = new AlunoDAO(conn).mapearAluno(rs);

                    return new OrganizacaoAtendimento(
                            aluno,
                            rs.getString("periodo"),
                            rs.getString("duracao"),
                            rs.getString("frequencia"),
                            rs.getString("composicao"),
                            rs.getString("tipo")
                    );
                }
            }
        }
        return null;
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

    public Integer buscarIdPorMatricula(String matricula) throws SQLException {
        String sql = "SELECT id FROM OrganizacaoAtendimento WHERE aluno_matricula = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        }
        return null;
    }

    public void update(OrganizacaoAtendimento org) throws SQLException {
        String sql = "UPDATE OrganizacaoAtendimento SET periodo=?, duracao=?, frequencia=?, composicao=?, tipo=? WHERE id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}