package org.incluemais.model.dao;

import org.incluemais.model.entities.SessaoAtendimento;
import java.sql.*;

public class SessaoAtendimentoDAO {
    private Connection conn;

    public SessaoAtendimentoDAO(Connection connection) {
        this.conn = conn;
    }

    public void inserir(SessaoAtendimento sessao) throws SQLException {
        String sql = "INSERT INTO SessaoAtendimento (aluno_matricula, data, horario, local, presenca_id, ausencia_id, participantes) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, sessao.getAluno().getMatricula());
            stmt.setDate(2, Date.valueOf(sessao.getData()));
            stmt.setTime(3, Time.valueOf(sessao.getHorario()));
            stmt.setString(4, sessao.getLocal());
            stmt.setObject(5, sessao.getPresenca() != null ? sessao.getPresenca().getId() : null);
            stmt.setObject(6, sessao.getAusencia() != null ? sessao.getAusencia().getId() : null);
            stmt.setString(7, sessao.getParticipantes());

            stmt.executeUpdate();

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    sessao.setId(generatedKeys.getInt(1));
                }
            }
        }
    }

    public SessaoAtendimento buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM SessaoAtendimento WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    SessaoAtendimento sessao = new SessaoAtendimento(
                            null, // carregar Aluno separadamente
                            rs.getDate("data").toLocalDate(),
                            rs.getTime("horario").toLocalTime(),
                            rs.getString("local"),
                            rs.getString("participantes")
                    );
                    sessao.setId(rs.getInt("id"));
                    // você pode carregar RegistroPresenca e RegistroAusencia usando seus DAOs
                    return sessao;
                }
            }
        }
        return null;
    }

    public void atualizar(SessaoAtendimento sessao) throws SQLException {
        String sql = "UPDATE SessaoAtendimento SET aluno_matricula = ?, data = ?, horario = ?, local = ?, presenca_id = ?, ausencia_id = ?, participantes = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sessao.getAluno().getMatricula());
            stmt.setDate(2, Date.valueOf(sessao.getData()));
            stmt.setTime(3, Time.valueOf(sessao.getHorario()));
            stmt.setString(4, sessao.getLocal());
            stmt.setObject(5, sessao.getPresenca() != null ? sessao.getPresenca().getId() : null);
            stmt.setObject(6, sessao.getAusencia() != null ? sessao.getAusencia().getId() : null);
            stmt.setString(7, sessao.getParticipantes());
            stmt.setInt(8, sessao.getId());
            stmt.executeUpdate();
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM SessaoAtendimento WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}

