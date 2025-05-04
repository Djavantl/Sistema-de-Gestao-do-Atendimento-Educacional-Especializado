package dao;

import model.Relatorio;
import java.sql.*;

public class RelatorioDAO {
    private Connection connection;

    public RelatorioDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(Relatorio r) throws SQLException {
        String sql = "INSERT INTO Relatorio (titulo, dataGeracao, aluno_matricula, professorAEE_siape, avaliacaoInicial_id, avaliacaoProcessual_id, avaliacaoFinal_id, resumo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, r.getTitulo());
            stmt.setDate(2, Date.valueOf(r.getDataGeracao()));
            stmt.setString(3, r.getAluno().getMatricula());
            stmt.setString(4, r.getProfessorAEE().getSiape());
            stmt.setInt(5, r.getAvaliacaoInicial().getId());
            stmt.setInt(6, r.getAvaliacaoProcessual().getId());
            stmt.setInt(7, r.getAvaliacaoFinal().getId());
            stmt.setString(8, r.getResumo());
            stmt.executeUpdate();
        }
    }

    public void atualizar(Relatorio r) throws SQLException {
        String sql = "UPDATE Relatorio SET titulo = ?, dataGeracao = ?, aluno_matricula = ?, professorAEE_siape = ?, avaliacaoInicial_id = ?, avaliacaoProcessual_id = ?, avaliacaoFinal_id = ?, resumo = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, r.getTitulo());
            stmt.setDate(2, Date.valueOf(r.getDataGeracao()));
            stmt.setString(3, r.getAluno().getMatricula());
            stmt.setString(4, r.getProfessorAEE().getSiape());
            stmt.setInt(5, r.getAvaliacaoInicial().getId());
            stmt.setInt(6, r.getAvaliacaoProcessual().getId());
            stmt.setInt(7, r.getAvaliacaoFinal().getId());
            stmt.setString(8, r.getResumo());
            stmt.setInt(9, r.getId());
            stmt.executeUpdate();
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM Relatorio WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
