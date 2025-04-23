package conexao;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexao {
	
	private static final String url = "jdbc:mysql://localhost:3306/aee";
	private static final String user = "root";
	private static final String password = "javinha";
	
	public static Connection getConexao() {
		
		try {
			Connection conn = DriverManager.getConnection(url, user, password);
			System.out.println("Conectado!\n");
			return conn;
		}catch(Exception e) {
			System.out.println("A conexão falhou: "+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
}
