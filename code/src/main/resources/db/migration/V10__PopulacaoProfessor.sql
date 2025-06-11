
INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone)
VALUES ('Woquiton', '1985-06-13', 'woquitonprofessor@example.com', 'Masculino', 'Brasileira', '(11) 99999-9999');


SET @pessoa_id = LAST_INSERT_ID();


INSERT INTO Professor (siape, pessoa_id, especialidade)
VALUES ('202506130001', @pessoa_id, 'LPOO');