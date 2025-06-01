package org.incluemais.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioProfessorAEEDAO {
    private Connection conn;

    public UsuarioProfessorAEEDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean verificarCredenciais(String siape, String senha) throws SQLException {
        String sql = "SELECT * FROM UsuarioProfessorAEE WHERE professorAEE_siape = ? AND senha = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            stmt.setString(2, senha);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    public boolean criarUsuario(String siape, String senha) throws SQLException {
        String sql = "INSERT INTO UsuarioProfessorAEE (professorAEE_siape, senha) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            stmt.setString(2, senha);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean existeSiape(String siape) throws SQLException {
        String sql = "SELECT 1 FROM ProfessorAEE WHERE siape = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, siape);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }
}