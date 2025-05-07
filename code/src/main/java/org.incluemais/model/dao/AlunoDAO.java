package org.incluemais.model.dao;

import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Pessoa;
import org.incluemais.model.entities.OrganizacaoAtendimento;
import org.incluemais.model.entities.PlanoAEE;

import java.sql.*;
import java.util.List;

public class AlunoDAO {

    private Connection conn;

    public AlunoDAO(Connection conn) {
        this.conn = conn;
    }

    // Método para inserir um novo Aluno
    public boolean inserirAluno(Aluno aluno) {
        String sqlPessoa = "INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlAluno = "INSERT INTO Aluno (matricula, pessoa_id, responsavel, telResponsavel, telTrabalho, organizacao_id, curso, turma, plano_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            // Inicia a transação
            conn.setAutoCommit(false);

            // Inserir dados na tabela Pessoa
            try (PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa, Statement.RETURN_GENERATED_KEYS)) {
                stmtPessoa.setString(1, aluno.getNome());
                stmtPessoa.setDate(2, Date.valueOf(aluno.getDataNascimento()));
                stmtPessoa.setString(3, aluno.getEmail());
                stmtPessoa.setString(4, aluno.getSexo());
                stmtPessoa.setString(5, aluno.getNaturalidade());
                stmtPessoa.setString(6, aluno.getTelefone());

                int affectedRowsPessoa = stmtPessoa.executeUpdate();
                if (affectedRowsPessoa == 0) {
                    conn.rollback(); // Se falhar, faz rollback
                    return false;
                }

                // Recupera o ID gerado para a Pessoa
                try (ResultSet generatedKeys = stmtPessoa.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int pessoaId = generatedKeys.getInt(1); // ID da pessoa inserida

                        // Inserir dados na tabela Aluno
                        try (PreparedStatement stmtAluno = conn.prepareStatement(sqlAluno)) {
                            stmtAluno.setString(1, aluno.getMatricula());
                            stmtAluno.setInt(2, pessoaId);  // Usa o ID da pessoa gerada
                            stmtAluno.setString(3, aluno.getResponsavel());
                            stmtAluno.setString(4, aluno.getTelResponsavel());
                            stmtAluno.setString(5, aluno.getTelTrabalho());
                            stmtAluno.setInt(6, aluno.getOrganizacao() != null ? aluno.getOrganizacao().getId() : 0); // ID da organização, se existir
                            stmtAluno.setString(7, aluno.getCurso());
                            stmtAluno.setString(8, aluno.getTurma());
                            stmtAluno.setInt(9, aluno.getPlano() != null ? aluno.getPlano().getId() : 0); // ID do plano, se existir

                            int affectedRowsAluno = stmtAluno.executeUpdate();
                            if (affectedRowsAluno == 0) {
                                conn.rollback(); // Se falhar, faz rollback
                                return false;
                            }
                        }
                    } else {
                        conn.rollback(); // Se não encontrar o ID gerado
                        return false;
                    }
                }
            }

            // Se tudo ocorrer bem, faz o commit
            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                conn.rollback(); // Se ocorrer erro, faz rollback
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true); // Restaura o commit automático
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }



    // Método para atualizar dados de um Aluno
    public boolean atualizarAluno(Aluno aluno) {
        String sqlPessoa = "UPDATE Pessoa SET nome = ?, dataNascimento = ?, email = ?, sexo = ?, naturalidade = ?, telefone = ? WHERE id = ?";
        String sqlAluno = "UPDATE Aluno SET matricula = ?, responsavel = ?, telResponsavel = ?, telTrabalho = ?, organizacao_id = ?, curso = ?, turma = ?, plano_id = ? WHERE pessoa_id = ?";

        try {
            conn.setAutoCommit(false);

            // Atualizar na tabela Pessoa
            try (PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa)) {
                stmtPessoa.setString(1, aluno.getNome());
                stmtPessoa.setDate(2, Date.valueOf(aluno.getDataNascimento()));
                stmtPessoa.setString(3, aluno.getEmail());
                stmtPessoa.setString(4, aluno.getSexo());
                stmtPessoa.setString(5, aluno.getNaturalidade());
                stmtPessoa.setString(6, aluno.getTelefone());
                stmtPessoa.setInt(7, aluno.getId());  // ID da Pessoa

                int affectedRowsPessoa = stmtPessoa.executeUpdate();
                if (affectedRowsPessoa == 0) {
                    conn.rollback();
                    return false;
                }

                // Atualizar na tabela Aluno
                try (PreparedStatement stmtAluno = conn.prepareStatement(sqlAluno)) {
                    stmtAluno.setString(1, aluno.getMatricula());
                    stmtAluno.setString(2, aluno.getResponsavel());
                    stmtAluno.setString(3, aluno.getTelResponsavel());
                    stmtAluno.setString(4, aluno.getTelTrabalho());
                    stmtAluno.setInt(5, aluno.getOrganizacao() != null ? aluno.getOrganizacao().getId() : 0);
                    stmtAluno.setString(6, aluno.getCurso());
                    stmtAluno.setString(7, aluno.getTurma());
                    stmtAluno.setInt(8, aluno.getPlano() != null ? aluno.getPlano().getId() : 0);
                    stmtAluno.setInt(9, aluno.getId());  // ID da Pessoa para identificar o aluno

                    int affectedRowsAluno = stmtAluno.executeUpdate();
                    if (affectedRowsAluno == 0) {
                        conn.rollback();
                        return false;
                    }
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Método para excluir um Aluno
    public boolean excluirAluno(int alunoId) {
        String sqlAluno = "DELETE FROM Aluno WHERE pessoa_id = ?";
        String sqlPessoa = "DELETE FROM Pessoa WHERE id = ?";

        try {
            conn.setAutoCommit(false);

            // Excluir na tabela Aluno
            try (PreparedStatement stmtAluno = conn.prepareStatement(sqlAluno)) {
                stmtAluno.setInt(1, alunoId);

                int affectedRowsAluno = stmtAluno.executeUpdate();
                if (affectedRowsAluno == 0) {
                    conn.rollback();
                    return false;
                }

                // Excluir na tabela Pessoa
                try (PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa)) {
                    stmtPessoa.setInt(1, alunoId);

                    int affectedRowsPessoa = stmtPessoa.executeUpdate();
                    if (affectedRowsPessoa == 0) {
                        conn.rollback();
                        return false;
                    }
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                conn.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                conn.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
