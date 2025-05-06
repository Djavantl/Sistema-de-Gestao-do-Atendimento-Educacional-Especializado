CREATE TABLE Pessoa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    dataNascimento DATE NOT NULL,
    email VARCHAR(100) UNIQUE,
    sexo VARCHAR(20),
    naturalidade VARCHAR(100),
    telefone VARCHAR(20)
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

CREATE TABLE OrganizacaoAtendimento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    periodo VARCHAR(100) NOT NULL,
    duracao VARCHAR(100) NOT NULL,
    frequencia VARCHAR(100) NOT NULL,
    composicao TEXT,
    tipo VARCHAR(100) NOT NULL
);


CREATE TABLE AvaliacaoInicial (
    id INT PRIMARY KEY AUTO_INCREMENT,
    area VARCHAR(255) NOT NULL,
    desempenhoVerificado TEXT,
    observacoes TEXT
);

CREATE TABLE AvaliacaoProcessual (
    id INT PRIMARY KEY AUTO_INCREMENT,
    avancosArea TEXT,
    dificuldadesArea TEXT,
    encaminhamentos TEXT
);

CREATE TABLE AvaliacaoFinal (
    id INT PRIMARY KEY AUTO_INCREMENT,
    alcancadoArea TEXT,
    naoAlcancadoArea TEXT,
    relatorioFinal TEXT
);


CREATE TABLE PlanoAEE (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dataInicio DATE NOT NULL,
    avaliacaoInicial_id INT,
    recomendacoes TEXT,
    FOREIGN KEY (avaliacaoInicial_id) REFERENCES AvaliacaoInicial(id)
);

CREATE TABLE Aluno (
    matricula CHAR(13) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    responsavel VARCHAR(100),
    telResponsavel VARCHAR(20),
    telTrabalho VARCHAR(20),
    organizacao_id INT,
    curso VARCHAR(100),
    turma VARCHAR(100),
    plano_id INT,
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id) ON DELETE CASCADE,
    FOREIGN KEY (organizacao_id) REFERENCES OrganizacaoAtendimento(id),
    FOREIGN KEY (plano_id) REFERENCES PlanoAEE(id)
);


ALTER TABLE PlanoAEE
ADD COLUMN aluno_matricula VARCHAR(13),
ADD FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula);

CREATE TABLE Professor (
    siape CHAR(13) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    especialidade VARCHAR(100),
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id) ON DELETE CASCADE
);

CREATE TABLE ProfessorAEE (
    siape CHAR(13) PRIMARY KEY,
    pessoa_id INT NOT NULL,
    especialidade VARCHAR(100),
    FOREIGN KEY (pessoa_id) REFERENCES Pessoa(id) ON DELETE CASCADE
);

-- Tabelas de registros
CREATE TABLE RegistroPresenca (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_matricula CHAR(13) NOT NULL,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    sinteseAtividades TEXT,
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula)
);

CREATE TABLE RegistroAusencia (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_matricula CHAR(13) NOT NULL,
    data DATE NOT NULL,
    motivos TEXT,
    encaminhamento TEXT,
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula)
);


CREATE TABLE SessaoAtendimento (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_matricula CHAR(13) NOT NULL,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    local VARCHAR(100) NOT NULL,
    presenca_id INT,
    ausencia_id INT,
    participantes TEXT,
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula),
    FOREIGN KEY (presenca_id) REFERENCES RegistroPresenca(id),
    FOREIGN KEY (ausencia_id) REFERENCES RegistroAusencia(id)
);

CREATE TABLE Relatorio (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100) NOT NULL,
    dataGeracao DATE NOT NULL,
    aluno_matricula CHAR(13) NOT NULL,
    professorAEE_siape CHAR(13) NOT NULL,
    avaliacaoInicial_id INT,
    avaliacaoProcessual_id INT,
    avaliacaoFinal_id INT,
    resumo TEXT,
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula),
    FOREIGN KEY (professorAEE_siape) REFERENCES ProfessorAEE(siape),
    FOREIGN KEY (avaliacaoInicial_id) REFERENCES AvaliacaoInicial(id),
    FOREIGN KEY (avaliacaoProcessual_id) REFERENCES AvaliacaoProcessual(id),
    FOREIGN KEY (avaliacaoFinal_id) REFERENCES AvaliacaoFinal(id)
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

CREATE TABLE Meta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'Pendente'
);

CREATE TABLE PlanoAEE_Meta (
    plano_id INT,
    meta_id INT,
    PRIMARY KEY (plano_id, meta_id),
    FOREIGN KEY (plano_id) REFERENCES PlanoAEE(id),
    FOREIGN KEY (meta_id) REFERENCES Meta(id)
);

CREATE TABLE Professor_Aluno (
    professor_siape CHAR(13),
    aluno_matricula CHAR(13),
    PRIMARY KEY (professor_siape, aluno_matricula),
    FOREIGN KEY (professor_siape) REFERENCES Professor(siape),
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula)
);

CREATE TABLE Relatorio_Sessao (
    relatorio_id INT,
    sessao_id INT,
    PRIMARY KEY (relatorio_id, sessao_id),
    FOREIGN KEY (relatorio_id) REFERENCES Relatorio(id),
    FOREIGN KEY (sessao_id) REFERENCES SessaoAtendimento(id)
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

CREATE TABLE PlanoAEE_PropostaPedagogica (
    plano_id INT,
    proposta_id INT,
    PRIMARY KEY (plano_id, proposta_id),
    FOREIGN KEY (plano_id) REFERENCES PlanoAEE(id),
    FOREIGN KEY (proposta_id) REFERENCES PropostaPedagogica(id)
);

CREATE TABLE Aluno_Deficiencia (
    aluno_matricula CHAR(13),
    deficiencia_id INT,
    PRIMARY KEY (aluno_matricula, deficiencia_id),
    FOREIGN KEY (aluno_matricula) REFERENCES Aluno(matricula),
    FOREIGN KEY (deficiencia_id) REFERENCES Deficiencia(id)
);