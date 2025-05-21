package org.incluemais.model.dao;

import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.ProfessorAEE;
import org.incluemais.model.entities.Relatorio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RelatorioDAO {
    private static final Logger logger = Logger.getLogger(RelatorioDAO.class.getName());
    private final Connection connection;

    public RelatorioDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(Relatorio r) throws SQLException {
        String sql = "INSERT INTO Relatorio (titulo, dataGeracao, aluno_matricula, professorAEE_siape, resumo, observacoes) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, r.getTitulo());
            stmt.setDate(2, Date.valueOf(r.getDataGeracao()));
            stmt.setString(3, r.getAluno().getMatricula());

            // Trata professor opcional
            if (r.getProfessorAEE() != null) {
                stmt.setString(4, r.getProfessorAEE().getSiape());
            } else {
                stmt.setNull(4, Types.VARCHAR);
            }

            stmt.setString(5, r.getResumo());
            stmt.setString(6, r.getObservacoes());

            stmt.executeUpdate();
        }
    }

    public void atualizar(Relatorio r) throws SQLException {
        String sql = "UPDATE Relatorio SET titulo=?, dataGeracao=?, aluno_matricula=?, " +
                "professorAEE_siape=?, resumo=?, observacoes=? WHERE id=?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, r.getTitulo());
            stmt.setDate(2, Date.valueOf(r.getDataGeracao()));
            stmt.setString(3, r.getAluno().getMatricula());

            // Trata professor opcional
            if (r.getProfessorAEE() != null) {
                stmt.setString(4, r.getProfessorAEE().getSiape());
            } else {
                stmt.setNull(4, Types.VARCHAR);
            }

            stmt.setString(5, r.getResumo());
            stmt.setString(6, r.getObservacoes());
            stmt.setInt(7, r.getId());

            stmt.executeUpdate();
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM Relatorio WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Relatorio> buscarTodos() throws SQLException {
        List<Relatorio> relatorios = new ArrayList<>();
        String sql = "SELECT r.*, a.nome as aluno_nome, a.matricula, p.nome as professor_nome, p.siape " +
                "FROM Relatorio r " +
                "JOIN Aluno a ON r.aluno_matricula = a.matricula " +
                "LEFT JOIN ProfessorAEE p ON r.professorAEE_siape = p.siape";

        System.out.println("DEBUG - SQL: " + sql); // Verifique no console

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            int count = 0;
            while (rs.next()) {
                count++;
                System.out.println("DEBUG - Registro "+count+": " +
                        rs.getInt("id") + " - " + rs.getString("titulo"));
                Relatorio relatorio = mapearRelatorio(rs);
                relatorios.add(relatorio);
            }
            System.out.println("DEBUG - Total de registros encontrados: " + count);
        }
        return relatorios;
    }

    public Relatorio buscarPorId(int id) throws SQLException {
        String sql = "SELECT r.*, a.nome as aluno_nome, a.matricula, p.nome as professor_nome, p.siape " +
                "FROM Relatorio r " +
                "JOIN Aluno a ON r.aluno_matricula = a.matricula " +
                "LEFT JOIN ProfessorAEE p ON r.professorAEE_siape = p.siape " +
                "WHERE r.id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearRelatorio(rs);
                }
            }
        }
        return null;
    }

    private Relatorio mapearRelatorio(ResultSet rs) throws SQLException {
        Relatorio relatorio = new Relatorio();
        relatorio.setId(rs.getInt("id"));
        relatorio.setTitulo(rs.getString("titulo"));
        relatorio.setDataGeracao(rs.getDate("dataGeracao").toLocalDate());
        relatorio.setResumo(rs.getString("resumo"));
        relatorio.setObservacoes(rs.getString("observacoes"));

        // Mapear Aluno
        Aluno aluno = new Aluno();
        aluno.setMatricula(rs.getString("matricula"));
        aluno.setNome(rs.getString("aluno_nome"));
        relatorio.setAluno(aluno);

        // Mapear Professor (opcional)
        String siape = rs.getString("siape");
        if (siape != null) {
            ProfessorAEE professor = new ProfessorAEE();
            professor.setSiape(siape);
            professor.setNome(rs.getString("professor_nome"));
            relatorio.setProfessorAEE(professor);
        }

        return relatorio;
    }
}