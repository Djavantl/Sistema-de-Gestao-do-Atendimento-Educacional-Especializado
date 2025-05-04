package dao;

import entities.Professor;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfessorDAO {
    private Connection connection;

    public ProfessorDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(Professor professor) throws SQLException {
        String sql = "INSERT INTO Professor (siape, nome, especialidade) VALUES (?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, professor.getSiape());
        stmt.setString(2, professor.getNome());
        stmt.setString(3, professor.getEspecialidade());
        stmt.executeUpdate();
    }

    public void atualizar(Professor professor) throws SQLException {
        String sql = "UPDATE Professor SET nome = ?, especialidade = ? WHERE siape = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, professor.getNome());
        stmt.setString(2, professor.getEspecialidade());
        stmt.setString(3, professor.getSiape());
        stmt.executeUpdate();
    }

    public void deletar(String siape) throws SQLException {
        String sql = "DELETE FROM Professor WHERE siape = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, siape);
        stmt.executeUpdate();
    }

    public Professor buscarPorSiape(String siape) throws SQLException {
        String sql = "SELECT * FROM Professor WHERE siape = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setString(1, siape);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            Professor professor = new Professor();
            professor.setSiape(rs.getString("siape"));
            professor.setNome(rs.getString("nome"));
            professor.setEspecialidade(rs.getString("especialidade"));
            return professor;
        }
        return null;
    }

    public List<Professor> listarTodos() throws SQLException {
        List<Professor> lista = new ArrayList<>();
        String sql = "SELECT * FROM Professor";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            Professor professor = new Professor();
            professor.setSiape(rs.getString("siape"));
            professor.setNome(rs.getString("nome"));
            professor.setEspecialidade(rs.getString("especialidade"));
            lista.add(professor);
        }
        return lista;
    }
}
