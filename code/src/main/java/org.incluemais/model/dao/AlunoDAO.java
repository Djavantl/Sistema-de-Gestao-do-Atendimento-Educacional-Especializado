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

    public boolean inserirAluno(Aluno aluno) {
        String sqlPessoa = "INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlAluno = "INSERT INTO Aluno (matricula, pessoa_id, responsavel, telResponsavel, telTrabalho, organizacao_id, curso, turma, plano_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtPessoa = conn.prepareStatement(sqlPessoa, Statement.RETURN_GENERATED_KEYS)) {
                stmtPessoa.setString(1, aluno.getNome());
                stmtPessoa.setDate(2, Date.valueOf(aluno.getDataNascimento()));
                stmtPessoa.setString(3, aluno.getEmail());
                stmtPessoa.setString(4, aluno.getSexo());
                stmtPessoa.setString(5, aluno.getNaturalidade());
                stmtPessoa.setString(6, aluno.getTelefone());

                int affectedRowsPessoa = stmtPessoa.executeUpdate();
                if (affectedRowsPessoa == 0) {
                    conn.rollback();
                    return false;
                }

                try (ResultSet generatedKeys = stmtPessoa.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int pessoaId = generatedKeys.getInt(1);

                        try (PreparedStatement stmtAluno = conn.prepareStatement(sqlAluno)) {
                            stmtAluno.setString(1, aluno.getMatricula());
                            stmtAluno.setInt(2, pessoaId);
                            stmtAluno.setString(3, aluno.getResponsavel());
                            stmtAluno.setString(4, aluno.getTelResponsavel());
                            stmtAluno.setString(5, aluno.getTelTrabalho());
                            stmtAluno.setInt(6, aluno.getOrganizacao() != null ? aluno.getOrganizacao().getId() : 0);
                            stmtAluno.setString(7, aluno.getCurso());
                            stmtAluno.setString(8, aluno.getTurma());
                            stmtAluno.setInt(9, aluno.getPlano() != null ? aluno.getPlano().getId() : 0);

                            int affectedRowsAluno = stmtAluno.executeUpdate();
                            if (affectedRowsAluno == 0) {
                                conn.rollback();
                                return false;
                            }
                        }
                    } else {
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

    public boolean atualizarAluno(Aluno aluno) {
        String sqlPessoa = "UPDATE Pessoa SET nome = ?, dataNascimento = ?, email = ?, sexo = ?, naturalidade = ?, telefone = ? WHERE id = ?";
        String sqlAluno = "UPDATE Aluno SET matricula = ?, responsavel = ?, telResponsavel = ?, telTrabalho = ?, organizacao_id = ?, curso = ?, turma = ?, plano_id = ? WHERE pessoa_id = ?";

        try {
            conn.setAutoCommit(false);

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

                try (PreparedStatement stmtAluno = conn.prepareStatement(sqlAluno)) {
                    stmtAluno.setString(1, aluno.getMatricula());
                    stmtAluno.setString(2, aluno.getResponsavel());
                    stmtAluno.setString(3, aluno.getTelResponsavel());
                    stmtAluno.setString(4, aluno.getTelTrabalho());
                    stmtAluno.setInt(5, aluno.getOrganizacao() != null ? aluno.getOrganizacao().getId() : 0);
                    stmtAluno.setString(6, aluno.getCurso());
                    stmtAluno.setString(7, aluno.getTurma());
                    stmtAluno.setInt(8, aluno.getPlano() != null ? aluno.getPlano().getId() : 0);
                    stmtAluno.setInt(9, aluno.getId());

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

    public boolean excluirAluno(int alunoId) {
        String sqlAluno = "DELETE FROM Aluno WHERE pessoa_id = ?";
        String sqlPessoa = "DELETE FROM Pessoa WHERE id = ?";

        try {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtAluno = conn.prepareStatement(sqlAluno)) {
                stmtAluno.setInt(1, alunoId);

                int affectedRowsAluno = stmtAluno.executeUpdate();
                if (affectedRowsAluno == 0) {
                    conn.rollback();
                    return false;
                }

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

    public Aluno buscarPorMatricula(String matricula) {
        String sqlAluno = "SELECT a.matricula, a.responsavel, a.telResponsavel, a.telTrabalho, a.organizacao_id, a.curso, a.turma, a.plano_id, p.id as pessoa_id, p.nome, p.dataNascimento, p.email, p.sexo, p.naturalidade, p.telefone " +
                "FROM Aluno a " +
                "JOIN Pessoa p ON a.pessoa_id = p.id " +
                "WHERE a.matricula = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sqlAluno)) {
            stmt.setString(1, matricula);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Aluno aluno = new Aluno();
                    aluno.setId(rs.getInt("pessoa_id"));
                    aluno.setMatricula(rs.getString("matricula"));
                    aluno.setResponsavel(rs.getString("responsavel"));
                    aluno.setTelResponsavel(rs.getString("telResponsavel"));
                    aluno.setTelTrabalho(rs.getString("telTrabalho"));
                    aluno.setCurso(rs.getString("curso"));
                    aluno.setTurma(rs.getString("turma"));
                    aluno.setNome(rs.getString("nome"));
                    aluno.setDataNascimento(rs.getDate("dataNascimento").toLocalDate());
                    aluno.setEmail(rs.getString("email"));
                    aluno.setSexo(rs.getString("sexo"));
                    aluno.setNaturalidade(rs.getString("naturalidade"));
                    aluno.setTelefone(rs.getString("telefone"));

                    return aluno;
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

}
