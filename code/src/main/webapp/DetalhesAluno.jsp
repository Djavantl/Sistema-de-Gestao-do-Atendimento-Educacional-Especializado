<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Aluno</title>
    <link rel="stylesheet" href="alunos.css">
</head>
<style>
/* Adicionais específicos para detalhes */
.detalhes-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.detalhes-content {
    background-color: #fff;
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 2px 15px rgba(0,0,0,0.1);
}

.info-section {
    margin-bottom: 30px;
}

.info-section h3 {
    color: #4D44B5;
    margin-bottom: 15px;
    border-bottom: 2px solid #4D44B5;
    padding-bottom: 5px;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
}

.info-item {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
}

.info-item label {
    display: block;
    color: #6c757d;
    font-size: 0.9em;
    margin-bottom: 5px;
}

.info-item p {
    margin: 0;
    font-size: 1em;
    color: #2c3e50;
}
</style>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="Group 167.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn">Estudantes</button>
            <button class="menu-btn">Professores</button>
            <button class="menu-btn">Sessões</button>
            <button class="menu-btn">Usuários</button>
        </div>
    </div>

    <div class="conteudo-principal">
        <div class="detalhes-header">
            <h2>Detalhes do Aluno</h2>
            <button class="botao-novo-aluno" onclick="window.location.href='alunos'">Voltar</button>
        </div>

        <div class="detalhes-content">
            <div class="info-section">
                <h3>Informações Pessoais</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Nome Completo</label>
                        <p>${aluno.nome}</p>
                    </div>
                    <div class="info-item">
                        <label>Data de Nascimento</label>
                        <p>${aluno.dataNascimento}</p>
                    </div>
                    <div class="info-item">
                        <label>Sexo</label>
                        <p>${aluno.sexo}</p>
                    </div>
                    <div class="info-item">
                        <label>Naturalidade</label>
                        <p>${aluno.naturalidade}</p>
                    </div>
                    <div class="info-item">
                        <label>Email</label>
                        <p>${aluno.email}</p>
                    </div>
                    <div class="info-item">
                        <label>Telefone</label>
                        <p>${aluno.telefone}</p>
                    </div>
                </div>
            </div>

            <div class="info-section">
                <h3>Informações Acadêmicas</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Matrícula</label>
                        <p>${aluno.matricula}</p>
                    </div>
                    <div class="info-item">
                        <label>Curso</label>
                        <p>${aluno.curso}</p>
                    </div>
                    <div class="info-item">
                        <label>Turma</label>
                        <p>${aluno.turma}</p>
                    </div>
                </div>
            </div>

            <div class="info-section">
                <h3>Contatos</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Responsável</label>
                        <p>${aluno.responsavel}</p>
                    </div>
                    <div class="info-item">
                        <label>Tel. Responsável</label>
                        <p>${aluno.telResponsavel}</p>
                    </div>
                    <div class="info-item">
                        <label>Tel. Trabalho</label>
                        <p>${aluno.telTrabalho}</p>
                    </div>
                </div>
            </div>

            <div class="linha-superior">
                <button class="botao-novo-aluno">Adicionar Plano</button>
                <button class="botao-novo-aluno">Adicionar Organização de Atendimento</button>
            </div>
        </div>
    </div>
</body>
</html>