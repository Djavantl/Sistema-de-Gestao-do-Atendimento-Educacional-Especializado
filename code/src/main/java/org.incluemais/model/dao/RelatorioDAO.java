package org.incluemais.model.dao;

import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Avaliacao;
import org.incluemais.model.entities.ProfessorAEE;
import org.incluemais.model.entities.Relatorio;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RelatorioDAO {
    private static final Logger logger = Logger.getLogger(RelatorioDAO.class.getName());
    private final Connection connection;
    private AlunoDAO alunoDAO;
    private ProfessorAEEDAO professorAEEDAO;

    public RelatorioDAO(Connection connection) {
        this.connection = connection;
        this.alunoDAO = new AlunoDAO(connection);
        this.professorAEEDAO = new ProfessorAEEDAO(connection);
    }

    public boolean inserir(Relatorio relatorio) throws SQLException {
        String sql = "INSERT INTO Relatorio (titulo, dataGeracao, aluno_matricula, professorAEE_siape, resumo, observacoes) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, relatorio.getTitulo());
            stmt.setDate(2, Date.valueOf(relatorio.getDataGeracao()));
            stmt.setString(3, relatorio.getAluno().getMatricula());

            // Tratar professor nulo
            String siape = relatorio.getProfessorAEE() != null ?
                    relatorio.getProfessorAEE().getSiape() : null;
            stmt.setString(4, siape);

            stmt.setString(5, relatorio.getResumo());
            stmt.setString(6, relatorio.getObservacoes());

            // Log para depuração
            System.out.println("Executando SQL: " + stmt.toString());

            int result = stmt.executeUpdate();
            return result > 0;
        }
    }

    public void atualizar(Relatorio r) throws SQLException {
        String sql = "UPDATE Relatorio SET titulo=?, dataGeracao=?, aluno_matricula=?, " +
                "professorAEE_siape=?, resumo=?, observacoes=? WHERE id=?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, r.getTitulo());
            stmt.setDate(2, Date.valueOf(r.getDataGeracao()));
            stmt.setString(3, r.getAluno().getMatricula());

            // Trata professor opcional
            if (r.getProfessorAEE() != null) {
                stmt.setString(4, r.getProfessorAEE().getSiape());
            } else {
                stmt.setNull(4, Types.VARCHAR);
            }

            stmt.setString(5, r.getResumo());
            stmt.setString(6, r.getObservacoes());
            stmt.setInt(7, r.getId());

            stmt.executeUpdate();
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM Relatorio WHERE id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    public List<Relatorio> buscarTodos() throws SQLException {
        List<Relatorio> relatorios = new ArrayList<>();
        String sql = "SELECT r.*, p.nome as aluno_nome, a.matricula, " +
                "p2.nome as professor_nome, prof.siape " +  // Adicione professor_nome
                "FROM Relatorio r " +
                "JOIN Aluno a ON r.aluno_matricula = a.matricula " +
                "JOIN Pessoa p ON a.pessoa_id = p.id " +
                "LEFT JOIN ProfessorAEE prof ON r.professorAEE_siape = prof.siape " +
                "LEFT JOIN Pessoa p2 ON prof.pessoa_id = p2.id";  // Junte Pessoa para o professor

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Relatorio relatorio = mapearRelatorio(rs);
                relatorios.add(relatorio);
            }
        }
        return relatorios;
    }

    public Relatorio buscarPorId(int id) throws SQLException {
        System.out.println("Buscando relatório por ID: " + id);

        String sql = "SELECT r.*, p.nome as aluno_nome, a.matricula, " +
                "p2.nome as professor_nome, prof.siape " +
                "FROM Relatorio r " +
                "JOIN Aluno a ON r.aluno_matricula = a.matricula " +
                "JOIN Pessoa p ON a.pessoa_id = p.id " +
                "LEFT JOIN ProfessorAEE prof ON r.professorAEE_siape = prof.siape " +
                "LEFT JOIN Pessoa p2 ON prof.pessoa_id = p2.id " +
                "WHERE r.id = ?"; // Certifique-se que tem o WHERE!

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    System.out.println("Relatório encontrado no banco");
                    return mapearRelatorio(rs);
                }
            }
        }
        System.out.println("Nenhum relatório encontrado para ID: " + id);
        return null;
    }

    // Método para buscar relatórios por matrícula de aluno
    public List<Relatorio> buscarPorAlunoMatricula(String matricula) throws SQLException {
        List<Relatorio> relatorios = new ArrayList<>();
        String sql = "SELECT r.*, p.nome as aluno_nome, a.matricula, " +
                "p2.nome as professor_nome, prof.siape " +
                "FROM Relatorio r " +
                "JOIN Aluno a ON r.aluno_matricula = a.matricula " +
                "JOIN Pessoa p ON a.pessoa_id = p.id " +
                "LEFT JOIN ProfessorAEE prof ON r.professorAEE_siape = prof.siape " +
                "LEFT JOIN Pessoa p2 ON prof.pessoa_id = p2.id " +
                "WHERE r.aluno_matricula = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, matricula);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Relatorio relatorio = mapearRelatorio(rs);
                    relatorios.add(relatorio);
                }
            }
        }
        System.out.println("Relatórios encontrados: " + relatorios.size());
        return relatorios;
    }

    private Relatorio mapearRelatorio(ResultSet rs) throws SQLException {
        Relatorio relatorio = new Relatorio();
        relatorio.setId(rs.getInt("id"));
        relatorio.setTitulo(rs.getString("titulo"));

        // Data (mantenha sua solução de formatação)
        java.sql.Date sqlDate = rs.getDate("dataGeracao");
        relatorio.setDataGeracao(sqlDate != null ? sqlDate.toLocalDate() : null);

        relatorio.setResumo(rs.getString("resumo"));
        relatorio.setObservacoes(rs.getString("observacoes"));

        // Aluno
        Aluno aluno = new Aluno();
        aluno.setMatricula(rs.getString("matricula"));
        aluno.setNome(rs.getString("aluno_nome"));
        relatorio.setAluno(aluno);

        // Professor - CORREÇÃO AQUI
        String siape = rs.getString("siape");
        String professorNome = rs.getString("professor_nome");

        if (siape != null && !siape.isEmpty()) {
            ProfessorAEE professor = new ProfessorAEE();
            professor.setSiape(siape);
            professor.setNome(professorNome != null ? professorNome : "Nome não disponível");
            relatorio.setProfessorAEE(professor);
        }

        return relatorio;
    }
}