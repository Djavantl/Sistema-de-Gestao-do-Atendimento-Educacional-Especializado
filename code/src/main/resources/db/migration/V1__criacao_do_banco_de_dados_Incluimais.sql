-- V1__criacao_do_banco_de_dados_Incluimais.sql
START TRANSACTION;

-- 1. Pessoa
CREATE TABLE IF NOT EXISTS Pessoa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    dataNascimento DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    sexo VARCHAR(20),
    naturalidade VARCHAR(100),
    telefone VARCHAR(20)
);

-- 2. Aluno
CREATE TABLE IF NOT EXISTS Aluno (
    matricula CHAR(16) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    responsavel VARCHAR(100),
    telResponsavel VARCHAR(20),
    telTrabalho VARCHAR(20),
    curso VARCHAR(100),
    turma VARCHAR(100),
    FOREIGN KEY (pessoa_id)
        REFERENCES Pessoa(id)
        ON DELETE CASCADE
);

-- 3. OrganizacaoAtendimento
CREATE TABLE IF NOT EXISTS OrganizacaoAtendimento (
    id INT AUTO_INCREMENT,
    aluno_matricula CHAR(16),
    periodo VARCHAR(100) NOT NULL,
    duracao VARCHAR(100) NOT NULL,
    frequencia VARCHAR(100) NOT NULL,
    composicao TEXT,
    tipo VARCHAR(100) NOT NULL,
    PRIMARY KEY (id, aluno_matricula),
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE
);

-- 4. Professor
CREATE TABLE IF NOT EXISTS Professor (
    siape CHAR(16) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    especialidade VARCHAR(100),
    FOREIGN KEY (pessoa_id)
        REFERENCES Pessoa(id)
        ON DELETE CASCADE
);

-- 5. ProfessorAEE
CREATE TABLE IF NOT EXISTS ProfessorAEE (
    siape CHAR(16) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    especialidade VARCHAR(100),
    FOREIGN KEY (pessoa_id)
        REFERENCES Pessoa(id)
        ON DELETE CASCADE
);

-- 6. RecursoFisicoArquitetonico
CREATE TABLE IF NOT EXISTS RecursoFisicoArquitetonico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usoCadeiraDeRodas BOOLEAN,
    auxilioTranscricaoEscrita BOOLEAN,
    mesaAdaptadaCadeiraDeRodas BOOLEAN,
    usoDeMuleta BOOLEAN,
    outrosFisicoArquitetonico BOOLEAN,
    outrosEspecificado VARCHAR(255)
);

-- 7. RecursosComunicacaoEInformacao
CREATE TABLE IF NOT EXISTS RecursosComunicacaoEInformacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    comunicacaoAlternativa BOOLEAN,
    tradutorInterprete BOOLEAN,
    leitorTranscritor BOOLEAN,
    interpreteOralizador BOOLEAN,
    guiaInterprete BOOLEAN,
    materialDidaticoBraille BOOLEAN,
    materialDidaticoTextoAmpliado BOOLEAN,
    materialDidaticoRelevo BOOLEAN,
    leitorDeTela BOOLEAN,
    fonteTamanhoEspecifico BOOLEAN
);

-- 8. RecursosPedagogicos
CREATE TABLE IF NOT EXISTS RecursosPedagogicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    adaptacaoDidaticaAulasAvaliacoes BOOLEAN,
    materialDidaticoAdaptado BOOLEAN,
    usoTecnologiaAssistiva BOOLEAN,
    tempoEmpregadoAtividadesAvaliacoes BOOLEAN
);

-- 9. Deficiencia
CREATE TABLE IF NOT EXISTS Deficiencia (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    grau_severidade VARCHAR(50),
    cid VARCHAR(20),
    aluno_matricula CHAR(16),
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE
);

-- 10. Aluno_Deficiencia
CREATE TABLE IF NOT EXISTS Aluno_Deficiencia (
    aluno_matricula CHAR(16),
    deficiencia_id INT,
    PRIMARY KEY (aluno_matricula, deficiencia_id),
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE,
    FOREIGN KEY (deficiencia_id)
        REFERENCES Deficiencia(id)
        ON DELETE CASCADE
);

