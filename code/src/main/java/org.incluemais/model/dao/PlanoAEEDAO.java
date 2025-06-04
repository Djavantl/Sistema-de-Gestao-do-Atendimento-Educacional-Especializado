package org.incluemais.model.dao;

import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.PlanoAEE;
import org.incluemais.model.entities.ProfessorAEE;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PlanoAEEDAO {
    private Connection conn;

    public PlanoAEEDAO(Connection conn) {
        this.conn = conn;
    }

    // Método para listar todos os planos com nomes de aluno e professor
    public List<Map<String, Object>> listarTodosComNomes() throws SQLException {
        List<Map<String, Object>> planos = new ArrayList<>();
        String sql = "SELECT p.id, " +
                "a.matricula AS aluno_matricula, " +
                "pessoa_aluno.nome AS nome_aluno, " +
                "prof.siape AS professor_siape, " +
                "pessoa_prof.nome AS nome_professor, " +
                "p.dataInicio " +
                "FROM PlanoAEE p " +
                "INNER JOIN Aluno a ON p.aluno_matricula = a.matricula " +
                "INNER JOIN Pessoa pessoa_aluno ON a.pessoa_id = pessoa_aluno.id " +
                "LEFT JOIN ProfessorAEE prof ON p.professor_siape = prof.siape " +
                "LEFT JOIN Pessoa pessoa_prof ON prof.pessoa_id = pessoa_prof.id";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Map<String, Object> plano = new HashMap<>();
                plano.put("id", rs.getInt("id"));
                plano.put("nomeAluno", rs.getString("nome_aluno"));
                plano.put("nomeProfessor", rs.getString("nome_professor"));
                plano.put("dataInicio", rs.getDate("dataInicio"));
                planos.add(plano);
            }
        }
        return planos;
    }

    // Método para buscar um plano por ID com objetos compostos
    public PlanoAEE buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM PlanoAEE WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    PlanoAEE plano = new PlanoAEE();
                    plano.setId(rs.getInt("id"));
                    plano.setDataInicio(rs.getDate("dataInicio").toLocalDate());
                    plano.setRecomendacoes(rs.getString("recomendacoes"));
                    plano.setObservacoes(rs.getString("observacoes"));

                    // Carregar Aluno
                    AlunoDAO alunoDAO = new AlunoDAO(conn);
                    Aluno aluno = alunoDAO.buscarPorMatricula(rs.getString("aluno_matricula"));
                    plano.setAluno(aluno);

                    // Carregar Professor (pode ser nulo)
                    String siape = rs.getString("professor_siape");
                    if (siape != null) {
                        ProfessorAEEDAO professorDAO = new ProfessorAEEDAO(conn);
                        ProfessorAEE professor = professorDAO.buscarPorSiape(siape);
                        plano.setProfessorAEE(professor);
                    }
                    return plano;
                }
            }
        }
        return null;
    }

    // Método para inserir um novo PlanoAEE e retornar o ID gerado
    public int inserir(PlanoAEE plano) throws SQLException {
        String sql = "INSERT INTO PlanoAEE (professor_siape, aluno_matricula, dataInicio, recomendacoes, observacoes) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            if (plano.getProfessorAEE() != null) {
                stmt.setString(1, plano.getProfessorAEE().getSiape());
            } else {
                stmt.setNull(1, Types.VARCHAR);
            }
            stmt.setString(2, plano.getAluno().getMatricula());
            stmt.setDate(3, Date.valueOf(plano.getDataInicio()));
            stmt.setString(4, plano.getRecomendacoes());
            stmt.setString(5, plano.getObservacoes());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Falha ao inserir o PlanoAEE, nenhuma linha afetada.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);  // Retorna o ID gerado
                } else {
                    throw new SQLException("Falha ao inserir o PlanoAEE, ID não obtido.");
                }
            }
        }
    }

    // Método para atualizar um PlanoAEE existente
    public boolean atualizar(PlanoAEE plano) throws SQLException {
        String sql = "UPDATE PlanoAEE SET professor_siape = ?, dataInicio = ?, recomendacoes = ?, observacoes = ? " +
                "WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            if (plano.getProfessorAEE() != null) {
                stmt.setString(1, plano.getProfessorAEE().getSiape());
            } else {
                stmt.setNull(1, Types.VARCHAR);
            }
            stmt.setDate(2, Date.valueOf(plano.getDataInicio()));
            stmt.setString(3, plano.getRecomendacoes());
            stmt.setString(4, plano.getObservacoes());
            stmt.setInt(5, plano.getId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }


    // Método para excluir plano
    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM PlanoAEE WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public PlanoAEE buscarPorMatriculaAluno(String matricula) throws SQLException {
        String sql = "SELECT * FROM PlanoAEE WHERE aluno_matricula = ? LIMIT 1";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matricula);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    PlanoAEE plano = new PlanoAEE();
                    plano.setId(rs.getInt("id"));
                    plano.setDataInicio(rs.getDate("dataInicio").toLocalDate());
                    plano.setRecomendacoes(rs.getString("recomendacoes"));
                    plano.setObservacoes(rs.getString("observacoes"));

                    // Carregar Aluno
                    AlunoDAO alunoDAO = new AlunoDAO(conn);
                    Aluno aluno = alunoDAO.buscarPorMatricula(matricula);
                    plano.setAluno(aluno);

                    // Carregar Professor
                    String siape = rs.getString("professor_siape");
                    if (siape != null) {
                        ProfessorAEEDAO professorDAO = new ProfessorAEEDAO(conn);
                        ProfessorAEE professor = professorDAO.buscarPorSiape(siape);
                        plano.setProfessorAEE(professor);
                    }

                    return plano;
                }
            }
        }
        return null;
    }

    public PlanoAEE buscarPorAluno(String matriculaAluno) throws SQLException {
        String sql = "SELECT * FROM PlanoAEE WHERE aluno_matricula = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, matriculaAluno);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                PlanoAEE plano = new PlanoAEE();
                plano.setId(rs.getInt("id"));
                plano.setDataInicio(rs.getDate("dataInicio").toLocalDate());
                plano.setRecomendacoes(rs.getString("recomendacoes"));
                plano.setObservacoes(rs.getString("observacoes"));

                // Aluno básico
                Aluno aluno = new Aluno();
                aluno.setMatricula(rs.getString("aluno_matricula"));
                plano.setAluno(aluno);

                // Professor básico (se existir)
                if (rs.getString("professor_siape") != null) {
                    ProfessorAEE professor = new ProfessorAEE();
                    professor.setSiape(rs.getString("professor_siape"));
                    plano.setProfessorAEE(professor);
                }

                return plano;
            }
        }
        return null;
    }

}