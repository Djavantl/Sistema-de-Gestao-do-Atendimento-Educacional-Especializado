package org.incluemais.config;


import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

    @WebListener
    public class DatabaseInitializer implements ServletContextListener {
        private static final Logger logger = Logger.getLogger(DatabaseInitializer.class.getName());
        private Connection connection;

        @Override
        public void contextInitialized(ServletContextEvent sce) {
            try {
                // 1. Registrar driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // 2. Criar conexão
                String url = "jdbc:mysql://db:3306/incluemais?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
                String user = "root";
                String password = "cambrainha10";

                this.connection = DriverManager.getConnection(url, user, password);

                // 3. Validar e armazenar
                if(this.connection.isValid(2)) {
                    sce.getServletContext().setAttribute("conexao", connection);
                    logger.info(" Conexão com banco estabelecida!");
                } else {
                    throw new SQLException(" Conexão inválida");
                }

            } catch (ClassNotFoundException | SQLException e) {
                logger.log(Level.SEVERE, " Falha crítica na conexão", e);
                throw new RuntimeException("Erro de inicialização do banco", e);
            }
        }

        @Override
        public void contextDestroyed(ServletContextEvent sce) {
            try {
                if(this.connection != null && !this.connection.isClosed()) {
                    this.connection.close();
                    logger.info(" Conexão fechada");
                }
            } catch (SQLException e) {
                logger.log(Level.WARNING, "Erro ao fechar conexão", e);
            }
        }
    }

