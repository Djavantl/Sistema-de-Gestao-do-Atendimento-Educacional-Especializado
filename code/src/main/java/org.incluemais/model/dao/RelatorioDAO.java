package org.incluemais.model.dao;

import org.incluemais.model.entities.Aluno;
import org.incluemais.model.entities.Avaliacao;
import org.incluemais.model.entities.ProfessorAEE;
import org.incluemais.model.entities.Relatorio;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class RelatorioDAO {
    private static final Logger logger = Logger.getLogger(RelatorioDAO.class.getName());
    private final Connection connection;
    private final AlunoDAO alunoDAO;
    private final ProfessorAEEDAO professorAEEDAO;
    private final AvaliacaoDAO avaliacaoDAO; // Novo atributo

    public RelatorioDAO(Connection connection) {
        this.connection = connection;
        this.alunoDAO = new AlunoDAO(connection);
        this.professorAEEDAO = new ProfessorAEEDAO(connection);
        this.avaliacaoDAO = new AvaliacaoDAO(connection); // Instancia AvaliacaoDAO
    }

    public boolean inserir(Relatorio relatorio) throws SQLException {
        String sql = "INSERT INTO Relatorio " +
                "(titulo, dataGeracao, aluno_matricula, professorAEE_siape, resumo, observacoes) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, relatorio.getTitulo());
            stmt.setDate(2, Date.valueOf(relatorio.getDataGeracao()));
            stmt.setString(3, relatorio.getAluno().getMatricula());

            // Tratar professor nulo
            String siape = relatorio.getProfessorAEE() != null ?
                    relatorio.getProfessorAEE().getSiape() : null;
            if (siape != null && !siape.isEmpty()) {
                stmt.setString(4, siape);
            } else {
                stmt.setNull(4, Types.VARCHAR);
            }

            stmt.setString(5, relatorio.getResumo());
            stmt.setString(6, relatorio.getObservacoes());

            // Log para depuração
            logger.info("Executando SQL (inserir relatorio): " + stmt.toString());

            int result = stmt.executeUpdate();
            if (result == 0) {
                return false;
            }

            // Recupera o ID gerado
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    relatorio.setId(rs.getInt(1));
                }
            }

            return true;
        }
    }

    public void atualizar(Relatorio r) throws SQLException {
        String sql = "UPDATE Relatorio SET " +
                "titulo = ?, dataGeracao = ?, aluno_matricula = ?, " +
                "professorAEE_siape = ?, resumo = ?, observacoes = ? " +
                "WHERE id = ?";

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

            logger.info("Executando SQL (atualizar relatorio): " + stmt.toString());
            stmt.executeUpdate();
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM Relatorio WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            logger.info("Executando SQL (deletar relatorio): " + stmt.toString());
            stmt.executeUpdate();
        }
    }

    // buscar todos
    public List<Relatorio> buscar() throws SQLException {
        List<Relatorio> relatorios = new ArrayList<>();
        String sql = "SELECT r.*, p.nome AS aluno_nome, a.matricula, " +
                "p2.nome AS professor_nome, prof.siape " +
                "FROM Relatorio r " +
                "JOIN Aluno a ON r.aluno_matricula = a.matricula " +
                "JOIN Pessoa p ON a.pessoa_id = p.id " +
                "LEFT JOIN ProfessorAEE prof ON r.professorAEE_siape = prof.siape " +
                "LEFT JOIN Pessoa p2 ON prof.pessoa_id = p2.id";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Relatorio relatorio = mapearRelatorio(rs);

                // Carregar lista de avaliações associadas
                List<Avaliacao> avaliacoes = avaliacaoDAO.buscarPorRelatorio(relatorio.getId());
                relatorio.setAvaliacoes(avaliacoes);

                relatorios.add(relatorio);
            }
        }
        logger.info("Total de relatórios buscados: " + relatorios.size());
        return relatorios;
    }

    // buscar por id
    public Relatorio buscar(int id) throws SQLException {
        logger.info("Buscando relatório por ID: " + id);

        String sql = "SELECT r.*, p.nome AS aluno_nome, a.matricula, " +
                "p2.nome AS professor_nome, prof.siape " +
                "FROM Relatorio r " +
                "JOIN Aluno a ON r.aluno_matricula = a.matricula " +
                "JOIN Pessoa p ON a.pessoa_id = p.id " +
                "LEFT JOIN ProfessorAEE prof ON r.professorAEE_siape = prof.siape " +
                "LEFT JOIN Pessoa p2 ON prof.pessoa_id = p2.id " +
                "WHERE r.id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Relatorio relatorio = mapearRelatorio(rs);

                    // Carregar lista de avaliações associadas
                    List<Avaliacao> avaliacoes = avaliacaoDAO.buscarPorRelatorio(id);
                    relatorio.setAvaliacoes(avaliacoes);

                    logger.info("Relatório encontrado: " + relatorio.getTitulo());
                    return relatorio;
                }
            }
        }
        logger.warning("Nenhum relatório encontrado para ID: " + id);
        return null;
    }

    // buscar relatorio por matricula do aluno
    public List<Relatorio> buscar(String matricula) throws SQLException {
        List<Relatorio> relatorios = new ArrayList<>();
        String sql = "SELECT r.*, p.nome AS aluno_nome, a.matricula, " +
                "p2.nome AS professor_nome, prof.siape " +
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

                    // Carregar lista de avaliações associadas
                    List<Avaliacao> avaliacoes = avaliacaoDAO.buscarPorRelatorio(relatorio.getId());
                    relatorio.setAvaliacoes(avaliacoes);

                    relatorios.add(relatorio);
                }
            }
        }
        logger.info("Relatórios encontrados para aluno " + matricula + ": " + relatorios.size());
        return relatorios;
    }

    private Relatorio mapearRelatorio(ResultSet rs) throws SQLException {
        Relatorio relatorio = new Relatorio();

        relatorio.setId(rs.getInt("id"));
        relatorio.setTitulo(rs.getString("titulo"));

        java.sql.Date sqlDate = rs.getDate("dataGeracao");
        if (sqlDate != null) {
            relatorio.setDataGeracao(sqlDate.toLocalDate());
        }

        relatorio.setResumo(rs.getString("resumo"));
        relatorio.setObservacoes(rs.getString("observacoes"));

        // Mapear Aluno
        Aluno aluno = new Aluno();
        aluno.setMatricula(rs.getString("matricula"));
        aluno.setNome(rs.getString("aluno_nome"));
        relatorio.setAluno(aluno);

        // Mapear ProfessorAEE (caso exista)
        String siape = rs.getString("siape");
        String professorNome = rs.getString("professor_nome");
        if (siape != null && !siape.isEmpty()) {
            ProfessorAEE professor = new ProfessorAEE();
            professor.setSiape(siape);
            professor.setNome(professorNome != null ? professorNome : "Nome indisponível");
            relatorio.setProfessorAEE(professor);
        }

        // OBS.: As avaliações serão carregadas pelo método chamar listarPorRelatorio(...)
        return relatorio;
    }
}
