CREATE TABLE IF NOT EXISTS UsuarioAluno (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_matricula CHAR(16) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS UsuarioProfessor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    professor_siape CHAR(16) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    FOREIGN KEY (professor_siape)
        REFERENCES Professor(siape)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS UsuarioProfessorAEE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    professorAEE_siape CHAR(16) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    FOREIGN KEY (professorAEE_siape)
        REFERENCES ProfessorAEE(siape)
        ON DELETE CASCADE
);
