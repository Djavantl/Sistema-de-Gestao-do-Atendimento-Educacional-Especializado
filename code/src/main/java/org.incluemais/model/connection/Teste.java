package org.incluemais.model.connection;

import java.sql.Connection;
import java.sql.SQLException;
import static org.incluemais.model.connection.DBConnection.getConnection;

public class Teste {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            System.out.println("Tentando conectar ao banco...");
            conn = DBConnection.getConnection();

            if (conn != null && !conn.isClosed()) {
                System.out.println("Conexão estabelecida com sucesso!");
                System.out.println("Banco de dados: " + conn.getMetaData().getDatabaseProductName());
                System.out.println("Versão: " + conn.getMetaData().getDatabaseProductVersion());
            }

        } catch (SQLException e) {
            System.err.println("Falha na conexão:");
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
            System.out.println("Conexão fechada.");
        }
    }
}
