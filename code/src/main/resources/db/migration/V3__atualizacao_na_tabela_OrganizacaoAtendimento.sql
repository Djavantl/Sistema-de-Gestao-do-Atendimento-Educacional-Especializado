ALTER TABLE OrganizacaoAtendimento
  ADD COLUMN aluno_matricula CHAR(16);

ALTER TABLE OrganizacaoAtendimento
  ADD CONSTRAINT fk_organizacao_aluno
  FOREIGN KEY (aluno_matricula)
  REFERENCES Aluno(matricula);