package org.incluemais.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioProfessorDAO {
    private Connection conn;

    public UsuarioProfessorDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean verificarCredenciais(String siape, String senha) throws SQLException {
        String sql = "SELECT * FROM UsuarioProfessor WHERE professor_siape = ? AND senha = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    public boolean criarUsuario(String siape, String senha) throws SQLException {
        String sql = "INSERT INTO UsuarioProfessor (professor_siape, senha) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            stmt.setString(2, senha);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean existeSiape(String siape) throws SQLException {
        String sql = "SELECT 1 FROM Professor WHERE siape = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }
}