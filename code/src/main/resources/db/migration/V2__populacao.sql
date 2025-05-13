INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone)
VALUES (
    'João da Silva',
    '2005-03-15',
    'joao.silva@escola.com',
    'Masculino',
    'São Paulo',
    '(11) 98765-4321'
);

INSERT INTO Aluno (
    matricula,
    pessoa_id,
    responsavel,
    telResponsavel,
    telTrabalho,
    curso,
    turma
)
VALUES (
    'MAT20231115001',
    LAST_INSERT_ID(),  -- Pega o ID da última Pessoa inserida
    'Maria da Silva',
    '(11) 91234-5678',
    '(11) 3456-7890',
    'Ensino Médio Regular',
    '1º Ano A'
);