-- 11. Professor_Aluno
CREATE TABLE IF NOT EXISTS Professor_Aluno (
    professor_siape CHAR(16),
    aluno_matricula CHAR(16),
    PRIMARY KEY (professor_siape, aluno_matricula),
    FOREIGN KEY (professor_siape)
        REFERENCES Professor(siape)
        ON DELETE CASCADE,
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE
);

-- 12. Avaliacao
CREATE TABLE IF NOT EXISTS Avaliacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    area VARCHAR(255) NOT NULL,
    desempenhoVerificado TEXT,
    observacoes TEXT
);

-- 13. Meta
CREATE TABLE IF NOT EXISTS Meta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'Pendente'
);

-- 14. PropostaPedagogica
CREATE TABLE IF NOT EXISTS PropostaPedagogica (
    id INT PRIMARY KEY AUTO_INCREMENT,
    objetivos TEXT NOT NULL,
    metodologias TEXT NOT NULL,
    recursoP_id INT,
    recursoFA_id INT,
    recursoCI_id INT,
    FOREIGN KEY (recursoP_id)
        REFERENCES RecursosPedagogicos(id)
        ON DELETE SET NULL,
    FOREIGN KEY (recursoFA_id)
        REFERENCES RecursoFisicoArquitetonico(id)
        ON DELETE SET NULL,
    FOREIGN KEY (recursoCI_id)
        REFERENCES RecursosComunicacaoEInformacao(id)
        ON DELETE SET NULL
);

-- 15. PlanoAEE
CREATE TABLE IF NOT EXISTS PlanoAEE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    professor_siape CHAR(16) NULL,          -- agora aceita NULL
    aluno_matricula CHAR(16),
    dataInicio DATE NOT NULL,
    recomendacoes TEXT,
    observacoes TEXT,
    FOREIGN KEY (professor_siape)
        REFERENCES ProfessorAEE(siape)
        ON DELETE SET NULL,
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE
);

-- 16. PlanoAEE_Meta
CREATE TABLE IF NOT EXISTS PlanoAEE_Meta (
    plano_id INT,
    meta_id INT,
    PRIMARY KEY (plano_id, meta_id),
    FOREIGN KEY (plano_id)
        REFERENCES PlanoAEE(id)
        ON DELETE CASCADE,
    FOREIGN KEY (meta_id)
        REFERENCES Meta(id)
        ON DELETE CASCADE
);

-- 17. PlanoAEE_PropostaPedagogica
CREATE TABLE IF NOT EXISTS PlanoAEE_PropostaPedagogica (
    plano_id INT,
    proposta_id INT,
    PRIMARY KEY (plano_id, proposta_id),
    FOREIGN KEY (plano_id)
        REFERENCES PlanoAEE(id)
        ON DELETE CASCADE,
    FOREIGN KEY (proposta_id)
        REFERENCES PropostaPedagogica(id)
        ON DELETE CASCADE
);

-- 18. Relatorio
CREATE TABLE IF NOT EXISTS Relatorio (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    dataGeracao DATE NOT NULL,
    aluno_matricula CHAR(16) NOT NULL,
    professorAEE_siape CHAR(16) NULL,
    resumo TEXT,
    observacoes TEXT,
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE,
    FOREIGN KEY (professorAEE_siape)
        REFERENCES ProfessorAEE(siape)
        ON DELETE SET NULL
);

-- 19. SessaoAtendimento
CREATE TABLE IF NOT EXISTS SessaoAtendimento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_matricula CHAR(16) NOT NULL,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    local VARCHAR(100) NOT NULL,
    presenca BOOLEAN,
    observacoes TEXT,
    FOREIGN KEY (aluno_matricula)
        REFERENCES Aluno(matricula)
        ON DELETE CASCADE
);

-- 20. Relatorio_Avaliacao
CREATE TABLE IF NOT EXISTS Relatorio_Avaliacao (
    relatorio_id INT,
    avaliacao_id INT,
    PRIMARY KEY (relatorio_id, avaliacao_id),
    FOREIGN KEY (relatorio_id)
        REFERENCES Relatorio(id)
        ON DELETE CASCADE,
    FOREIGN KEY (avaliacao_id)
        REFERENCES Avaliacao(id)
        ON DELETE CASCADE
);

COMMIT;
