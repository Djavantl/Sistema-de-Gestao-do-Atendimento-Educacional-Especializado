package org.incluemais.model.dao;

import org.incluemais.model.entities.PropostaPedagogica;
import org.incluemais.model.entities.RecursosPedagogicos;
import org.incluemais.model.entities.RecursoFisicoArquitetonico;
import org.incluemais.model.entities.RecursosComunicacaoEInformacao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class PropostaPedagogicaDAO {
    private static final Logger logger = Logger.getLogger(PropostaPedagogicaDAO.class.getName());
    private final Connection conn;

    public PropostaPedagogicaDAO(Connection connection) {
        if (connection == null) {
            throw new IllegalArgumentException("Conexão não pode ser nula");
        }
        this.conn = connection;
    }

    public boolean salvarProposta(PropostaPedagogica proposta) {
        String sql = "INSERT INTO proposta_pedagogica (objetivos, metodologias, recurso_p_id, recurso_fa_id, recurso_ci_id) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, proposta.getObjetivos());
            stmt.setString(2, proposta.getMetodologias());
            stmt.setObject(3, proposta.getRecursoP() != null ? proposta.getRecursoP().getId() : null, Types.INTEGER);
            stmt.setObject(4, proposta.getRecursoFA() != null ? proposta.getRecursoFA().getId() : null, Types.INTEGER);
            stmt.setObject(5, proposta.getRecursoCI() != null ? proposta.getRecursoCI().getId() : null, Types.INTEGER);

            int affected = stmt.executeUpdate();
            if (affected == 0) {
                logger.log(Level.WARNING, "Nenhuma linha inserida para proposta pedagógica");
                return false;
            }
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    proposta.setId(generatedKeys.getInt(1));
                }
            }
            return true;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao salvar proposta pedagógica", e);
            return false;
        }
    }

    public boolean atualizarProposta(PropostaPedagogica proposta) {
        String sql = "UPDATE proposta_pedagogica SET objetivos = ?, metodologias = ?, recurso_p_id = ?, recurso_fa_id = ?, recurso_ci_id = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, proposta.getObjetivos());
            stmt.setString(2, proposta.getMetodologias());
            stmt.setObject(3, proposta.getRecursoP() != null ? proposta.getRecursoP().getId() : null, Types.INTEGER);
            stmt.setObject(4, proposta.getRecursoFA() != null ? proposta.getRecursoFA().getId() : null, Types.INTEGER);
            stmt.setObject(5, proposta.getRecursoCI() != null ? proposta.getRecursoCI().getId() : null, Types.INTEGER);
            stmt.setInt(6, proposta.getId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao atualizar proposta pedagógica", e);
            return false;
        }
    }

    public boolean excluirProposta(int id) {
        String sql = "DELETE FROM proposta_pedagogica WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao excluir proposta pedagógica", e);
            return false;
        }
    }

    public boolean editarProposta(int id, String novosObjetivos, String novasMetodologias) {
        String sql = "UPDATE proposta_pedagogica SET objetivos = ?, metodologias = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, novosObjetivos);
            stmt.setString(2, novasMetodologias);
            stmt.setInt(3, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao editar proposta pedagógica", e);
            return false;
        }
    }

    public PropostaPedagogica buscarPorId(int id) {
        String sql = "SELECT * FROM proposta_pedagogica WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? mapearProposta(rs) : null;
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao buscar proposta por ID", e);
            return null;
        }
    }

    public List<PropostaPedagogica> buscarTodos() {
        String sql = "SELECT * FROM proposta_pedagogica";
        List<PropostaPedagogica> propostas = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                propostas.add(mapearProposta(rs));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Erro ao listar propostas pedagógicas", e);
        }
        return propostas;
    }

    private PropostaPedagogica mapearProposta(ResultSet rs) throws SQLException {
        PropostaPedagogica p = new PropostaPedagogica(
                rs.getString("objetivos"),
                rs.getString("metodologias")
        );
        p.setId(rs.getInt("id"));

        int rpId = rs.getInt("recurso_p_id");
        if (!rs.wasNull()) {
            RecursosPedagogicos rp = new RecursosPedagogicos();
            rp.setId(rpId);
            p.setRecursoP(rp);
        }

        int rfaId = rs.getInt("recurso_fa_id");
        if (!rs.wasNull()) {
            RecursoFisicoArquitetonico rfa = new RecursoFisicoArquitetonico();
            rfa.setId(rfaId);
            p.setRecursoFA(rfa);
        }

        int rciId = rs.getInt("recurso_ci_id");
        if (!rs.wasNull()) {
            RecursosComunicacaoEInformacao rci = new RecursosComunicacaoEInformacao();
            rci.setId(rciId);
            p.setRecursoCI(rci);
        }

        return p;
    }

}