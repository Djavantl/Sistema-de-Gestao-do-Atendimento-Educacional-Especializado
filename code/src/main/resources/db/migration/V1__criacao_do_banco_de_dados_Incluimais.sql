CREATE TABLE Pessoa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    dataNascimento DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    sexo VARCHAR(20),
    naturalidade VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE OrganizacaoAtendimento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    periodo VARCHAR(100) NOT NULL,
    duracao VARCHAR(100) NOT NULL,
    frequencia VARCHAR(100) NOT NULL,
    composicao TEXT,
    tipo VARCHAR(100) NOT NULL
);

CREATE TABLE RecursoFisicoArquitetonico (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usoCadeiraDeRodas BOOLEAN,
    auxilioTranscricaoEscrita BOOLEAN,
    mesaAdaptadaCadeiraDeRodas BOOLEAN,
    usoDeMuleta BOOLEAN,
    outrosFisicoArquitetonico BOOLEAN,
    outrosEspecificado VARCHAR(255)
);

CREATE TABLE RecursosComunicacaoEInformacao (
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

CREATE TABLE RecursosPedagogicos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    adaptacaoDidaticaAulasAvaliacoes BOOLEAN,
    materialDidaticoAdaptado BOOLEAN,
    usoTecnologiaAssistiva BOOLEAN,
    tempoEmpregadoAtividadesAvaliacoes BOOLEAN
);

CREATE TABLE Deficiencia (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(255) NOT NULL,
    tipoDeficiencia VARCHAR(100) NOT NULL,
    recursoFisico_id INT,
    recursoComunicacao_id INT,
    recursoPedagogico_id INT,
    FOREIGN KEY (recursoFisico_id) REFERENCES RecursoFisicoArquitetonico(id),
    FOREIGN KEY (recursoComunicacao_id) REFERENCES RecursosComunicacaoEInformacao(id),
    FOREIGN KEY (recursoPedagogico_id) REFERENCES RecursosPedagogicos(id)
);

CREATE TABLE Deficiencia_Adaptacoes (
    deficiencia_id INT,
    adaptacao VARCHAR(255),
    FOREIGN KEY (deficiencia_id) REFERENCES Deficiencia(id)
);

CREATE TABLE Professor (
    siape CHAR(16) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    especialidade VARCHAR(100),
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id) ON DELETE CASCADE
);

CREATE TABLE ProfessorAEE (
    siape CHAR(16) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    especialidade VARCHAR(100),
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id) ON DELETE CASCADE
);

CREATE TABLE Aluno (
    matricula CHAR(16) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    responsavel VARCHAR(100),
    telResponsavel VARCHAR(20),
    telTrabalho VARCHAR(20),
    organizacao_id INT,
    curso VARCHAR(100),
    turma VARCHAR(100),
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id) ON DELETE CASCADE,
    FOREIGN KEY (organizacao_id) REFERENCES OrganizacaoAtendimento(id)
);

CREATE TABLE Aluno_Deficiencia (
    aluno_matricula CHAR(16),
    deficiencia_id INT,
    PRIMARY KEY (aluno_matricula, deficiencia_id),
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula),
    FOREIGN KEY (deficiencia_id) REFERENCES Deficiencia(id)
);

CREATE TABLE Professor_Aluno (
    professor_siape CHAR(16),
    aluno_matricula CHAR(16),
    PRIMARY KEY (professor_siape, aluno_matricula),
    FOREIGN KEY (professor_siape) REFERENCES Professor(siape),
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula)
);

CREATE TABLE Avaliacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    area VARCHAR(255) NOT NULL,
    desempenhoVerificado TEXT,
    observacoes TEXT
);

CREATE TABLE Meta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'Pendente'
);

CREATE TABLE PropostaPedagogica (
    id INT PRIMARY KEY AUTO_INCREMENT,
    area VARCHAR(100) NOT NULL,
    objetivos TEXT NOT NULL,
    metodologias TEXT NOT NULL,
    recursoP_id INT,
    recursoFA_id INT,
    recursoCI_id INT,
    FOREIGN KEY (recursoP_id) REFERENCES RecursosPedagogicos(id),
    FOREIGN KEY (recursoFA_id) REFERENCES RecursoFisicoArquitetonico(id),
    FOREIGN KEY (recursoCI_id) REFERENCES RecursosComunicacaoEInformacao(id)
);

CREATE TABLE PlanoAEE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    professor_siape CHAR(16),
    aluno_matricula CHAR(16),
    dataInicio DATE NOT NULL,
    recomendacoes TEXT,
    observacoes TEXT,
    FOREIGN KEY (professor_siape) REFERENCES ProfessorAEE(siape),
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula)
);

CREATE TABLE PlanoAEE_Meta (
    plano_id INT,
    meta_id INT,
    PRIMARY KEY (plano_id, meta_id),
    FOREIGN KEY (plano_id) REFERENCES PlanoAEE(id),
    FOREIGN KEY (meta_id) REFERENCES Meta(id)
);

CREATE TABLE PlanoAEE_PropostaPedagogica (
    plano_id INT,
    proposta_id INT,
    PRIMARY KEY (plano_id, proposta_id),
    FOREIGN KEY (plano_id) REFERE  NCES PlanoAEE(id),
    FOREIGN KEY (proposta_id) REFERENCES PropostaPedagogica(id)
);

CREATE TABLE Relatorio (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    dataGeracao DATE NOT NULL,
    aluno_matricula CHAR(16) NOT NULL,
    professorAEE_siape CHAR(16) NOT NULL,
    resumo TEXT,
    observacoes TEXT,
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula),
    FOREIGN KEY (professorAEE_siape) REFERENCES ProfessorAEE(siape)
);

CREATE TABLE SessaoAtendimento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_matricula CHAR(16) NOT NULL,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    local VARCHAR(100) NOT NULL,
    presenca BOOLEAN,
    observacoes TEXT,
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula)
);

CREATE TABLE Relatorio_Avaliacao (
    relatorio_id INT,
    avaliacao_id INT,
    PRIMARY KEY (relatorio_id, avaliacao_id),
    FOREIGN KEY (relatorio_id) REFERENCES Relatorio(id),
    FOREIGN KEY (avaliacao_id) REFERENCES Avaliacao(id)
);