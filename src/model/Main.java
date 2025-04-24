package model;

import java.sql.SQLException;
import java.util.Scanner;
import dao.AlunoDAO;
import java.time.LocalDate;

public class Main {
	
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		AlunoDAO dao = new AlunoDAO();
		
		int opcao;
		
		do {
			System.out.println("- - - - Menu - - - - ");
			System.out.println("1 - Inserir Aluno");
			System.out.println("2 - Atualizar Aluno");
			System.out.println("3 - Remover Aluno");
			System.out.println("4 - Sair\n");
			System.out.println("Digite a opção desejada:");
			opcao = scanner.nextInt();
			scanner.nextLine();
			
			try { 
				switch(opcao) {
					case 1:
						System.out.println("\nInsira o aluno:");
						System.out.println("Nome: ");
						String nome = scanner.nextLine();
						System.out.println("CPF: ");
						String cpf = scanner.nextLine();
						System.out.println("Endereço: ");
						String endereco = scanner.nextLine();
						System.out.println("Data de Nascimento (YYYY--MM--DD): ");
						String dataNasc = scanner.nextLine();
						System.out.println("Email: ");
						String email = scanner.nextLine();
						System.out.println("Telefone: ");
						int telefone = scanner.nextInt();
						scanner.nextLine();
						System.out.println("Deficiencia: ");
						String deficiencia = scanner.nextLine();
						LocalDate dataNascimento = LocalDate.parse(dataNasc);	
						
						Aluno novo = new Aluno(nome, cpf, endereco, dataNascimento, email, telefone, null);
						dao.insetStudent(novo);
						break;
					default:
						System.out.println("Opção Invalida!");
					}
				}catch(SQLException e) {
					System.out.println("\nErro no banco de dados: "+ e.getMessage());
				}
		}while(opcao >= 1 && opcao <= 4);
		
		scanner.close();
	}
}
