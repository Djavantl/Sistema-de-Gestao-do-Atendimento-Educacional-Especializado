START TRANSACTION;

-- 1. Pessoas (Alunos, Professores e Professor AEE)
INSERT INTO Pessoa (nome, dataNascimento, email, sexo, naturalidade, telefone) VALUES
-- Alunos (4)
('Ana Costa', '2001-05-12', 'ana.costa@ads.edu.br', 'Feminino', 'São Paulo/SP', '(11) 91234-5678'),
('Bruno Oliveira', '2000-08-23', 'bruno.oliveira@ads.edu.br', 'Masculino', 'Rio de Janeiro/RJ', '(21) 92345-6789'),
('Carla Mendes', '2002-02-17', 'carla.mendes@ads.edu.br', 'Feminino', 'Belo Horizonte/MG', '(31) 93456-7890'),
('Daniel Santos', '1999-11-05', 'daniel.santos@ads.edu.br', 'Masculino', 'Porto Alegre/RS', '(51) 94567-8901'),

-- Professores Regulares (4)
('Fernanda Alves', '1980-04-30', 'fernanda.alves@ads.edu.br', 'Feminino', 'Curitiba/PR', '(41) 95678-9012'),
('Gustavo Lima', '1975-09-15', 'gustavo.lima@ads.edu.br', 'Masculino', 'Recife/PE', '(81) 96789-0123'),
('Helena Martins', '1988-07-22', 'helena.martins@ads.edu.br', 'Feminino', 'Salvador/BA', '(71) 97890-1234'),
('Igor Rocha', '1979-12-10', 'igor.rocha@ads.edu.br', 'Masculino', 'Brasília/DF', '(61) 98901-2345'),

-- Professor AEE (1)
('Juliana Pereira', '1983-03-18', 'juliana.pereira@ads.edu.br', 'Feminino', 'Florianópolis/SC', '(48) 99012-3456');

-- 2. Alunos (ADS)
INSERT INTO Aluno (matricula, pessoa_id, responsavel, telResponsavel, telTrabalho, curso, turma) VALUES
('ADS20230001', 1, 'Mariana Costa', '(11) 8765-4321', '(11) 3123-4567', 'Análise e Desenvolvimento de Sistemas', 'ADS3A'),
('ADS20230002', 2, 'Roberto Oliveira', '(21) 7654-3210', NULL, 'Análise e Desenvolvimento de Sistemas', 'ADS3B'),
('ADS20230003', 3, 'Patrícia Mendes', '(31) 6543-2109', '(31) 2987-6543', 'Análise e Desenvolvimento de Sistemas', 'ADS2A'),
('ADS20230004', 4, 'Carlos Santos', '(51) 5432-1098', '(51) 3876-5432', 'Análise e Desenvolvimento de Sistemas', 'ADS4B');

-- 3. Professores Regulares
INSERT INTO Professor (siape, pessoa_id, especialidade) VALUES
('SP987654321', 5, 'Banco de Dados'),
('PE876543210', 6, 'Programação Web'),
('BA765432109', 7, 'Redes de Computadores'),
('DF654321098', 8, 'Engenharia de Software');

-- 4. Professor AEE
INSERT INTO ProfessorAEE (siape, pessoa_id, especialidade) VALUES
('SC543210987', 9, 'Tecnologia Assistiva');

-- 5. Organização de Atendimento
INSERT INTO OrganizacaoAtendimento (aluno_matricula, periodo, duracao, frequencia, composicao, tipo) VALUES
('ADS20230001', 'Matutino', '2 horas', 'Semanal', 'Individual', 'Apoio Especializado'),
('ADS20230002', 'Vespertino', '1.5 horas', 'Quinzenal', 'Em pequenos grupos', 'Reforço'),
('ADS20230003', 'Noturno', '2 horas', 'Semanal', 'Individual', 'Desenvolvimento'),
('ADS20230004', 'Matutino', '1 hora', 'Semanal', 'Individual', 'Acompanhamento');

