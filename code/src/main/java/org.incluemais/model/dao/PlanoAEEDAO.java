package org.incluemais.model.dao;

import org.incluemais.model.entities.Meta;
import org.incluemais.model.entities.PlanoAEE;
import org.incluemais.model.connection.DBConnection;
import org.incluemais.model.entities.PropostaPedagogica;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PlanoAEEDAO {
    private static final Logger logger = Logger.getLogger(PlanoAEEDAO.class.getName());
    private final Connection conn;
    private final PropostaPedagogicaDAO propostaDAO;

    public PlanoAEEDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
        this.propostaDAO = new PropostaPedagogicaDAO(connection);
    }

    // Método para inserir um plano AEE com transação
    public int inserir(PlanoAEE plano) throws SQLException {
        conn.setAutoCommit(false); // Iniciar transação

        try {
            int planoId = inserirPlano(plano);
            plano.setId(planoId);
            if (plano.getProposta() != null) {
                PropostaPedagogica proposta = plano.getProposta();
                proposta.setPlanoAEEId(planoId);
                propostaDAO.inserir(proposta);
            }

            conn.commit();
            return planoId;
        } catch (SQLException e) {
            conn.rollback();
            throw e;
        } finally {
            conn.setAutoCommit(true);
        }
    }

    private int inserirPlano(PlanoAEE plano) throws SQLException {
        String sql = "INSERT INTO PlanoAEE (professor_siape, aluno_matricula, dataInicio, recomendacoes, observacoes) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, plano.getProfessorSiape());
            stmt.setString(2, plano.getAlunoMatricula());
            stmt.setDate(3, Date.valueOf(plano.getDataInicio()));
            stmt.setString(4, plano.getRecomendacoes());
            stmt.setString(5, plano.getObservacoes());

            int affectedRows = stmt.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Falha ao inserir o plano, nenhuma linha afetada.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Falha ao obter o ID do plano inserido.");
                }
            }
        }
    }

    // Método para atualizar um plano AEE com transação
    public boolean atualizar(PlanoAEE plano) throws SQLException {
        conn.setAutoCommit(false);

        try {
            // Atualizar plano principal
            if (!atualizarPlano(plano)) {
                return false;
            }

            if (plano.getProposta() != null) {
                propostaDAO.atualizar(plano.getProposta());
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            conn.rollback();
            throw e;
        } finally {
            conn.setAutoCommit(true);
        }
    }

    private boolean atualizarPlano(PlanoAEE plano) throws SQLException {
        String sql = "UPDATE PlanoAEE SET professor_siape = ?, aluno_matricula = ?, dataInicio = ?, " +
                "recomendacoes = ?, observacoes = ? WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, plano.getProfessorSiape());
            stmt.setString(2, plano.getAlunoMatricula());
            stmt.setDate(3, Date.valueOf(plano.getDataInicio()));
            stmt.setString(4, plano.getRecomendacoes());
            stmt.setString(5, plano.getObservacoes());
            stmt.setInt(6, plano.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    // Método para excluir um plano AEE (exclui proposta automaticamente por cascade)
    public boolean excluir(int id) throws SQLException {
        boolean autoCommitOriginal = conn.getAutoCommit();
        conn.setAutoCommit(false); // Iniciar transação

        try {
            // Buscar plano para obter a proposta associada
            PlanoAEE plano = buscarPorId(id);
            if (plano == null) {
                return false;
            }

            // Se existir proposta, excluir com todos os recursos
            if (plano.getProposta() != null) {
                propostaDAO.excluirPropostaComRecursos(plano.getProposta().getId());
            }

            // Excluir plano principal
            String sql = "DELETE FROM PlanoAEE WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, id);
                int affectedRows = stmt.executeUpdate();

                if (affectedRows == 0) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            conn.rollback();
            throw e;
        } finally {
            conn.setAutoCommit(autoCommitOriginal);
        }
    }

    // Método para buscar um plano por ID com proposta associada
    public PlanoAEE buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM PlanoAEE WHERE id = ?";
        PlanoAEE plano = null;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    plano = new PlanoAEE();
                    plano.setId(rs.getInt("id"));
                    plano.setProfessorSiape(rs.getString("professor_siape"));
                    plano.setAlunoMatricula(rs.getString("aluno_matricula"));
                    plano.setDataInicio(rs.getDate("dataInicio").toLocalDate());
                    plano.setRecomendacoes(rs.getString("recomendacoes"));
                    plano.setObservacoes(rs.getString("observacoes"));

                    // Carrega proposta associada se existir
                    plano.setProposta(propostaDAO.buscarPorPlanoId(id));
                }
            }
        }
        return plano;
    }

    // Método para associar metas ao plano
    public void associarMetas(int planoId, List<Meta> metas) throws SQLException {
        String sql = "INSERT INTO PlanoAEE_Meta (plano_id, meta_id) VALUES (?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (Meta meta : metas) {
                stmt.setInt(1, planoId);
                stmt.setInt(2, meta.getId());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    // Método para remover todas as metas de um plano
    public void removerTodasMetas(int planoId) throws SQLException {
        String sql = "DELETE FROM PlanoAEE_Meta WHERE plano_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, planoId);
            stmt.executeUpdate();
        }
    }

    // Método para buscar metas associadas a um plano
    public List<Meta> buscarMetasDoPlano(int planoId) throws SQLException {
        String sql = "SELECT m.* FROM Meta m " +
                "JOIN PlanoAEE_Meta pm ON m.id = pm.meta_id " +
                "WHERE pm.plano_id = ?";
        List<Meta> metas = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, planoId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Meta meta = new Meta();
                    meta.setId(rs.getInt("id"));
                    meta.setDescricao(rs.getString("descricao"));
                    meta.setStatus(rs.getString("status"));
                    metas.add(meta);
                }
            }
        }
        return metas;
    }

    // Método para listar todos os planos
    public List<PlanoAEE> listarTodos() throws SQLException {
        String sql = "SELECT * FROM PlanoAEE";
        List<PlanoAEE> planos = new ArrayList<>();

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                PlanoAEE plano = new PlanoAEE();
                plano.setId(rs.getInt("id"));
                plano.setProfessorSiape(rs.getString("professor_siape"));
                plano.setAlunoMatricula(rs.getString("aluno_matricula"));
                plano.setDataInicio(rs.getDate("dataInicio").toLocalDate());
                plano.setRecomendacoes(rs.getString("recomendacoes"));
                plano.setObservacoes(rs.getString("observacoes"));
                planos.add(plano);
            }
        }
        return planos;
    }
}