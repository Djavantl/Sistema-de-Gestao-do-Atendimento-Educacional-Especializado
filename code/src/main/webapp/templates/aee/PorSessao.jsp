<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sessões de Atendimento</title>
    <link rel="stylesheet" href="PorSessao.css">
</head>
    <style>
    @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background-color: #f9f9ff;
        overflow-x: hidden; /* impede rolagem horizontal */
    }

    /* ---------- Sidebar e Navegação ---------- */
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
        z-index: 1000;
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

    /* ---------- Título da Página ---------- */
    #titulo h2 {
        color: rgb(12, 12, 97);
        font-size: 28px;
        margin-left: 350px; /* substitui o left fixo */
        margin-top: 40px;
    }

    /* ---------- Conteúdo Principal ---------- */
    .conteudo-principal {
        background-color: #ffffff;
        border-radius: 20px;
        padding: 40px;
        margin: 80px 0 40px 350px;
        width: 70%;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }

    /* ---------- Linha do Botão ---------- */
    .linha-superior {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 30px;
    }

    /* ---------- Botão Nova Sessão ---------- */
    .botao-nova-sessao {
        background-color: #4D44B5;
        color: #ffffff;
        border: none;
        padding: 10px 22px;
        border-radius: 10px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s;
    }

    .botao-nova-sessao:hover {
        background-color: #372e9c;
    }

    /* ---------- Estilo de Formulários ---------- */
    form label {
        font-weight: 600;
        color: #2c3e50;
        font-size: 14px;
    }

    form select,
    form input[type="text"],
    form input[type="date"],
    form input[type="time"] {
        width: 100%;
        padding: 10px 12px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 8px;
        margin-top: 4px;
        margin-bottom: 16px;
        background-color: #fefefe;
        transition: border-color 0.3s, box-shadow 0.3s;
    }

    form select:focus,
    form input:focus {
        border-color: #4D44B5;
        box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
        outline: none;
    }

    /* ---------- Modal de Conteúdo (Salvar / Cancelar) ---------- */
    .modal-conteudo button[type="submit"] {
        background-color: #4D44B5;
        color: #ffffff;
        border: none;
        padding: 10px 18px;
        border-radius: 8px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-right: 10px;
    }

    .modal-conteudo button[type="submit"]:hover {
        background-color: #372e9c;
    }

    .modal-conteudo button:not([type="submit"]) {
        background-color: #e0e0e0;
        color: #333;
        border: none;
        padding: 10px 18px;
        border-radius: 8px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .modal-conteudo button:not([type="submit"]):hover {
        background-color: #cfcfcf;
    }

    /* ---------- Estilo do Status e Ações da Sessão ---------- */
    .sessao-status {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        position: relative;
        border-radius: 6px;
        padding: 10px 12px;
        width: 100%;
        box-sizing: border-box;
    }

    .botao-dropdown {
        background: none;
        border: none;
        cursor: pointer;
        margin-left: 6px;
        padding: 0;
    }

    .icone-dropdown {
        width: 12px;
        height: 12px;
        transition: transform 0.3s ease;
    }

    /* Gira o ícone ao expandir */
    .botao-dropdown.ativo .icone-dropdown {
        transform: rotate(180deg);
    }

    .botoes-acoes {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-left: auto;
    }

    .botoes-acoes button {
        padding: 4px 10px;
        font-size: 13px;
        border: none;
        border-radius: 4px;
        color: white;
        cursor: pointer;
        width: 70px;
    }

    .botao-editar {
        background-color: #007bff;
    }

    .botao-excluir {
        background-color: #dc3545;
    }

    .botao-editar:hover {
        background-color: #0056b3;
    }

    .botao-excluir:hover {
        background-color: #c82333;
    }

    /* ---------- Overlay de Modal ---------- */
    .overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        backdrop-filter: blur(5px);
        background-color: rgba(0, 0, 0, 0.4);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 999;
    }

    /* ---------- Estilo da Tabela de Sessões ---------- */
    .tabela-sessoes {
        width: 100%;
        border-collapse: separate; /* permite border-spacing */
        border-spacing: 0 8px;     /* espaço vertical entre linhas */
        font-size: 14px;
        border-radius: 8px;
        overflow: hidden;
    }

    .tabela-sessoes th {
        background-color: #ecf0f1;
        color: #2c3e50;
        text-align: left;
        padding: 14px;
        border-bottom: none; /* remover borda inferior */
    }

    .tabela-sessoes td {
        background-color: #ffffff;
        padding: 14px;
        border-bottom: none; /* remover borda inferior */
    }

    /* Filtros na linha de cabeçalho */
    .linha-filtro input,
    .linha-filtro select {
        width: 100%;
        padding: 8px;
        font-size: 13px;
        border: 1px solid #ccc;
        border-radius: 6px;
        background-color: #fefefe;
    }

    /* Botão Filtrar (se houver) */
    .botao-filtrar {
        background-color: #1abc9c;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
    }

    .botao-filtrar:hover {
        background-color: #16a085;
    }

    /* Pequeno destaque para status genéricos */
    .presenca-status {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-weight: 500;
    }

    /* Conteúdo Detalhes (quando expandido) */
    .conteudo-detalhes {
        background-color: #f4f4fc;
        padding: 16px;
        border-radius: 10px;
        font-size: 14px;
        color: #333;
    }

    /* ---------- Modal de Confirmação ---------- */
    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        backdrop-filter: blur(5px);
        background-color: rgba(0, 0, 0, 0.2);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 1000;
    }

    .modal-conteudo {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 16px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        width: 400px;
        text-align: center;
    }

    .modal-conteudo h3 {
        margin-bottom: 20px;
        color: #2c3e50;
    }

    .modal-conteudo button {
        margin-top: 20px;
        background-color: #e74c3c;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        cursor: pointer;
    }

    .modal-conteudo button:hover {
        background-color: #c0392b;
    }

    /* Textarea dentro de Conteúdo Detalhes (forms de observações) */
    .conteudo-detalhes textarea {
        width: 100%;
        min-height: 80px;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        background-color: #fafafa;
        resize: vertical;
        transition: border-color 0.2s ease;
        outline: none;
    }

    .conteudo-detalhes textarea:focus {
        border-color: #007bff;
        background-color: #fff;
    }

    .conteudo-detalhes textarea::placeholder {
        color: transparent; /* Remove o placeholder */
    }

    /* ---------- Seções de Tabela (Próximas / Passadas) ---------- */
    .secao-tabela {
        margin-top: 40px;
        margin-bottom: 50px;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        background-color: #ffffff;
        position: relative;
    }

    .cabecalho-secao {
        background-color: #4D44B5;
        padding: 15px 25px;
    }

    .cabecalho-secao h3 {
        color: white;
        font-size: 20px;
        font-weight: 600;
        margin: 0;
    }

    /* Primeira seção não precisa de margem-top extra */
    .secao-tabela:first-child {
        margin-top: 0;
    }

    /* Mensagem de “lista vazia” na tabela */
    .tabela-sessoes td[colspan] {
        font-size: 16px;
        color: #666;
        padding: 30px !important;
    }

    /* ---------- Contorno nas Linhas Individuais ---------- */
    /* (apenas nos <td> para formar um contorno completo ao redor da linha) */

    /* Próximas Sessões: borda amarela */
    .proximas-sessoes .linha-principal td {
        border-top: 2px solid #FFD700;
        border-bottom: 2px solid #FFD700;
    }

    /* Adiciona a borda esquerda e os cantos arredondados apenas na primeira célula */
    .proximas-sessoes .linha-principal td:first-child {
        border-left: 2px solid #FFD700;
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
    }

    /* Adiciona a borda direita e os cantos arredondados apenas na última célula */
    .proximas-sessoes .linha-principal td:last-child {
        border-right: 2px solid #FFD700;
        border-top-right-radius: 8px;
        border-bottom-right-radius: 8px;
    }

    /* Sessões Passadas: borda laranja */
    .sessoes-passadas .linha-principal td {
        border-top: 2px solid #FFA500;
        border-bottom: 2px solid #FFA500;
    }

    /* Adiciona a borda esquerda e os cantos arredondados apenas na primeira célula */
    .sessoes-passadas .linha-principal td:first-child {
        border-left: 2px solid #FFA500;
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
    }

    /* Adiciona a borda direita e os cantos arredondados apenas na última célula */
    .sessoes-passadas .linha-principal td:last-child {
        border-right: 2px solid #FFA500;
        border-top-right-radius: 8px;
        border-bottom-right-radius: 8px;
    }
    /* ---------- Nova Seção: Sessões por Aluno ---------- */
    .sessoes-por-aluno .linha-principal td {
        border-top: 2px solid #4D44B5;
        border-bottom: 2px solid #4D44B5;
    }

    .sessoes-por-aluno .linha-principal td:first-child {
        border-left: 2px solid #4D44B5;
        border-top-left-radius: 8px;
        border-bottom-left-radius: 8px;
    }

    .sessoes-por-aluno .linha-principal td:last-child {
        border-right: 2px solid #4D44B5;
        border-top-right-radius: 8px;
        border-bottom-right-radius: 8px;
    }

    .selecionar-aluno-container {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 15px 20px;
        background-color: #f4f4fc;
        border-radius: 10px;
        margin-bottom: 20px;
    }

    .selecionar-aluno-container label {
        font-weight: 600;
        color: #2c3e50;
        font-size: 15px;
    }

    .selecionar-aluno-container select {
        flex-grow: 1;
        padding: 8px 12px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 8px;
        background-color: #fefefe;
    }

    .botao-buscar {
        background-color: #4D44B5;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 8px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }

    .botao-buscar:hover {
        background-color: #372e9c;
    }

    </style>

<body>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professores'">Professores</button>
            <button class="menu-btn ativo" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Sessões de Atendimento</h2>
    </div>

    <div class="conteudo-principal">
        <div class="linha-superior">
            <button class="botao-nova-sessao">+ Nova Sessão</button>
        </div>

        <!-- Modal Nova Sessão -->
        <div class="modal-overlay" id="modalNovaSessao">
            <div class="modal-conteudo">
                <h3>Criar Nova Sessão</h3>
                <form id="formNovaSessao" action="${pageContext.request.contextPath}/templates/aee/sessoes?acao=criar" method="POST">
                     <label for="aluno">Nome do Aluno:</label><br>
                        <select name="aluno_matricula" id="aluno" required>
                            <option value="" disabled selected>Selecione um aluno</option>
                            <c:forEach items="${todosAlunos}" var="aluno">
                                <option value="${aluno.matricula}">${aluno.nome}</option>
                            </c:forEach>
                        </select><br><br>

                    <label for="data">Data:</label><br>
                    <input type="date" id="data" name="data" required><br><br>

                    <label for="horario">Horário:</label><br>
                    <input type="time" id="horario" name="horario" required><br><br>

                    <label for="local">Local:</label><br>
                    <input type="text" id="local" name="local" required><br><br>

                    <div class="botoes-modal">
                        <button type="submit">Salvar</button>
                        <button type="button" onclick="fecharModal(modalNovaSessao)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Nova Seção: Sessões por Aluno -->
        <div class="secao-tabela sessoes-por-aluno">
            <div class="cabecalho-secao">
                <h3>Sessões por Aluno</h3>
            </div>

            <form action="${pageContext.request.contextPath}/templates/aee/sessoes" method="GET">
                <div class="selecionar-aluno-container">
                    <label for="alunoSelecionado">Selecione um Aluno:</label>
                    <select id="alunoSelecionado" name="matriculaAluno">
                        <option value="" disabled selected>Selecione um aluno</option>
                        <c:forEach items="${todosAlunos}" var="aluno">
                            <option value="${aluno.matricula}"
                                <c:if test="${param.matriculaAluno == aluno.matricula}">selected</c:if>
                            >
                                ${aluno.nome}
                            </option>
                        </c:forEach>
                    </select>
                    <button type="submit" class="botao-buscar">Buscar</button>
                </div>
            </form>

            <c:if test="${not empty sessoesPorAluno}">
                <table class="tabela-sessoes">
                    <thead>
                        <tr>
                            <th>Data</th>
                            <th>Horário</th>
                            <th>Local</th>
                            <th>Presença</th>
                            <th>Observações</th>
                            <th>Ações</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sessoesPorAluno}" var="sessao">
                            <tr class="linha-principal"
                                data-id="${sessao.id}"
                                data-aluno="${sessao.aluno.nome}">
                                <td>${sessao.data}</td>
                                <td>${sessao.horario}</td>
                                <td>${sessao.local}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${sessao.presenca == true}">
                                            <span class="texto-presente">Presente</span>
                                        </c:when>
                                        <c:when test="${sessao.presenca == false}">
                                            <span class="texto-ausente">Ausente</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="texto-pendente">Pendente</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty sessao.observacoes}">
                                            ${sessao.observacoes}
                                        </c:when>
                                        <c:otherwise>
                                            -
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="botoes-acoes">
                                        <button class="botao-editar" onclick="abrirEdicaoPorAluno(${sessao.id})">Editar</button>
                                        <button class="botao-excluir" onclick="confirmarExclusao(${sessao.id})">Excluir</button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty sessoesPorAluno && not empty param.matriculaAluno}">
                <div style="text-align: center; padding: 20px; font-size: 16px; color: #666;">
                    Nenhuma sessão encontrada para este aluno
                </div>
            </c:if>
        </div>

        <!-- Seção de Sessões Futuras -->
        <div class="secao-tabela proximas-sessoes"> <!-- Adicionada classe "proximas-sessoes" -->
            <div class="cabecalho-secao">
                <h3>Próximas Sessões</h3>
            </div>

            <table class="tabela-sessoes">
                <thead>
                    <tr>
                        <th>Aluno</th>
                        <th>Data</th>
                        <th>Horário</th>
                        <th>Local</th>
                        <th>Presença</th>
                    </tr>
                    <tr class="linha-filtro">
                        <th><input type="text" name="filtroAluno" placeholder="Nome do aluno"></th>
                        <th><input type="date" name="filtroData"></th>
                        <th><input type="time" name="filtroHorario"></th>
                        <th><input type="text" name="filtroLocal" placeholder="Local"></th>
                        <th><input type="text" name="filtroPresenca" placeholder="Presenca"></th>
                    </tr>
                </thead>

                <tbody>
                    <c:set var="existemFuturas" value="false" />
                    <c:forEach items="${sessoeslista}" var="sessao">
                        <c:if test="${sessao.data >= hoje}">
                            <c:set var="existemFuturas" value="true" />
                            <tr class="linha-principal" data-id="${sessao.id}" id="linha-${sessao.id}">
                                <td>${sessao.aluno.nome}</td>
                                <td>${sessao.data}</td>
                                <td>${sessao.horario}</td>
                                <td>${sessao.local}</td>
                                <td>
                                    <div class="sessao-status">
                                        <c:set var="status" value="Pendente" />
                                        <c:set var="classe" value="texto-pendente" />

                                        <c:choose>
                                            <c:when test="${sessao.presenca != null && sessao.presenca == true}">
                                                <c:set var="status" value="Presente" />
                                                <c:set var="classe" value="texto-presente" />
                                            </c:when>
                                            <c:when test="${sessao.presenca != null && sessao.presenca == false}">
                                                <c:set var="status" value="Ausente" />
                                                <c:set var="classe" value="texto-ausente" />
                                            </c:when>
                                        </c:choose>

                                        <span class="${classe}">${status}</span>
                                        <button class="botao-dropdown" onclick="toggleDetalhes(this)">
                                            <img src="${pageContext.request.contextPath}/static/images/seta.svg" alt="seta" class="icone-dropdown">
                                        </button>

                                        <div class="botoes-acoes">
                                            <button class="botao-editar" onclick="abrirEdicao(${sessao.id})">Editar</button>
                                            <button class="botao-excluir" onclick="confirmarExclusao(${sessao.id})">Excluir</button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr class="linha-detalhes" style="display: none;">
                                <td colspan="6">
                                    <div class="conteudo-detalhes">
                                        <p><strong>Observações:</strong> ${sessao.observacoes}</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>

                    <c:if test="${not existemFuturas}">
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 30px; font-size: 16px; color: #666;">
                                Sem sessões marcadas no momento
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Seção de Sessões Passadas -->
        <div class="secao-tabela sessoes-passadas"> <!-- Adicionada classe "sessoes-passadas" -->
            <div class="cabecalho-secao">
                <h3>Sessões Desatualizadas</h3>
            </div>

            <table class="tabela-sessoes">
                <thead>
                    <tr>
                        <th>Aluno</th>
                        <th>Data</th>
                        <th>Horário</th>
                        <th>Local</th>
                        <th>Presença</th>
                    </tr>
                    <tr class="linha-filtro">
                        <th><input type="text" name="filtroAluno" placeholder="Nome do aluno"></th>
                        <th><input type="date" name="filtroData"></th>
                        <th><input type="time" name="filtroHorario"></th>
                        <th><input type="text" name="filtroLocal" placeholder="Local"></th>
                        <th><input type="text" name="filtroPresenca" placeholder="Presenca"></th>
                    </tr>
                </thead>

                <tbody>
                    <c:set var="existemPassadas" value="false" />
                    <c:forEach items="${sessoeslista}" var="sessao">
                        <c:if test="${sessao.data < hoje}">
                            <c:set var="existemPassadas" value="true" />
                            <tr class="linha-principal" data-id="${sessao.id}" id="linha-${sessao.id}">
                                <td>${sessao.aluno.nome}</td>
                                <td>${sessao.data}</td>
                                <td>${sessao.horario}</td>
                                <td>${sessao.local}</td>
                                <td>
                                    <div class="sessao-status">
                                        <c:set var="status" value="Pendente" />
                                        <c:set var="classe" value="texto-pendente" />

                                        <c:choose>
                                            <c:when test="${sessao.presenca != null && sessao.presenca == true}">
                                                <c:set var="status" value="Presente" />
                                                <c:set var="classe" value="texto-presente" />
                                            </c:when>
                                            <c:when test="${sessao.presenca != null && sessao.presenca == false}">
                                                <c:set var="status" value="Ausente" />
                                                <c:set var="classe" value="texto-ausente" />
                                            </c:when>
                                        </c:choose>

                                        <span class="${classe}">${status}</span>
                                        <button class="botao-dropdown" onclick="toggleDetalhes(this)">
                                            <img src="${pageContext.request.contextPath}/static/images/seta.svg" alt="seta" class="icone-dropdown">
                                        </button>

                                        <div class="botoes-acoes">
                                            <button class="botao-editar" onclick="abrirEdicao(${sessao.id})">Editar</button>
                                            <button class="botao-excluir" onclick="confirmarExclusao(${sessao.id})">Excluir</button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr class="linha-detalhes" style="display: none;">
                                <td colspan="6">
                                    <div class="conteudo-detalhes">
                                        <p><strong>Observações:</strong> ${sessao.observacoes}</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>

                    <c:if test="${not existemPassadas}">
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 30px; font-size: 16px; color: #666;">
                                Sem sessões desatualizadas
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

       <!-- Modal Edição -->
       <div class="modal-overlay" id="modalEditar">
           <div class="modal-conteudo">
               <h2>Editar Sessão</h2>
               <form id="formEditarSessao" action="${pageContext.request.contextPath}/templates/aee/sessoes?acao=atualizar" method="POST">
                   <input type="hidden" name="id" id="idEditar">

                   <label for="alunoEditar">Aluno:</label><br>
                   <input type="text" id="alunoEditar" name="aluno" readonly><br><br>

                   <label for="dataEditar">Data:</label><br>
                   <input type="date" id="dataEditar" name="data" required><br><br>

                   <label for="horarioEditar">Horário:</label><br>
                   <input type="time" id="horarioEditar" name="horario" required><br><br>

                   <label for="localEditar">Local:</label><br>
                   <input type="text" id="localEditar" name="local" required><br><br>

                   <label for="presencaEditar">Presença:</label><br>
                   <select id="presencaEditar" name="presenca">
                       <option value="true">Presente</option>
                       <option value="false">Ausente</option>
                   </select><br><br>

                   <!-- Campo de observações como input text -->
                   <label for="observacoesEditar">Observações:</label><br>
                   <input type="text" id="observacoesEditar" name="observacoes"><br><br>

                   <div class="botoes-modal">
                       <button type="submit">Salvar</button>
                       <button type="button" onclick="fecharModal(modalEditar)">Cancelar</button>
                   </div>
               </form>
           </div>
       </div>

        <!-- 1. Modal exclusivo para edição em "Sessões por Aluno" -->
        <div class="modal-overlay" id="modalEditarPorAluno" style="display: none;">
            <div class="modal-conteudo">
                <h2>Editar Sessão (por Aluno)</h2>
                <form id="formEditarPorAluno" action="${pageContext.request.contextPath}/templates/aee/sessoes?acao=atualizar" method="POST">
                    <!-- === Campos do Formulário === -->
                    <input type="hidden" name="id" id="idEditarPorAluno">

                    <label for="alunoEditarPorAluno">Aluno:</label><br>
                    <input type="text" id="alunoEditarPorAluno" name="aluno" readonly><br><br>

                    <label for="dataEditarPorAluno">Data:</label><br>
                    <input type="date" id="dataEditarPorAluno" name="data" required><br><br>

                    <label for="horarioEditarPorAluno">Horário:</label><br>
                    <input type="time" id="horarioEditarPorAluno" name="horario" required><br><br>

                    <label for="localEditarPorAluno">Local:</label><br>
                    <input type="text" id="localEditarPorAluno" name="local" required><br><br>

                    <label for="presencaEditarPorAluno">Presença:</label><br>
                    <select id="presencaEditarPorAluno" name="presenca">
                        <option value="">Pendente</option>
                        <option value="true">Presente</option>
                        <option value="false">Ausente</option>
                    </select><br><br>

                    <label for="observacoesEditarPorAluno">Observações:</label><br>
                    <textarea id="observacoesEditarPorAluno" name="observacoes" rows="4" style="width:100%;"></textarea><br><br>

                    <div class="botoes-modal">
                        <button type="submit">Salvar</button>
                        <button type="button" onclick="fecharModalPorAluno()">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>


        <!-- Modal Confirmação Exclusão -->
        <div class="modal-overlay" id="modalExcluir">
            <div class="modal-conteudo">
                <h3>Confirmar Exclusão</h3>
                <p>Tem certeza que deseja excluir esta sessão?</p>
                <form id="formExcluirSessao" action="${pageContext.request.contextPath}/templates/aee/sessoes?acao=excluir" method="POST">
                    <input type="hidden" name="id" id="idExcluir">
                    <div class="botoes-modal">
                        <button type="submit">Confirmar</button>
                        <button type="button" onclick="fecharModal(modalExcluir)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Controle dos Modais
        const modais = {
            nova: document.getElementById('modalNovaSessao'),
            editar: document.getElementById('modalEditar'),
            excluir: document.getElementById('modalExcluir')
        };

        const modalPorAluno = document.getElementById('modalEditarPorAluno');

        // Abrir modais
        document.querySelector('.botao-nova-sessao').addEventListener('click', () => {
            modais.nova.style.display = 'flex';
        });

        function abrirEdicao(id) {
                console.log("Editando sessão ID:", id);

                // 1. Encontra a linha da tabela (próximas/passadas) pelo id
                const linha = document.getElementById("linha-" + id);
                if (!linha) {
                    console.error("Sessão não encontrada (linha com id=linha-" + id + ")");
                    return;
                }

                // 2. Extrai as células da linha
                const celulas = linha.cells;

                // 3. Extrai os valores de cada coluna
                const dados = {
                    aluno: celulas[0].textContent.trim(),
                    data: celulas[1].textContent.trim(),    // formato yyyy-MM-dd
                    horario: celulas[2].textContent.trim(), // formato HH:mm
                    local: celulas[3].textContent.trim(),
                    presencaTexto: celulas[4].querySelector('.sessao-status span').textContent.trim()
                };

                // 4. Converte o texto de presença em valor para <select>
                let presencaValue = '';
                if (dados.presencaTexto === "Presente") presencaValue = "true";
                else if (dados.presencaTexto === "Ausente") presencaValue = "false";
                // se for "Pendente", deixa presencaValue = '' para não selecionar nada

                // 5. Preenche o formulário de edição
                document.getElementById('idEditar').value = id;
                document.getElementById('alunoEditar').value = dados.aluno;
                document.getElementById('dataEditar').value = dados.data;
                document.getElementById('horarioEditar').value = dados.horario;
                document.getElementById('localEditar').value = dados.local;
                document.getElementById('presencaEditar').value = presencaValue;

                // 6. Limpa o campo de observações (nas tabelas de futuras/passadas não há coluna própria de observações)
                document.getElementById('observacoesEditar').value = "";

                // 7. Abre o modal de edição
                modais.editar.style.display = 'flex';
            }

        function abrirEdicaoPorAluno(id) {
                // 1) Localizar a <tr> correta dentro da seção “Sessões por Aluno”
                const linha = document.querySelector(`.sessoes-por-aluno .linha-principal[data-id="${id}"]`);
                if (!linha) {
                    console.error("Não encontrou <tr> com data-id=" + id + " em .sessoes-por-aluno");
                    return;
                }

                // 2) Extrair todas as células da linha
                const celulas = linha.cells;

                // 3) Ler sempre via textContent (independente de <span> ou não)
                const nomeAluno = linha.dataset.aluno;                   // vem de data-aluno="..."
                const dataSessao = celulas[0].textContent.trim();        // coluna 0: Data
                const horarioSessao = celulas[1].textContent.trim();     // coluna 1: Horário
                const localSessao = celulas[2].textContent.trim();       // coluna 2: Local
                const presencaTexto = celulas[3].textContent.trim();     // coluna 3: Presença
                let observacoesTexto = "";
                if (celulas[4]) {
                    observacoesTexto = celulas[4].textContent.trim();    // coluna 4: Observações
                }

                // 4) Converter "Presente"/"Ausente"/"Pendente" para value do <select>
                let presencaValue = "";
                if (presencaTexto === "Presente") presencaValue = "true";
                else if (presencaTexto === "Ausente") presencaValue = "false";
                // se for "Pendente" ou texto vazio, deixa presencaValue = "" (seleciona a primeira opção)

                // 5) Preencher campos do formulário dentro do modal
                document.getElementById('idEditarPorAluno').value = id;
                document.getElementById('alunoEditarPorAluno').value = nomeAluno;
                document.getElementById('dataEditarPorAluno').value = dataSessao;
                document.getElementById('horarioEditarPorAluno').value = horarioSessao;
                document.getElementById('localEditarPorAluno').value = localSessao;
                document.getElementById('presencaEditarPorAluno').value = presencaValue;
                document.getElementById('observacoesEditarPorAluno').value = (observacoesTexto === "-" ? "" : observacoesTexto);

                // 6) Exibir o modal
                modalPorAluno.style.display = 'flex';
            }

        function confirmarExclusao(id) {
            document.getElementById('idExcluir').value = id;
            modais.excluir.style.display = 'flex';
        }

        // Fechar modais
        function fecharModal(modal) {
            modal.style.display = 'none';
        }

       // Fechar ao clicar fora
       window.onclick = function(event) {
           Object.values(modais).forEach(modal => {
               if (event.target === modal) {
                   fecharModal(modal);
               }
           });
       }

        // Controle dos Detalhes
        function toggleDetalhes(botao) {
            const linhaDetalhes = botao.closest('tr').nextElementSibling;
            linhaDetalhes.style.display = linhaDetalhes.style.display === 'none' ? 'table-row' : 'none';
        }

        // Filtro simplificado
        document.querySelectorAll('.linha-filtro input').forEach(input => {
            input.addEventListener('input', (e) => {
                const colIndex = e.target.parentElement.cellIndex;
                const valor = e.target.value.toLowerCase();

                document.querySelectorAll('.linha-principal').forEach(linha => {
                    const conteudo = linha.cells[colIndex].textContent.toLowerCase();
                    linha.style.display = conteudo.includes(valor) ? '' : 'none';
                });
            });
        });
    </script>
</body>
</html>