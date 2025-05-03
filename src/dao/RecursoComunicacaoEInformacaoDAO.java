package dao;

import model.RecursosComunicacaoEInformacao;
import java.sql.*;

public class RecursoComunicacaoEInformacaoDAO {
    private Connection connection;

    public RecursoComunicacaoEInformacaoDAO(Connection connection) {
        this.connection = connection;
    }

    public void inserir(RecursosComunicacaoEInformacao rci) throws SQLException {
        String sql = "INSERT INTO recursoscomunicacaoeinformacao (comunicacao_alternativa, tradutor_interprete, leitor_transcritor, interprete_oralizador, guia_interprete, braille, texto_ampliado, relevo, leitor_tela, fonte_tamanho) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setBoolean(1, rci.isComunicacaoAlternativa());
        stmt.setBoolean(2, rci.isTradutorInterprete());
        stmt.setBoolean(3, rci.isLeitorTranscritor());
        stmt.setBoolean(4, rci.isInterpreteOralizador());
        stmt.setBoolean(5, rci.isGuiaInterprete());
        stmt.setBoolean(6, rci.isMaterialDidaticoBraille());
        stmt.setBoolean(7, rci.isMaterialDidaticoTextoAmpliado());
        stmt.setBoolean(8, rci.isMaterialDidaticoRelevo());
        stmt.setBoolean(9, rci.isLeitorDeTela());
        stmt.setBoolean(10, rci.isFonteTamanhoEspecifico());
        stmt.executeUpdate();
    }

    public RecursosComunicacaoEInformacao buscarPorId(int id) throws SQLException {
        String sql = "SELECT * FROM recursoscomunicacaoeinformacao WHERE id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            RecursosComunicacaoEInformacao rci = new RecursosComunicacaoEInformacao();
            rci.setComunicacaoAlternativa(rs.getBoolean("comunicacao_alternativa"));
            rci.setTradutorInterprete(rs.getBoolean("tradutor_interprete"));
            rci.setLeitorTranscritor(rs.getBoolean("leitor_transcritor"));
            rci.setInterpreteOralizador(rs.getBoolean("interprete_oralizador"));
            rci.setGuiaInterprete(rs.getBoolean("guia_interprete"));
            rci.setMaterialDidaticoBraille(rs.getBoolean("braille"));
            rci.setMaterialDidaticoTextoAmpliado(rs.getBoolean("texto_ampliado"));
            rci.setMaterialDidaticoRelevo(rs.getBoolean("relevo"));
            rci.setLeitorDeTela(rs.getBoolean("leitor_tela"));
            rci.setFonteTamanhoEspecifico(rs.getBoolean("fonte_tamanho"));
            return rci;
        }
        return null;
    }

    public void atualizar(RecursosComunicacaoEInformacao rci) throws SQLException {
        String sql = "UPDATE recursoscomunicacaoeinformacao SET comunicacao_alternativa=?, tradutor_interprete=?, leitor_transcritor=?, interprete_oralizador=?, guia_interprete=?, braille=?, texto_ampliado=?, relevo=?, leitor_tela=?, fonte_tamanho=? WHERE id=?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setBoolean(1, rci.isComunicacaoAlternativa());
        stmt.setBoolean(2, rci.isTradutorInterprete());
        stmt.setBoolean(3, rci.isLeitorTranscritor());
        stmt.setBoolean(4, rci.isInterpreteOralizador());
        stmt.setBoolean(5, rci.isGuiaInterprete());
        stmt.setBoolean(6, rci.isMaterialDidaticoBraille());
        stmt.setBoolean(7, rci.isMaterialDidaticoTextoAmpliado());
        stmt.setBoolean(8, rci.isMaterialDidaticoRelevo());
        stmt.setBoolean(9, rci.isLeitorDeTela());
        stmt.setBoolean(10, rci.isFonteTamanhoEspecifico());
        stmt.executeUpdate();
    }

    public void deletar(int id) throws SQLException {
        String sql = "DELETE FROM recursoscomunicacaoeinformacao WHERE id=?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }
}
