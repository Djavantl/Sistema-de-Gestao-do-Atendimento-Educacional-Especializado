package connection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

    public class DBConnection {
        private static final String URL = "jdbc:mysql://localhost:3306/jaclwemals";
        private static final String USER = "root";
        private static final String PASSWORD = "cambrainha10";

        static {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                System.err.println("Erro ao carregar o driver JDBC: " + e.getMessage());
            }
        }

        public static Connection getConnection() {
            try {
                Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Conexão estabelecida com sucesso!");
                return conn;
            } catch (SQLException e) {
                System.err.println("Falha na conexão: " + e.getMessage());
                e.printStackTrace();
                return null;
            }
        }
    }

