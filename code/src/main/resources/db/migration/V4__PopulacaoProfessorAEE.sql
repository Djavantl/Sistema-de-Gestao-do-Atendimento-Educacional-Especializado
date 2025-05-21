INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone)
VALUES (
    'Carlos Eduardo Almeida',
    '1978-11-22',
    'carlos.almeida@escola.edu.br',
    'Masculino',
    'Rio de Janeiro/RJ',
    '(21) 99876-5432'
);

INSERT INTO ProfessorAEE (siape, pessoa_id, especialidade)
VALUES (
    'RJ987654321098',
    LAST_INSERT_ID(),
    'Transtorno do Espectro Autista (TEA)'
);