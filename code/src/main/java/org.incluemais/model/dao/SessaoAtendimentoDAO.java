package org.incluemais.model.dao;

import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.SessaoAtendimento;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class SessaoAtendimentoDAO {
    private Connection connection;
    private AlunoDAO alunoDAO;

    public SessaoAtendimentoDAO(Connection connection) {
        this.connection = connection;
        this.alunoDAO = new AlunoDAO(connection);
    }

    public void inserir(SessaoAtendimento s) throws SQLException {
        String sql = "INSERT INTO SessaoAtendimento (aluno_matricula, data, horario, local) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, s.getAluno().getMatricula());
            stmt.setDate(2, Date.valueOf(s.getData()));
            stmt.setTime(3, Time.valueOf(s.getHorario()));
            stmt.setString(4, s.getLocal());
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    s.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao inserir sessão de atendimento: " + e.getMessage(), e);
        }
    }

    public void atualizar(SessaoAtendimento s) throws SQLException {
        String sql = "UPDATE SessaoAtendimento SET aluno_matricula = ?, data = ?, horario = ?, local = ?, presenca = ?, observacoes = ? WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, s.getAluno().getMatricula());
            stmt.setDate(2, Date.valueOf(s.getData()));
            stmt.setTime(3, Time.valueOf(s.getHorario()));
            stmt.setString(4, s.getLocal());
            stmt.setBoolean(5, s.isPresenca());
            stmt.setString(6, s.getObservacoes());
            stmt.setInt(7, s.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao atualizar sessão de atendimento: " + e.getMessage(), e);
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM SessaoAtendimento WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao deletar sessão de atendimento: " + e.getMessage(), e);
        }
    }

    public SessaoAtendimento buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM SessaoAtendimento WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return construirSessao(rs);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao buscar sessão de atendimento por ID: " + e.getMessage(), e);
        }
        return null;
    }

    public List<SessaoAtendimento> listarTodos() throws SQLException {
        List<SessaoAtendimento> lista = new ArrayList<>();
        String sql = "SELECT * FROM SessaoAtendimento";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(construirSessao(rs));
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao listar sessões de atendimento: " + e.getMessage(), e);
        }
        return lista;
    }

    private SessaoAtendimento construirSessao(ResultSet rs) throws SQLException {
        int id = rs.getInt("id");
        String matricula = rs.getString("aluno_matricula");
        LocalDate data = rs.getDate("data").toLocalDate();
        LocalTime horario = rs.getTime("horario").toLocalTime();
        String local = rs.getString("local");
        boolean presenca = rs.getBoolean("presenca");

        Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
        if (aluno == null) {
            throw new SQLException("Aluno com matrícula " + matricula + " não encontrado.");
        }
        SessaoAtendimento s = new SessaoAtendimento(aluno, data, horario, local);
        s.setId(id);
        s.setPresenca(presenca);
        return s;
    }
}
