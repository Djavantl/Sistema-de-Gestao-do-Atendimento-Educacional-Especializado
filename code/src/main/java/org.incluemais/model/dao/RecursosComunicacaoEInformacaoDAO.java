package org.incluemais.model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.incluemais.model.entities.RecursosComunicacaoEInformacao;

public class RecursosComunicacaoEInformacaoDAO {
    private Connection connection;

    public RecursosComunicacaoEInformacaoDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RecursosComunicacaoEInformacao r) throws SQLException {
        String sql = "INSERT INTO RecursosComunicacaoEInformacao (" +
                "comunicacaoAlternativa, tradutorInterprete, leitorTranscritor, " +
                "interpreteOralizador, guiaInterprete, materialDidaticoBraille, " +
                "materialDidaticoTextoAmpliado, materialDidaticoRelevo, leitorDeTela, " +
                "fonteTamanhoEspecifico) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setBoolean(1, r.isComunicacaoAlternativa());
            stmt.setBoolean(2, r.isTradutorInterprete());
            stmt.setBoolean(3, r.isLeitorTranscritor());
            stmt.setBoolean(4, r.isInterpreteOralizador());
            stmt.setBoolean(5, r.isGuiaInterprete());
            stmt.setBoolean(6, r.isMaterialDidaticoBraille());
            stmt.setBoolean(7, r.isMaterialDidaticoTextoAmpliado());
            stmt.setBoolean(8, r.isMaterialDidaticoRelevo());
            stmt.setBoolean(9, r.isLeitorDeTela());
            stmt.setBoolean(10, r.isFonteTamanhoEspecifico());
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    r.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao inserir recurso de comunicação e informação: " + e.getMessage(), e);
        }
    }

    public void atualizar(RecursosComunicacaoEInformacao r) throws SQLException {
        String sql = "UPDATE RecursosComunicacaoEInformacao SET " +
                "comunicacaoAlternativa = ?, tradutorInterprete = ?, leitorTranscritor = ?, " +
                "interpreteOralizador = ?, guiaInterprete = ?, materialDidaticoBraille = ?, " +
                "materialDidaticoTextoAmpliado = ?, materialDidaticoRelevo = ?, leitorDeTela = ?, " +
                "fonteTamanhoEspecifico = ? WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setBoolean(1, r.isComunicacaoAlternativa());
            stmt.setBoolean(2, r.isTradutorInterprete());
            stmt.setBoolean(3, r.isLeitorTranscritor());
            stmt.setBoolean(4, r.isInterpreteOralizador());
            stmt.setBoolean(5, r.isGuiaInterprete());
            stmt.setBoolean(6, r.isMaterialDidaticoBraille());
            stmt.setBoolean(7, r.isMaterialDidaticoTextoAmpliado());
            stmt.setBoolean(8, r.isMaterialDidaticoRelevo());
            stmt.setBoolean(9, r.isLeitorDeTela());
            stmt.setBoolean(10, r.isFonteTamanhoEspecifico());
            stmt.setInt(11, r.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao atualizar recurso de comunicação e informação: " + e.getMessage(), e);
        }
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM RecursosComunicacaoEInformacao WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new SQLException("Erro ao deletar recurso de comunicação e informação: " + e.getMessage(), e);
        }
    }

    public RecursosComunicacaoEInformacao buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM RecursosComunicacaoEInformacao WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return construirRecurso(rs);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao buscar recurso de comunicação e informação por ID: " + e.getMessage(), e);
        }
        return null;
    }

    public List<RecursosComunicacaoEInformacao> listarTodos() throws SQLException {
        List<RecursosComunicacaoEInformacao> lista = new ArrayList<>();
        String sql = "SELECT * FROM RecursosComunicacaoEInformacao";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                lista.add(construirRecurso(rs));
            }
        } catch (SQLException e) {
            throw new SQLException("Erro ao listar recursos de comunicação e informação: " + e.getMessage(), e);
        }
        return lista;
    }

    private RecursosComunicacaoEInformacao construirRecurso(ResultSet rs) throws SQLException {
        RecursosComunicacaoEInformacao r = new RecursosComunicacaoEInformacao();
        r.setId(rs.getInt("id"));
        r.setComunicacaoAlternativa(rs.getBoolean("comunicacaoAlternativa"));
        r.setTradutorInterprete(rs.getBoolean("tradutorInterprete"));
        r.setLeitorTranscritor(rs.getBoolean("leitorTranscritor"));
        r.setInterpreteOralizador(rs.getBoolean("interpreteOralizador"));
        r.setGuiaInterprete(rs.getBoolean("guiaInterprete"));
        r.setMaterialDidaticoBraille(rs.getBoolean("materialDidaticoBraille"));
        r.setMaterialDidaticoTextoAmpliado(rs.getBoolean("materialDidaticoTextoAmpliado"));
        r.setMaterialDidaticoRelevo(rs.getBoolean("materialDidaticoRelevo"));
        r.setLeitorDeTela(rs.getBoolean("leitorDeTela"));
        r.setFonteTamanhoEspecifico(rs.getBoolean("fonteTamanhoEspecifico"));
        return r;
    }
}
