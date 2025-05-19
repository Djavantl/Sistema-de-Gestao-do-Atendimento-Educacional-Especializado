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

        String sql = "INSERT INTO PropostaPedagogica (objetivos, metodologias, recursoP_id, recursoFA_id, recursoCI_id) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, proposta.getObjetivos());
            stmt.setString(2, proposta.getMetodologias());
            setResourceId(stmt, 3, proposta.getRecursoP());
            setResourceId(stmt, 4, proposta.getRecursoFA());
            setResourceId(stmt, 5, proposta.getRecursoCI());

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

    // Método corrigido para lidar com diferentes tipos de recursos
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
}