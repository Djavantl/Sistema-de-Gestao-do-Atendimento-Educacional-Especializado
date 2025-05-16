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
    /* Estilos específicos para detalhes mantendo consistência */

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background-color: #f9f9ff;
        overflow-x: hidden;
    }

    /* Correção do título */
    #titulo h2 {
        color: rgb(12, 12, 97);
        font-size: 28px;
        margin-left: 350px;
        margin-top: 40px;
    }

    /* Ajuste do cabeçalho */
    .detalhes-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 0 20px; /* Adicionado para espaçamento interno */
    }

    /* Garantir que o título esteja dentro da div titulo */
    #titulo {
        margin-bottom: 20px;
    }

    .conteudo-principal {
        /* Medidas idênticas à página AlunoCriar */
        margin: 80px 0 40px 350px;
        width: 70%;
        padding: 40px;
    }

    .detalhes-header {
        display: flex;
        justify-content: space-between; /* Alinha os elementos nas extremidades */
        align-items: center;
        padding: 0 20px; /* Adiciona espaçamento interno */
    }


    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 250px;
        height: 100%;
        background-color: #4D44B5;
        color: white;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 30px;
        }

        .logo img {
            width: 40px;
            height: 40px;
            object-fit: contain;
        }

        .menu {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 30px;
            margin-top: 40px;
        }

        .menu-btn {
            background-color: transparent;
            color: #ffffff;
            border: none;
            padding: 14px 20px;
            text-align: left;
            font-size: 16px;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .menu-btn:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }

        .menu-btn.ativo {
            background-color: #f9f9ff;
            color: #4D44B5;
        }

        .menu-btn:hover {
            background-color: rgba(255, 255, 255, 0.15);
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

    .botao-novo-aluno {
        background-color: #4D44B5;
        color: #ffffff;
        border: none;
        padding: 10px 22px;
        border-radius: 10px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s;
    }

    .botao-novo-aluno:hover {
        background-color: #372e9c;
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

    .linha-superior {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 30px;
        gap: 15px;
        margin-top: 20px;
    }
    </style>
<body>
    <div class="sidebar">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
                <h2>Inclui+</h2>
            </div>
            <div class="menu">
                <button class="menu-btn ativo" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
                <button class="menu-btn">Professores</button>
                <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes?sucesso=Sessão+criada+com+sucesso'">Sessões</button>
                <button class="menu-btn">Usuários</button>
            </div>
    </div>

    <div id="titulo">

        <h2>Detalhes do Aluno</h2>
    </div>

    <div class="conteudo-principal">
        <div class="detalhes-header">
            <div></div>
            <button class="botao-novo-aluno" onclick="window.location.href='/templates/aee/alunos'">Voltar</button>
        </div>

        <div class="detalhes-content">
            <!-- Informações Pessoais -->
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

            <!-- Informações Acadêmicas -->
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

            <!-- Contatos -->
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
                <button class="botao-novo-aluno">Adicionar Plano AEE</button>
                <button class="botao-novo-aluno" onclick="window.location.href='/templates/aee/organizacao?id=${aluno.id}&matricula=${aluno.matricula}'">Adicionar Organização de Atendimento</button>
            </div>
        </div>
    </div>
</body>
</html>