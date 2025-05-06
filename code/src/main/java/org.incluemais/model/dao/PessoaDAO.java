package org.incluemais.model.dao;

import org.incluemais.model.entities.Pessoa;
import java.sql.*;
import java.time.LocalDate;

public class PessoaDAO {

    // INSERT com suporte a transação
    public int insert(Connection conn, Pessoa pessoa) throws SQLException {
        String sql = "INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, pessoa.getNome());
            stmt.setDate(2, Date.valueOf(pessoa.getDataNascimento()));
            stmt.setString(3, pessoa.getEmail());
            stmt.setString(4, pessoa.getSexo());
            stmt.setString(5, pessoa.getNaturalidade());
            stmt.setString(6, pessoa.getTelefone());

            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    pessoa.setId(id); // Atualiza o ID no objeto
                    return id;
                }
            }
        }
        return -1; // Falha ao inserir
    }

    // GET BY ID
    public Pessoa getById(Connection conn, int id) throws SQLException {
        String sql = "SELECT * FROM Pessoa WHERE id = ?";
        Pessoa pessoa = null;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    pessoa = new Pessoa(
                            rs.getString("nome"),
                            rs.getDate("dataNascimento").toLocalDate(),
                            rs.getString("email"),
                            rs.getString("sexo"),
                            rs.getString("naturalidade"),
                            rs.getString("telefone")
                    );
                    pessoa.setId(id);
                }
            }
        }
        return pessoa;
    }

    // UPDATE com transação
    public void update(Connection conn, Pessoa pessoa, int id) throws SQLException {
        String sql = "UPDATE Pessoa SET nome = ?, dataNascimento = ?, email = ?, " +
                "sexo = ?, naturalidade = ?, telefone = ? WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, pessoa.getNome());
            stmt.setDate(2, Date.valueOf(pessoa.getDataNascimento()));
            stmt.setString(3, pessoa.getEmail());
            stmt.setString(4, pessoa.getSexo());
            stmt.setString(5, pessoa.getNaturalidade());
            stmt.setString(6, pessoa.getTelefone());
            stmt.setInt(7, id);

            stmt.executeUpdate();
        }
    }

    // DELETE
    public void delete(Connection conn, int id) throws SQLException {
        String sql = "DELETE FROM Pessoa WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}