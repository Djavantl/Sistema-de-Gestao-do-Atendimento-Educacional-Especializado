package dao;

import model.Professor;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;

public class ProfessorDAO {
    private Connection connection;

    public ProfessorDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(Professor professor) throws SQLException {
        String sqlPessoa = "INSERT INTO pessoa (nome, data_nascimento, email, sexo, naturalidade, telefone) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement stmtPessoa = connection.prepareStatement(sqlPessoa, Statement.RETURN_GENERATED_KEYS);
        stmtPessoa.setString(1, professor.getNome());
        stmtPessoa.setDate(2, Date.valueOf(professor.getDataNascimento()));
        stmtPessoa.setString(3, professor.getEmail());
        stmtPessoa.setString(4, professor.getSexo());
        stmtPessoa.setString(5, professor.getNaturalidade());
        stmtPessoa.setString(6, professor.getTelefone());
        stmtPessoa.executeUpdate();

        ResultSet rs = stmtPessoa.getGeneratedKeys();
        int pessoaId = 0;
        if (rs.next()) {
            pessoaId = rs.getInt(1);
        }

        String sqlProfessor = "INSERT INTO professor (id_pessoa, siape, especialidade) VALUES (?, ?, ?)";
        PreparedStatement stmtProf = connection.prepareStatement(sqlProfessor);
        stmtProf.setInt(1, pessoaId);
        stmtProf.setString(2, professor.getSiape());
        stmtProf.setString(3, professor.getEspecialidade());
        stmtProf.executeUpdate();
    }

    public Professor buscarPorId(int idPessoa) throws SQLException {
        String sql = """
            SELECT p.*, prof.siape, prof.especialidade
            FROM pessoa p
            JOIN professor prof ON p.id = prof.id_pessoa
            WHERE p.id = ?
        """;
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, idPessoa);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            String nome = rs.getString("nome");
            LocalDate dataNascimento = rs.getDate("data_nascimento").toLocalDate();
            String email = rs.getString("email");
            String sexo = rs.getString("sexo");
            String naturalidade = rs.getString("naturalidade");
            String telefone = rs.getString("telefone");
            String siape = rs.getString("siape");
            String especialidade = rs.getString("especialidade");

            Professor prof = new Professor(nome, dataNascimento, email, sexo, naturalidade, telefone, siape, especialidade);
            return prof;
        }

        return null;
    }

    public void atualizar(Professor professor, int idPessoa) throws SQLException {
        String sqlPessoa = "UPDATE pessoa SET nome=?, data_nascimento=?, email=?, sexo=?, naturalidade=?, telefone=? WHERE id=?";
        PreparedStatement stmtPessoa = connection.prepareStatement(sqlPessoa);
        stmtPessoa.setString(1, professor.getNome());
        stmtPessoa.setDate(2, Date.valueOf(professor.getDataNascimento()));
        stmtPessoa.setString(3, professor.getEmail());
        stmtPessoa.setString(4, professor.getSexo());
        stmtPessoa.setString(5, professor.getNaturalidade());
        stmtPessoa.setString(6, professor.getTelefone());
        stmtPessoa.setInt(7, idPessoa);
        stmtPessoa.executeUpdate();

        String sqlProf = "UPDATE professor SET siape=?, especialidade=? WHERE id_pessoa=?";
        PreparedStatement stmtProf = connection.prepareStatement(sqlProf);
        stmtProf.setString(1, professor.getSiape());
        stmtProf.setString(2, professor.getEspecialidade());
        stmtProf.setInt(3, idPessoa);
        stmtProf.executeUpdate();
    }

    public void deletar(int idPessoa) throws SQLException {
        String sqlProf = "DELETE FROM professor WHERE id_pessoa=?";
        PreparedStatement stmtProf = connection.prepareStatement(sqlProf);
        stmtProf.setInt(1, idPessoa);
        stmtProf.executeUpdate();

        String sqlPessoa = "DELETE FROM pessoa WHERE id=?";
        PreparedStatement stmtPessoa = connection.prepareStatement(sqlPessoa);
        stmtPessoa.setInt(1, idPessoa);
        stmtPessoa.executeUpdate();
    }
}
