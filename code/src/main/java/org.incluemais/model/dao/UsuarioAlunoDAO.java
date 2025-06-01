package org.incluemais.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioAlunoDAO {
    private Connection conn;

    public UsuarioAlunoDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean verificarCredenciais(String matricula, String senha) throws SQLException {
        String sql = "SELECT * FROM UsuarioAluno WHERE aluno_matricula = ? AND senha = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    public boolean criarUsuario(String matricula, String senha) throws SQLException {
        String sql = "INSERT INTO UsuarioAluno (aluno_matricula, senha) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            stmt.setString(2, senha);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean existeMatricula(String matricula) throws SQLException {
        String sql = "SELECT 1 FROM Aluno WHERE matricula = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }
}
