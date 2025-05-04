package dao;

import connection.DBConnection;
import entities.ProfessorAEE;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProfessorAEEDAO {
    public void insert(ProfessorAEE professor) throws SQLException {
        PessoaDAO pessoaDAO = new PessoaDAO();

        String sql = "INSERT INTO ProfessorAEE (siape, pessoa_id, especialidade) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            int pessoaId = pessoaDAO.insert(conn, professor);

            stmt.setString(1, professor.getSiape());
            stmt.setInt(2, pessoaId);
            stmt.setString(3, professor.getEspecialidade());

            stmt.executeUpdate();
        }
    }

    public ProfessorAEE getBySiape(String siape) throws SQLException {
        String sql = "SELECT p.*, pa.especialidade FROM Pessoa p " +
                "JOIN ProfessorAEE pa ON p.id = pa.pessoa_id " +
                "WHERE pa.siape = ?";

        ProfessorAEE professor = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, siape);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    professor = new ProfessorAEE(
                            rs.getString("nome"),
                            rs.getDate("dataNascimento").toLocalDate(),
                            rs.getString("email"),
                            rs.getString("sexo"),
                            rs.getString("naturalidade"),
                            rs.getString("telefone"),
                            siape,
                            rs.getString("especialidade")
                    );
                }
            }
        }
        return professor;
    }

    public List<ProfessorAEE> getAll() throws SQLException {
        String sql = "SELECT p.*, pa.siape, pa.especialidade FROM Pessoa p " +
                "JOIN ProfessorAEE pa ON p.id = pa.pessoa_id";

        List<ProfessorAEE> professores = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ProfessorAEE professor = new ProfessorAEE(
                        rs.getString("nome"),
                        rs.getDate("dataNascimento").toLocalDate(),
                        rs.getString("email"),
                        rs.getString("sexo"),
                        rs.getString("naturalidade"),
                        rs.getString("telefone"),
                        rs.getString("siape"),
                        rs.getString("especialidade")
                );
                professores.add(professor);
            }
        }
        return professores;
    }

    public void update(ProfessorAEE professor) throws SQLException {
        String sqlPessoa = "UPDATE Pessoa SET nome = ?, dataNascimento = ?, email = ?, sexo = ?, naturalidade = ?, telefone = ? " +
                "WHERE id = (SELECT pessoa_id FROM ProfessorAEE WHERE siape = ?)";

        String sqlProfessor = "UPDATE ProfessorAEE SET especialidade = ? WHERE siape = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa);
             PreparedStatement stmtProfessor = conn.prepareStatement(sqlProfessor)) {

            // Atualiza Pessoa
            stmtPessoa.setString(1, professor.getNome());
            stmtPessoa.setDate(2, Date.valueOf(professor.getDataNascimento()));
            stmtPessoa.setString(3, professor.getEmail());
            stmtPessoa.setString(4, professor.getSexo());
            stmtPessoa.setString(5, professor.getNaturalidade());
            stmtPessoa.setString(6, professor.getTelefone());
            stmtPessoa.setString(7, professor.getSiape());
            stmtPessoa.executeUpdate();

            // Atualiza ProfessorAEE
            stmtProfessor.setString(1, professor.getEspecialidade());
            stmtProfessor.setString(2, professor.getSiape());
            stmtProfessor.executeUpdate();
        }
    }

    public void delete(String siape) throws SQLException {
        // A exclusão em cascata já trata da Pessoa devido à constraint ON DELETE CASCADE
        String sql = "DELETE FROM ProfessorAEE WHERE siape = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, siape);
            stmt.executeUpdate();
        }
    }
}