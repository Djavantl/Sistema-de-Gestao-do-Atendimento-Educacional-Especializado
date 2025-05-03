package conexao;

import java.sql.DriverManager;

public class Conexao {
	
	private static final String url = "jdbc:mysql://localhost:3306/incluemais";
	private static final String user = "root";
	private static final String password = "mariemarley123";
	
	public static java.sql.Connection getConexao() {
		
		try {
			java.sql.Connection conn = DriverManager.getConnection(url, user, password);
			System.out.println("Conectado!\n");
			return conn;
		}catch(Exception e) {
			System.out.println("A conexão falhou: "+ e.getMessage());
			e.printStackTrace();
			return null;
		}
	}
}