-- 6. Deficiências (CORRIGIDO: com matrícula do aluno)
INSERT INTO Deficiencia (nome, descricao, grau_severidade, cid, aluno_matricula) VALUES
('Dislexia', 'Dificuldade na leitura e escrita', 'Moderado', 'F81.0', 'ADS20230001'),
('TDAH', 'Transtorno de Déficit de Atenção', 'Leve', 'F90.0', 'ADS20230002'),
('Baixa Visão', 'Comprometimento visual parcial', 'Severo', 'H54.8', 'ADS20230003'),
('Autismo', 'Transtorno do espectro autista', 'Leve', 'F84.0', 'ADS20230004');

-- 7. Relação Aluno-Deficiência (CORRIGIDO: usando IDs reais)
SET @dislexia_id = (SELECT id FROM Deficiencia WHERE aluno_matricula = 'ADS20230001');
SET @tdah_id = (SELECT id FROM Deficiencia WHERE aluno_matricula = 'ADS20230002');
SET @baixa_visao_id = (SELECT id FROM Deficiencia WHERE aluno_matricula = 'ADS20230003');
SET @autismo_id = (SELECT id FROM Deficiencia WHERE aluno_matricula = 'ADS20230004');

INSERT INTO Aluno_Deficiencia (aluno_matricula, deficiencia_id) VALUES
('ADS20230001', @dislexia_id),
('ADS20230002', @tdah_id),
('ADS20230003', @baixa_visao_id),
('ADS20230004', @autismo_id);

-- 8. Recursos
-- Recursos Pedagógicos (inserir individualmente e capturar IDs)
INSERT INTO RecursosPedagogicos (adaptacaoDidaticaAulasAvaliacoes, materialDidaticoAdaptado, usoTecnologiaAssistiva, tempoEmpregadoAtividadesAvaliacoes)
VALUES (1, 1, 1, 1);
SET @recursoP1 = LAST_INSERT_ID();

INSERT INTO RecursosPedagogicos (adaptacaoDidaticaAulasAvaliacoes, materialDidaticoAdaptado, usoTecnologiaAssistiva, tempoEmpregadoAtividadesAvaliacoes)
VALUES (1, 0, 1, 1);
SET @recursoP2 = LAST_INSERT_ID();

INSERT INTO RecursosPedagogicos (adaptacaoDidaticaAulasAvaliacoes, materialDidaticoAdaptado, usoTecnologiaAssistiva, tempoEmpregadoAtividadesAvaliacoes)
VALUES (1, 1, 1, 1);
SET @recursoP3 = LAST_INSERT_ID();

INSERT INTO RecursosPedagogicos (adaptacaoDidaticaAulasAvaliacoes, materialDidaticoAdaptado, usoTecnologiaAssistiva, tempoEmpregadoAtividadesAvaliacoes)
VALUES (1, 0, 0, 1);
SET @recursoP4 = LAST_INSERT_ID();

-- Recursos Físicos/Arquitetônicos
INSERT INTO RecursoFisicoArquitetonico (usoCadeiraDeRodas, auxilioTranscricaoEscrita, mesaAdaptadaCadeiraDeRodas, usoDeMuleta, outrosFisicoArquitetonico, outrosEspecificado)
VALUES (0, 1, 0, 0, 0, NULL);
SET @recursoFA1 = LAST_INSERT_ID();

INSERT INTO RecursoFisicoArquitetonico (usoCadeiraDeRodas, auxilioTranscricaoEscrita, mesaAdaptadaCadeiraDeRodas, usoDeMuleta, outrosFisicoArquitetonico, outrosEspecificado)
VALUES (0, 0, 0, 0, 1, 'Suporte para tablet');
SET @recursoFA2 = LAST_INSERT_ID();

INSERT INTO RecursoFisicoArquitetonico (usoCadeiraDeRodas, auxilioTranscricaoEscrita, mesaAdaptadaCadeiraDeRodas, usoDeMuleta, outrosFisicoArquitetonico, outrosEspecificado)
VALUES (1, 1, 1, 0, 0, NULL);
SET @recursoFA3 = LAST_INSERT_ID();

INSERT INTO RecursoFisicoArquitetonico (usoCadeiraDeRodas, auxilioTranscricaoEscrita, mesaAdaptadaCadeiraDeRodas, usoDeMuleta, outrosFisicoArquitetonico, outrosEspecificado)
VALUES (0, 0, 0, 0, 0, NULL);
SET @recursoFA4 = LAST_INSERT_ID();

