package org.incluemais.model.dao;

import org.incluemais.model.entities.*;
import java.sql.*;

public class PropostaPedagogicaDAO {
    private final Connection conn;
    private final RecursosPedagogicosDAO recursosPedagogicosDAO;
    private final RecursoFisicoArquitetonicoDAO recursoFisicoDAO;
    private final RecursosComunicacaoEInformacaoDAO recursoComunicacaoDAO;
    private final PlanoAEEDAO planoAEEDAO;

    public PropostaPedagogicaDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
        this.recursosPedagogicosDAO = new RecursosPedagogicosDAO(connection);
        this.recursoFisicoDAO = new RecursoFisicoArquitetonicoDAO(connection);
        this.recursoComunicacaoDAO = new RecursosComunicacaoEInformacaoDAO(connection);
        this.planoAEEDAO = new PlanoAEEDAO(connection);
    }

    // --------------------- CRIAÇÃO ---------------------

    public void insert(PropostaPedagogica proposta) throws SQLException {
        insertRecursos(proposta);

        String sql = "INSERT INTO PropostaPedagogica (objetivos, metodologias, observacoes, recursoP_id, recursoFA_id, recursoCI_id, planoAEE_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, proposta.getObjetivos());
            stmt.setString(2, proposta.getMetodologias());
            stmt.setString(3, proposta.getObservacoes());
            setRecursoId(stmt, 4, proposta.getRecursoP());
            setRecursoId(stmt, 5, proposta.getRecursoFA());
            setRecursoId(stmt, 6, proposta.getRecursoCI());
            stmt.setInt(7, proposta.getPlanoAEE().getId());

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

    private void insertRecursos(PropostaPedagogica proposta) throws SQLException {
        if (proposta.getRecursoP() != null && proposta.getRecursoP().getId() == 0) {
            recursosPedagogicosDAO.insert(proposta.getRecursoP());
        }
        if (proposta.getRecursoFA() != null && proposta.getRecursoFA().getId() == 0) {
            recursoFisicoDAO.insert(proposta.getRecursoFA());
        }
        if (proposta.getRecursoCI() != null && proposta.getRecursoCI().getId() == 0) {
            recursoComunicacaoDAO.insert(proposta.getRecursoCI());
        }
    }

    // --------------------- ATUALIZAÇÃO ---------------------

    public void update(PropostaPedagogica proposta) throws SQLException {
        updateRecursos(proposta);

        String sql = "UPDATE PropostaPedagogica SET objetivos = ?, metodologias = ?, observacoes = ?, " +
                "recursoP_id = ?, recursoFA_id = ?, recursoCI_id = ? " +
                "WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, proposta.getObjetivos());
            stmt.setString(2, proposta.getMetodologias());
            stmt.setString(3, proposta.getObservacoes());
            setRecursoId(stmt, 4, proposta.getRecursoP());
            setRecursoId(stmt, 5, proposta.getRecursoFA());
            setRecursoId(stmt, 6, proposta.getRecursoCI());
            stmt.setInt(7, proposta.getId());

            stmt.executeUpdate();
        }
    }

    private void updateRecursos(PropostaPedagogica proposta) throws SQLException {
        if (proposta.getRecursoP() != null) {
            recursosPedagogicosDAO.update(proposta.getRecursoP());
        }
        if (proposta.getRecursoFA() != null) {
            recursoFisicoDAO.update(proposta.getRecursoFA());
        }
        if (proposta.getRecursoCI() != null) {
            recursoComunicacaoDAO.update(proposta.getRecursoCI());
        }
    }

    // --------------------- LEITURA ---------------------

    public PropostaPedagogica findByPlanoAEE(int planoId) throws SQLException {
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
                    PlanoAEE plano = planoAEEDAO.find(rs.getInt("planoAEE_id"));
                    proposta.setPlanoAEE(plano);

                    int recursoPId = rs.getInt("recursoP_id");
                    int recursoFAId = rs.getInt("recursoFA_id");
                    int recursoCIId = rs.getInt("recursoCI_id");

                    if (recursoPId > 0)
                        proposta.setRecursoP(recursosPedagogicosDAO.find(recursoPId));
                    else
                        proposta.setRecursoP(null);

                    if (recursoFAId > 0)
                        proposta.setRecursoFA(recursoFisicoDAO.find(recursoFAId));
                    else
                        proposta.setRecursoFA(null);

                    if (recursoCIId > 0)
                        proposta.setRecursoCI(recursoComunicacaoDAO.find(recursoCIId));
                    else
                        proposta.setRecursoCI(null);
                }
            }
        }
        return proposta;
    }

    public PropostaPedagogica findbyPropostaId(int id) throws SQLException {
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

                    PlanoAEE plano = planoAEEDAO.find(rs.getInt("planoAEE_id"));
                    proposta.setPlanoAEE(plano);

                    int recursoPId = rs.getInt("recursoP_id");
                    int recursoFAId = rs.getInt("recursoFA_id");
                    int recursoCIId = rs.getInt("recursoCI_id");

                    if (recursoPId > 0) {
                        proposta.setRecursoP(recursosPedagogicosDAO.find(recursoPId));
                    }
                    if (recursoFAId > 0) {
                        proposta.setRecursoFA(recursoFisicoDAO.find(recursoFAId));
                    }
                    if (recursoCIId > 0) {
                        proposta.setRecursoCI(recursoComunicacaoDAO.find(recursoCIId));
                    }
                }
            }
        }
        return proposta;
    }

    // --------------------- EXCLUSÃO ---------------------

    public void deletePropostaERecursos(int propostaId) throws SQLException {
        PropostaPedagogica proposta = findbyPropostaId(propostaId);

        if (proposta == null) {
            throw new SQLException("Proposta não encontrada com ID: " + propostaId);
        }

        if (proposta.getRecursoP() != null) {
            recursosPedagogicosDAO.delete(proposta.getRecursoP().getId());
        }
        if (proposta.getRecursoFA() != null) {
            recursoFisicoDAO.delete(proposta.getRecursoFA().getId());
        }
        if (proposta.getRecursoCI() != null) {
            recursoComunicacaoDAO.delete(proposta.getRecursoCI().getId());
        }

        deleteById(propostaId);
    }

    private void deleteById(int id) throws SQLException {
        String sql = "DELETE FROM PropostaPedagogica WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // --------------------- AUXILIARES ---------------------

    private void setRecursoId(PreparedStatement stmt, int parameterIndex, Object recurso) throws SQLException {
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
}
