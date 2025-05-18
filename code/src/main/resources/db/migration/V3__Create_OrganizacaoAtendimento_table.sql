DROP TABLE IF EXISTS OrganizacaoAtendimento;

CREATE TABLE OrganizacaoAtendimento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aluno_matricula CHAR(16) UNIQUE NOT NULL,
    periodo VARCHAR(100) NOT NULL,
    duracao VARCHAR(100) NOT NULL,
    frequencia VARCHAR(100) NOT NULL,
    composicao TEXT,
    tipo VARCHAR(100) NOT NULL,
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE
);