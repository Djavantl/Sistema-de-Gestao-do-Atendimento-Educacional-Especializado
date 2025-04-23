package dao;

import java.sql.Date;
import java.util.Scanner;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import conexao.Conexao;
import model.Aluno;
import model.Main;

public class AlunoDAO {
	
	//Métodos
	public void insetStudent (Aluno aluno) throws SQLException{
		
		Connection conn = Conexao.getConexao();
		String sql = "INSERT INTO Aluno (nome, endereço,email, dataNascimento, cpf, numeroTelefone) VALUES (?, ?, ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, aluno.getNome());
		stmt.setString(2, aluno.getEndereco());
		stmt.setString(3, aluno.getEmail());
		stmt.setDate(4, Date.valueOf(aluno.getDataNascimento()));
		stmt.setString(5, aluno.getCpf());
		stmt.setInt(6, aluno.getNumTelefone());
		System.out.println("Aluno cadastrado!\n");
		stmt.close();
		conn.close();
	}
	
	public void update (Aluno aluno) throws SQLException{
		
		Connection conn = Conexao.getConexao();
		String sql = "UPDATE Aluno SET cpf=?, nome=?, endereço=?, dataNascimento=? WHERE id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, aluno.getCpf());
		stmt.setString(2, aluno.getNome());
		stmt.setString(3, aluno.getEndereco());
		stmt.setDate(4, Date.valueOf(aluno.getDataNascimento()));
		
		int rows = stmt.executeUpdate();
		if(rows > 0) {
			System.out.println("Aluno foi atualizado!");
		}else {
			System.out.println("Aluno não encontrado!");
		}
		stmt.close();
		conn.close();
	}
	
	public void deletStudent (int idDelet) throws SQLException{
		
		Connection conn = Conexao.getConexao();
		String sql = "DELETE FROM Aluno WHERE id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, idDelet);
		
		int rows = stmt.executeUpdate();
		if(rows > 0) {
			System.out.println("Aluno deletado com sucesso!\n");
		}else {
			System.out.println("Aluno não econtrado!\n");
		}
		stmt.close();
		conn.close();
	}
}
