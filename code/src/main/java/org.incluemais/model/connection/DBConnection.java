package org.incluemais.model.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DB_URL = System.getenv("DB_URL") != null ?
            System.getenv("DB_URL") :
            "jdbc:mysql://localhost:3306/incluemais?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    private static final String DB_USER = System.getenv("DB_USER") != null ?
            System.getenv("DB_USER") :
            "root";

    private static final String DB_PASSWORD = System.getenv("DB_PASSWORD") != null ?
            System.getenv("DB_PASSWORD") :
            "cambrainha10";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver não encontrado", e);
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão: " + e.getMessage());
            }
        }
    }
}