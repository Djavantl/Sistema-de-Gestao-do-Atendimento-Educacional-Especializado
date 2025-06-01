package org.incluemais.model.dao;

import org.incluemais.model.entities.*;
import java.sql.*;

public class PropostaPedagogicaDAO {
    private final Connection conn;
    private final RecursosPedagogicosDAO recursosPedagogicosDAO;
    private final RecursoFisicoArquitetonicoDAO recursoFisicoDAO;
    private final RecursosComunicacaoEInformacaoDAO recursoComunicacaoDAO;

    public PropostaPedagogicaDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
        this.recursosPedagogicosDAO = new RecursosPedagogicosDAO(connection);
        this.recursoFisicoDAO = new RecursoFisicoArquitetonicoDAO(connection);
        this.recursoComunicacaoDAO = new RecursosComunicacaoEInformacaoDAO(connection);
    }

    public void inserir(PropostaPedagogica proposta) throws SQLException {
        persistirRecursosAssociados(proposta);

        String sql = "INSERT INTO PropostaPedagogica (objetivos, metodologias, observacoes, recursoP_id, recursoFA_id, recursoCI_id, planoAEE_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, proposta.getObjetivos());
            stmt.setString(2, proposta.getMetodologias());
            stmt.setString(3, proposta.getObservacoes());
            setResourceId(stmt, 4, proposta.getRecursoP());
            setResourceId(stmt, 5, proposta.getRecursoFA());
            setResourceId(stmt, 6, proposta.getRecursoCI());
            stmt.setInt(7, proposta.getPlanoAEEId());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Falha na inserção, nenhuma linha afetada.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    proposta.setId(generatedKeys.getInt(1));
                } else {
                    throw new SQLException("Falha na inserção, nenhum ID obtido.");
                }
            }
        }
    }

    public PropostaPedagogica buscarPorPlanoId(int planoId) throws SQLException {
        String sql = "SELECT * FROM PropostaPedagogica WHERE planoAEE_id = ?";
        PropostaPedagogica proposta = null;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, planoId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    proposta = new PropostaPedagogica();
                    proposta.setId(rs.getInt("id"));
                    proposta.setObjetivos(rs.getString("objetivos"));
                    proposta.setMetodologias(rs.getString("metodologias"));
                    proposta.setObservacoes(rs.getString("observacoes"));
                    proposta.setPlanoAEEId(rs.getInt("planoAEE_id"));

                    int recursoPId = rs.getInt("recursoP_id");
                    int recursoFAId = rs.getInt("recursoFA_id");
                    int recursoCIId = rs.getInt("recursoCI_id");

                    if (recursoPId > 0)
                        proposta.setRecursoP(recursosPedagogicosDAO.buscarPorId(recursoPId));
                    else
                        proposta.setRecursoP(null);

                    if (recursoFAId > 0)
                        proposta.setRecursoFA(recursoFisicoDAO.buscarPorId(recursoFAId));
                    else
                        proposta.setRecursoFA(null);

                    if (recursoCIId > 0)
                        proposta.setRecursoCI(recursoComunicacaoDAO.buscarPorId(recursoCIId));
                    else
                        proposta.setRecursoCI(null);
                }
            }
        }
        return proposta;
    }

    // Método para atualizar proposta existente
    public void atualizar(PropostaPedagogica proposta) throws SQLException {
        // Atualizar recursos primeiro
        atualizarRecursos(proposta);

        // Atualizar proposta principal
        String sql = "UPDATE PropostaPedagogica SET objetivos = ?, metodologias = ?, observacoes = ? WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, proposta.getObjetivos());
            stmt.setString(2, proposta.getMetodologias());
            stmt.setString(3, proposta.getObservacoes());
            stmt.setInt(4, proposta.getId());
            stmt.executeUpdate();
        }
    }

    private void atualizarRecursos(PropostaPedagogica proposta) throws SQLException {
        // Atualizar recursos pedagógicos
        if (proposta.getRecursoP() != null) {
            recursosPedagogicosDAO.atualizar(proposta.getRecursoP());
        }

        // Atualizar recursos físicos/arquitetônicos
        if (proposta.getRecursoFA() != null) {
            recursoFisicoDAO.atualizar(proposta.getRecursoFA());
        }

        // Atualizar recursos de comunicação
        if (proposta.getRecursoCI() != null) {
            recursoComunicacaoDAO.atualizar(proposta.getRecursoCI());
        }
    }

    private void persistirRecursosAssociados(PropostaPedagogica proposta) throws SQLException {
        if (proposta.getRecursoP() != null && proposta.getRecursoP().getId() == 0) {
            recursosPedagogicosDAO.inserir(proposta.getRecursoP());
        }
        if (proposta.getRecursoFA() != null && proposta.getRecursoFA().getId() == 0) {
            recursoFisicoDAO.inserir(proposta.getRecursoFA());
        }
        if (proposta.getRecursoCI() != null && proposta.getRecursoCI().getId() == 0) {
            recursoComunicacaoDAO.inserir(proposta.getRecursoCI());
        }
    }

    private void setResourceId(PreparedStatement stmt, int parameterIndex, Object recurso) throws SQLException {
        if (recurso != null) {
            int id = -1;

            if (recurso instanceof RecursosPedagogicos) {
                id = ((RecursosPedagogicos) recurso).getId();
            } else if (recurso instanceof RecursoFisicoArquitetonico) {
                id = ((RecursoFisicoArquitetonico) recurso).getId();
            } else if (recurso instanceof RecursosComunicacaoEInformacao) {
                id = ((RecursosComunicacaoEInformacao) recurso).getId();
            }

            if (id > 0) {
                stmt.setInt(parameterIndex, id);
            } else {
                stmt.setNull(parameterIndex, Types.INTEGER);
            }
        } else {
            stmt.setNull(parameterIndex, Types.INTEGER);
        }
    }

    public void excluirPropostaComRecursos(int propostaId) throws SQLException {
        // Buscar proposta para obter IDs dos recursos
        PropostaPedagogica proposta = buscarPorId(propostaId);

        if (proposta == null) {
            throw new SQLException("Proposta não encontrada com ID: " + propostaId);
        }

        // Excluir recursos associados
        if (proposta.getRecursoP() != null) {
            recursosPedagogicosDAO.excluirP(proposta.getRecursoP().getId());
        }
        if (proposta.getRecursoFA() != null) {
            recursoFisicoDAO.excluirFA(proposta.getRecursoFA().getId());
        }
        if (proposta.getRecursoCI() != null) {
            recursoComunicacaoDAO.excluirCI(proposta.getRecursoCI().getId());
        }

        // Excluir proposta principal
        excluirProposta(propostaId);
    }

    public PropostaPedagogica buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM PropostaPedagogica WHERE id = ?";
        PropostaPedagogica proposta = null;

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    proposta = new PropostaPedagogica();
                    proposta.setId(rs.getInt("id"));
                    proposta.setObjetivos(rs.getString("objetivos"));
                    proposta.setMetodologias(rs.getString("metodologias"));
                    proposta.setObservacoes(rs.getString("observacoes"));
                    proposta.setPlanoAEEId(rs.getInt("planoAEE_id"));

                    int recursoPId = rs.getInt("recursoP_id");
                    int recursoFAId = rs.getInt("recursoFA_id");
                    int recursoCIId = rs.getInt("recursoCI_id");

                    if (recursoPId > 0) {
                        proposta.setRecursoP(recursosPedagogicosDAO.buscarPorId(recursoPId));
                    }
                    if (recursoFAId > 0) {
                        proposta.setRecursoFA(recursoFisicoDAO.buscarPorId(recursoFAId));
                    }
                    if (recursoCIId > 0) {
                        proposta.setRecursoCI(recursoComunicacaoDAO.buscarPorId(recursoCIId));
                    }
                }
            }
        }
        return proposta;
    }

    private void excluirProposta(int id) throws SQLException {
        String sql = "DELETE FROM PropostaPedagogica WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