-- Recursos de Comunicação
INSERT INTO RecursosComunicacaoEInformacao (comunicacaoAlternativa, tradutorInterprete, leitorTranscritor, interpreteOralizador, guiaInterprete, materialDidaticoBraille, materialDidaticoTextoAmpliado, materialDidaticoRelevo, leitorDeTela, fonteTamanhoEspecifico)
VALUES (1, 0, 1, 0, 0, 0, 1, 0, 1, 1);
SET @recursoCI1 = LAST_INSERT_ID();

INSERT INTO RecursosComunicacaoEInformacao (comunicacaoAlternativa, tradutorInterprete, leitorTranscritor, interpreteOralizador, guiaInterprete, materialDidaticoBraille, materialDidaticoTextoAmpliado, materialDidaticoRelevo, leitorDeTela, fonteTamanhoEspecifico)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 1, 1);
SET @recursoCI2 = LAST_INSERT_ID();

INSERT INTO RecursosComunicacaoEInformacao (comunicacaoAlternativa, tradutorInterprete, leitorTranscritor, interpreteOralizador, guiaInterprete, materialDidaticoBraille, materialDidaticoTextoAmpliado, materialDidaticoRelevo, leitorDeTela, fonteTamanhoEspecifico)
VALUES (0, 1, 1, 0, 0, 0, 1, 0, 0, 1);
SET @recursoCI3 = LAST_INSERT_ID();

INSERT INTO RecursosComunicacaoEInformacao (comunicacaoAlternativa, tradutorInterprete, leitorTranscritor, interpreteOralizador, guiaInterprete, materialDidaticoBraille, materialDidaticoTextoAmpliado, materialDidaticoRelevo, leitorDeTela, fonteTamanhoEspecifico)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
SET @recursoCI4 = LAST_INSERT_ID();

-- 9. Planos AEE (mantido igual)
INSERT INTO PlanoAEE (professor_siape, aluno_matricula, dataInicio, recomendacoes, observacoes) VALUES
('SC543210987', 'ADS20230001', '2023-03-01', 'Uso de software leitor de tela', 'Acompanhamento quinzenal'),
('SC543210987', 'ADS20230002', '2023-03-10', 'Tempo adicional para provas', NULL),
('SC543210987', 'ADS20230003', '2023-02-15', 'Material em formato ampliado', 'Necessita adaptação física'),
('SC543210987', 'ADS20230004', '2023-04-05', 'Ambiente com redução de estímulos', 'Monitoramento contínuo');

-- 10. Propostas Pedagógicas (usando IDs capturados)
SET @plano1_id = (SELECT id FROM PlanoAEE WHERE aluno_matricula = 'ADS20230001');
SET @plano2_id = (SELECT id FROM PlanoAEE WHERE aluno_matricula = 'ADS20230002');
SET @plano3_id = (SELECT id FROM PlanoAEE WHERE aluno_matricula = 'ADS20230003');
SET @plano4_id = (SELECT id FROM PlanoAEE WHERE aluno_matricula = 'ADS20230004');

INSERT INTO PropostaPedagogica (objetivos, metodologias, observacoes, recursoP_id, recursoFA_id, recursoCI_id, planoAEE_id) VALUES
('Desenvolver habilidades de leitura técnica', 'Uso de sintetizadores de voz e mapas conceituais', 'Foco em SQL e modelagem', @recursoP1, @recursoFA1, @recursoCI1, @plano1_id),
('Otimizar organização de tarefas', 'Agendas estruturadas e lembretes visuais', 'Priorizar algoritmos e lógica', @recursoP2, @recursoFA2, @recursoCI2, @plano2_id),
('Facilitar acesso ao conteúdo visual', 'Materiais táteis e descrição auditiva', 'Ênfase em diagramas de rede', @recursoP3, @recursoFA3, @recursoCI3, @plano3_id),
('Estimular interação social', 'Programação em pares e projetos colaborativos', 'Abordagem prática com Python', @recursoP4, @recursoFA4, @recursoCI4, @plano4_id);

-- 11. Metas
INSERT INTO Meta (descricao, status, plano_id) VALUES
('Completar exercícios de banco de dados com 80% de acurácia', 'Em Andamento', @plano1_id),
('Entregar 90% das atividades no prazo', 'Concluída', @plano2_id),
('Desenvolver protótipo acessível de aplicação web', 'Pendente', @plano3_id),
('Participar em 100% das sessões de pair programming', 'Em Andamento', @plano4_id);

-- 12. Avaliações
INSERT INTO Avaliacao (area, desempenhoVerificado, observacoes) VALUES
('Banco de Dados', 'Compreensão de modelos relacionais', 'Dificuldade com normalização'),
('Front-end', 'Implementação de interfaces responsivas', 'Bom domínio de CSS'),
('Segurança', 'Análise de vulnerabilidades', 'Necessita reforço em criptografia'),
('Gestão de Projetos', 'Planejamento ágil com Scrum', 'Excelente liderança');

-- 13. Relatórios
INSERT INTO Relatorio (titulo, dataGeracao, aluno_matricula, professorAEE_siape, resumo, observacoes) VALUES
('Progresso 1º Semestre', '2023-06-15', 'ADS20230001', 'SC543210987', 'Evolução satisfatória em leitura técnica', 'Manter uso de tecnologias assistivas'),
('Acompanhamento TDAH', '2023-05-20', 'ADS20230002', 'SC543210987', 'Melhora na organização de tarefas', 'Introduzir técnicas Pomodoro'),
('Avaliação Recursos Visuais', '2023-07-01', 'ADS20230003', 'SC543210987', 'Adaptações eficientes para diagramas', 'Implementar descrição auditiva'),
('Comportamento Social', '2023-06-10', 'ADS20230004', 'SC543210987', 'Bom engajamento em trabalhos em grupo', 'Incentivar mentorias');

-- 14. Sessões de Atendimento
INSERT INTO SessaoAtendimento (aluno_matricula, data, horario, local, presenca, observacoes) VALUES
('ADS20230001', '2023-06-10', '09:00:00', 'Sala AEE 1', 1, 'Revisão de consultas SQL'),
('ADS20230002', '2023-06-12', '14:00:00', 'Sala AEE 2', 1, 'Organização de cronograma'),
('ADS20230003', '2023-06-15', '18:00:00', 'Sala AEE 3', 0, 'Remarcar para próxima semana'),
('ADS20230004', '2023-06-14', '10:30:00', 'Sala AEE 1', 1, 'Preparação para apresentação');

-- 15. Relação Professor-Aluno
INSERT INTO Professor_Aluno (professor_siape, aluno_matricula) VALUES
('SP987654321', 'ADS20230001'),
('PE876543210', 'ADS20230002'),
('BA765432109', 'ADS20230003'),
('DF654321098', 'ADS20230004');

-- 16. Relação Relatório-Avaliação
SET @relatorio1_id = (SELECT id FROM Relatorio WHERE aluno_matricula = 'ADS20230001');
SET @relatorio2_id = (SELECT id FROM Relatorio WHERE aluno_matricula = 'ADS20230002');
SET @relatorio3_id = (SELECT id FROM Relatorio WHERE aluno_matricula = 'ADS20230003');
SET @relatorio4_id = (SELECT id FROM Relatorio WHERE aluno_matricula = 'ADS20230004');

SET @avaliacao1_id = (SELECT id FROM Avaliacao WHERE area = 'Banco de Dados');
SET @avaliacao2_id = (SELECT id FROM Avaliacao WHERE area = 'Front-end');
SET @avaliacao3_id = (SELECT id FROM Avaliacao WHERE area = 'Segurança');
SET @avaliacao4_id = (SELECT id FROM Avaliacao WHERE area = 'Gestão de Projetos');

INSERT INTO Relatorio_Avaliacao (relatorio_id, avaliacao_id) VALUES
(@relatorio1_id, @avaliacao1_id),
(@relatorio2_id, @avaliacao2_id),
(@relatorio3_id, @avaliacao3_id),
(@relatorio4_id, @avaliacao4_id);

COMMIT;