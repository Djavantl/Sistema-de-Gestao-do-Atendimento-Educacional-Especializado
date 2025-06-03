<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sessões de Atendimento</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
    /* ======================== RESET E BASE ======================== */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
        background-color: #E6E6FA;
        color: #333;
        min-height: 100vh;
        position: relative;
        overflow-x: hidden;
    }

    /* ======================== SIDEBAR ======================== */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        width: 250px;
        height: 100%;
        background: #4D44B5;
        color: white;
        padding: 20px;
        display: flex;
        flex-direction: column;
        align-items: center;
        z-index: 100;
    }

    .logo {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 30px;
    }

    .logo img {
        width: 80px;
        height: 80px;
        object-fit: contain;
    }

    .logo h2 {
        color: #ffffff;
        font-size: 24px;
        font-weight: 700;
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
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .menu-btn:hover {
        background-color: rgba(255, 255, 255, 0.15);
    }

    .menu-btn.ativo {
        background-color: #f9f9ff;
        color: #4D44B5;
    }

    .menu-btn img {
        width: 24px;
        height: 24px;
        filter: brightness(0) invert(1);
    }

    .menu-btn.ativo img {
        filter: invert(26%) sepia(33%) saturate(3500%) hue-rotate(261deg) brightness(86%) contrast(85%);
    }

    /* ======================== CONTEÚDO PRINCIPAL ======================== */
    .conteudo-principal {
        margin-left: 280px;
        padding: 40px 60px;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 20px 0;
        margin-bottom: 30px;
    }

    .titulo h1 {
        color: #4D44B5;
        font-size: 42px;
        font-weight: 800;
        line-height: 1.2;
        max-width: 600px;
    }

    .user-info {
        background: rgba(255, 255, 255, 0.9);
        border-radius: 20px;
        padding: 20px 25px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        min-width: 280px;
        text-align: center;
    }

    .user-info p {
        color: #4D44B5;
        font-weight: 600;
        margin-bottom: 10px;
        font-size: 18px;
    }

    .user-info .funcao {
        font-size: 16px;
        color: #777;
        font-weight: 500;
    }

    /* ======================== BOTÕES ======================== */
    .botao-nova-sessao,
    .botao-buscar,
    .botao-filtrar,
    .botao-editar,
    .botao-excluir,
    .botoes-modal button,
    .botao-dropdown {
        border-radius: 10px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .botao-nova-sessao {
        background-color: #4D44B5;
        color: #fff;
        border: none;
        padding: 14px 28px;
        font-size: 16px;
    }

    .botao-nova-sessao:hover {
        background-color: #372e9c;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
    }

    .botao-buscar {
        background-color: #4D44B5;
        color: white;
        padding: 12px 24px;
        font-size: 15px;
        border: none;
    }

    .botao-buscar:hover {
        background-color: #372e9c;
        transform: translateY(-2px);
    }

    .botao-filtrar {
        background-color: #1abc9c;
        color: white;
        padding: 10px 20px;
        font-size: 14px;
        border: none;
        margin-top: 5px;
    }

    .botao-filtrar:hover {
        background-color: #16a085;
        transform: translateY(-2px);
    }

    /* Botões de ação com ícones */
    .botao-editar {
        background-color: #6a5fcc;
        color: #fff;
        padding: 8px 16px;
        font-size: 14px;
        border: none;
    }

    .botao-editar:hover {
        background-color: #554bbd;
        transform: translateY(-2px);
    }

    .botao-excluir {
        background-color: #dc3545;
        color: #fff;
        padding: 8px 16px;
        font-size: 14px;
        border: none;
    }

    .botao-excluir:hover {
        background-color: #c82333;
        transform: translateY(-2px);
    }

    .botao-dropdown {
        background: none;
        border: none;
        color: #4D44B5;
        padding: 5px;
        font-size: 16px;
        box-shadow: none;
    }

    /* ======================== FILTROS ======================== */
    .filtro-container {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        margin-bottom: 20px;
        background: #f4f4fc;
        padding: 15px;
        border-radius: 12px;
    }

    .filtro-group {
        position: relative;
        flex: 1;
        min-width: 200px;
    }

    .filtro-group label {
        display: block;
        font-weight: 600;
        margin-bottom: 8px;
        color: #555;
        font-size: 14px;
    }

    .filtro-input {
        width: 100%;
        padding: 12px 16px 12px 40px;
        font-size: 15px;
        border: 1px solid #ddd;
        border-radius: 10px;
        background-color: #fff;
        transition: all 0.3s ease;
    }

    .filtro-input:focus {
        border-color: #4D44B5;
        box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
        outline: none;
    }

    .filtro-icon {
        position: absolute;
        left: 12px;
        top: 38px;
        color: #777;
        font-size: 18px;
    }

    /* ======================== TABELAS ======================== */
    .linha-superior {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
        flex-wrap: wrap;
        gap: 15px;
    }

    .conteudo-container {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        position: relative;
        overflow: hidden;
    }

    .tabela-sessoes {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
        font-size: 16px;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }

    .tabela-sessoes th {
        background-color: #4D44B5;
        color: white;
        text-align: left;
        padding: 16px 20px;
        font-weight: 600;
    }

    .tabela-sessoes td {
        background-color: #fff;
        padding: 14px 20px;
        border-bottom: 1px solid #f0f0f0;
    }

    .tabela-sessoes tr:last-child td {
        border-bottom: none;
    }

    .tabela-sessoes tr:hover td {
        background-color: #f9f9ff;
    }

    /* ======================== SEÇÕES ======================== */
    .secao-tabela {
        margin-top: 40px;
        margin-bottom: 30px;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        background-color: #ffffff;
        position: relative;
    }

    .cabecalho-secao {
        background-color: #4D44B5;
        padding: 15px 25px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .cabecalho-secao h3 {
        color: white;
        font-size: 20px;
        font-weight: 600;
        margin: 0;
    }

    .selecionar-aluno-container {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 15px 20px;
        background-color: #f4f4fc;
        border-radius: 10px;
        margin: 20px;
        flex-wrap: wrap;
    }

    .selecionar-aluno-container label {
        font-weight: 600;
        color: #2c3e50;
        font-size: 15px;
    }

    .selecionar-aluno-container select {
        flex-grow: 1;
        padding: 12px 16px;
        font-size: 15px;
        border: 1px solid #ddd;
        border-radius: 12px;
        background-color: #fff;
        min-width: 250px;
    }

    /* ======================== MODAIS ======================== */
    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        backdrop-filter: blur(4px);
        background-color: rgba(0, 0, 0, 0.3);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 2000;
    }

    .modal-conteudo {
        background-color: #fff;
        border-radius: 20px;
        width: 650px;
        max-width: 90%;
        max-height: 90vh;
        overflow-y: auto;
        padding: 30px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
    }

    .modal-conteudo h3 {
        text-align: center;
        margin-bottom: 25px;
        color: #4D44B5;
        font-size: 26px;
        font-weight: 700;
    }

    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 25px;
    }

    .input-group {
        display: flex;
        flex-direction: column;
        margin-bottom: 18px;
    }

    .input-group label {
        font-weight: 600;
        margin-bottom: 8px;
        font-size: 15px;
        color: #555;
    }

    .input-group input,
    .input-group select,
    .input-group textarea {
        padding: 12px 16px;
        font-size: 15px;
        border: 1px solid #ddd;
        border-radius: 12px;
        background-color: #fafafa;
        transition: all 0.3s ease;
    }

    .input-group input:focus,
    .input-group select:focus,
    .input-group textarea:focus {
        border-color: #4D44B5;
        box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
        outline: none;
    }

    .full-width {
        grid-column: 1 / -1;
    }

    .botoes-modal {
        display: flex;
        justify-content: flex-end;
        gap: 15px;
        margin-top: 20px;
    }

    .botoes-modal button[type="submit"] {
        background-color: #4D44B5;
        color: #fff;
        border: none;
        padding: 12px 28px;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .botoes-modal button[type="submit"]:hover {
        background-color: #372e9c;
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(77, 68, 181, 0.3);
    }

    .botoes-modal button[type="button"] {
        background-color: #e0e0e0;
        color: #333;
        border: none;
        padding: 12px 28px;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .botoes-modal button[type="button"]:hover {
        background-color: #cfcfcf;
        transform: translateY(-2px);
    }

    /* ======================== ELEMENTOS DECORATIVOS ======================== */
    .decorative-circle {
        position: absolute;
        border-radius: 50%;
        z-index: -1;
    }

    .circle-1 {
        width: 300px;
        height: 300px;
        background: rgba(255, 215, 0, 0.15);
        top: -150px;
        right: -150px;
    }

    .circle-2 {
        width: 200px;
        height: 200px;
        background: rgba(77, 68, 181, 0.15);
        bottom: -100px;
        right: 200px;
    }

    .circle-3 {
        width: 150px;
        height: 150px;
        background: rgba(255, 255, 255, 0.1);
        bottom: 100px;
        left: 350px;
    }

    /* ======================== RODAPÉ ======================== */
    .footer {
        text-align: center;
        padding: 30px;
        color: #4D44B5;
        font-size: 14px;
        margin-top: 40px;
    }

    /* ======================== RESPONSIVIDADE ======================== */
    @media (max-width: 1200px) {
        .conteudo-principal {
            padding: 30px;
        }

        .form-grid {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 992px) {
        .sidebar {
            width: 220px;
        }

        .conteudo-principal {
            margin-left: 220px;
        }

        .header {
            flex-direction: column;
            gap: 20px;
            align-items: flex-start;
        }
    }

    @media (max-width: 768px) {
        .sidebar {
            width: 100%;
            height: auto;
            position: relative;
            padding: 20px;
        }

        .conteudo-principal {
            margin-left: 0;
            padding: 25px;
        }

        .menu {
            flex-direction: row;
            flex-wrap: wrap;
            margin-top: 20px;
            gap: 10px;
        }

        .menu-btn {
            padding: 12px 15px;
            font-size: 15px;
        }

        .botoes-acoes {
            flex-wrap: wrap;
        }

        .filtro-group {
            min-width: 100%;
        }

        .linha-superior {
            flex-direction: column;
            align-items: flex-start;
        }
    }
    </style>
</head>
<body>
    <!-- Elementos decorativos -->
    <div class="decorative-circle circle-1"></div>
    <div class="decorative-circle circle-2"></div>
    <div class="decorative-circle circle-3"></div>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logoAEE.png" alt="Logo AEE+" />
            <h2>AEE +</h2>
        </div>

        <div class="menu">
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/TelaInicial.jsp'">
                <i class="fas fa-home"></i>
                Início
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/alunos'">
                <i class="fas fa-user-graduate"></i>
                Estudantes
            </button>
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">
                <i class="fas fa-calendar-alt"></i>
                Sessões
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/planosAEE'">
                <i class="fas fa-file-alt"></i>
                Planos AEE
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios'">
                <i class="fas fa-chart-bar"></i>
                Relatórios
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div class="header">
            <div class="titulo">
                <h1>Sessões de Atendimento</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <div class="conteudo-container">
            <div class="linha-superior">
                <button class="botao-nova-sessao">
                    <i class="fas fa-plus"></i> Nova Sessão
                </button>

            </div>

            <!-- Modal Nova Sessão -->
            <div class="modal-overlay" id="modalNovaSessao">
                <div class="modal-conteudo">
                    <h3><i class="fas fa-calendar-plus"></i> Criar Nova Sessão</h3>
                    <form id="formNovaSessao" action="${pageContext.request.contextPath}/templates/aee/sessoes?acao=criar" method="POST">
                        <div class="form-grid">
                            <div class="input-group">
                                <label for="aluno"><i class="fas fa-user-graduate"></i> Nome do Aluno:</label>
                                <select name="aluno_matricula" id="aluno" required>
                                    <option value="" disabled selected>Selecione um aluno</option>
                                    <c:forEach items="${todosAlunos}" var="aluno">
                                        <option value="${aluno.matricula}">${aluno.nome}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="input-group">
                                <label for="data"><i class="far fa-calendar"></i> Data:</label>
                                <input type="date" id="data" name="data" required>
                            </div>

                            <div class="input-group">
                                <label for="horario"><i class="far fa-clock"></i> Horário:</label>
                                <input type="time" id="horario" name="horario" required>
                            </div>

                            <div class="input-group">
                                <label for="local"><i class="fas fa-map-marker-alt"></i> Local:</label>
                                <input type="text" id="local" name="local" required>
                            </div>
                        </div>

                        <div class="botoes-modal">
                            <button type="submit">
                                <i class="fas fa-save"></i> Salvar
                            </button>
                            <button type="button" onclick="fecharModal(modalNovaSessao)">
                                <i class="fas fa-times"></i> Cancelar
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Nova Seção: Sessões por Aluno -->
            <div class="secao-tabela">
                <div class="cabecalho-secao">
                    <h3><i class="fas fa-user-graduate"></i> Sessões por Aluno</h3>

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
                        <button type="submit" class="botao-buscar">
                            <i class="fas fa-search"></i> Buscar
                        </button>
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
                                                <span class="texto-presente"><i class="fas fa-check-circle"></i> Presente</span>
                                            </c:when>
                                            <c:when test="${sessao.presenca == false}">
                                                <span class="texto-ausente"><i class="fas fa-times-circle"></i> Ausente</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="texto-pendente"><i class="fas fa-clock"></i> Pendente</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty sessao.observacoes}">
                                                ${fn:substring(sessao.observacoes, 0, 30)}${fn:length(sessao.observacoes) > 30 ? '...' : ''}
                                            </c:when>
                                            <c:otherwise>
                                                -
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="botoes-acoes">
                                            <button class="botao-editar"
                                                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes?action=editar&id=${sessao.id}'">
                                                <i class="fas fa-edit"></i> Editar
                                            </button>
                                            <button class="botao-excluir" onclick="confirmarExclusao(${sessao.id})">
                                                <i class="fas fa-trash"></i> Excluir
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>

                <c:if test="${empty sessoesPorAluno && not empty param.matriculaAluno}">
                    <div style="text-align: center; padding: 40px; font-size: 16px; color: #666;">
                        <i class="fas fa-calendar-times" style="font-size: 48px; margin-bottom: 20px; color: #ccc;"></i>
                        <p>Nenhuma sessão encontrada para este aluno</p>
                    </div>
                </c:if>
            </div>

            <!-- Seção de Sessões Futuras -->
            <div class="secao-tabela">
                <div class="cabecalho-secao">
                    <h3><i class="fas fa-calendar-check"></i> Próximas Sessões</h3>

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

                                            <span class="${classe}"><i class="fas fa-clock"></i> ${status}</span>
                                            <button class="botao-dropdown" onclick="toggleDetalhes(this)">
                                                <i class="fas fa-chevron-down"></i>
                                            </button>

                                            <div class="botoes-acoes">
                                                <button class="botao-editar"
                                                        onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes?action=editar&id=${sessao.id}'">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="botao-excluir" onclick="confirmarExclusao(${sessao.id})">
                                                    <i class="fas fa-trash"></i>
                                                </button>
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
                                <td colspan="5" style="text-align: center; padding: 40px; font-size: 16px; color: #666;">
                                    <i class="fas fa-calendar-plus" style="font-size: 48px; margin-bottom: 20px; color: #ccc;"></i>
                                    <p>Sem sessões marcadas no momento</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Seção de Sessões Passadas -->
            <div class="secao-tabela">
                <div class="cabecalho-secao">
                    <h3><i class="fas fa-history"></i> Sessões Desatualizadas</h3>

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

                                            <span class="${classe}">
                                                <c:choose>
                                                    <c:when test="${status == 'Presente'}"><i class="fas fa-check-circle"></i></c:when>
                                                    <c:when test="${status == 'Ausente'}"><i class="fas fa-times-circle"></i></c:when>
                                                    <c:otherwise><i class="fas fa-clock"></i></c:otherwise>
                                                </c:choose>
                                                ${status}
                                            </span>
                                            <button class="botao-dropdown" onclick="toggleDetalhes(this)">
                                                <i class="fas fa-chevron-down"></i>
                                            </button>

                                            <div class="botoes-acoes">
                                                <button class="botao-editar"
                                                        onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes?action=editar&id=${sessao.id}'">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="botao-excluir" onclick="confirmarExclusao(${sessao.id})">
                                                    <i class="fas fa-trash"></i>
                                                </button>
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
                                <td colspan="5" style="text-align: center; padding: 40px; font-size: 16px; color: #666;">
                                    <i class="fas fa-calendar-check" style="font-size: 48px; margin-bottom: 20px; color: #ccc;"></i>
                                    <p>Sem sessões desatualizadas</p>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <!-- Modal Edição -->
            <div class="modal-overlay" id="modalEditar">
                <div class="modal-conteudo">
                    <h3><i class="fas fa-edit"></i> Editar Sessão</h3>
                    <form id="formEditarSessao" action="${pageContext.request.contextPath}/templates/aee/sessoes?acao=atualizar" method="POST">
                        <div class="form-grid">
                            <div class="input-group">
                                <label for="alunoEditar"><i class="fas fa-user-graduate"></i> Aluno:</label>
                                <input type="text" id="alunoEditar" name="aluno" readonly>
                            </div>

                            <div class="input-group">
                                <label for="dataEditar"><i class="far fa-calendar"></i> Data:</label>
                                <input type="date" id="dataEditar" name="data" required>
                            </div>

                            <div class="input-group">
                                <label for="horarioEditar"><i class="far fa-clock"></i> Horário:</label>
                                <input type="time" id="horarioEditar" name="horario" required>
                            </div>

                            <div class="input-group">
                                <label for="localEditar"><i class="fas fa-map-marker-alt"></i> Local:</label>
                                <input type="text" id="localEditar" name="local" required>
                            </div>

                            <div class="input-group">
                                <label for="presencaEditar"><i class="fas fa-user-check"></i> Presença:</label>
                                <select id="presencaEditar" name="presenca">
                                    <option value="true">Presente</option>
                                    <option value="false">Ausente</option>
                                </select>
                            </div>

                            <div class="input-group full-width">
                                <label for="observacoesEditar"><i class="fas fa-comment-alt"></i> Observações:</label>
                                <textarea id="observacoesEditar" name="observacoes" rows="4"></textarea>
                            </div>
                        </div>

                        <div class="botoes-modal">
                            <button type="submit">
                                <i class="fas fa-save"></i> Salvar
                            </button>
                            <button type="button" onclick="fecharModal(modalEditar)">
                                <i class="fas fa-times"></i> Cancelar
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Modal Confirmação Exclusão -->
            <div class="modal-overlay" id="modalExcluir">
                <div class="modal-conteudo">
                    <h3><i class="fas fa-exclamation-triangle"></i> Confirmar Exclusão</h3>
                    <p>Tem certeza que deseja excluir esta sessão?</p>
                    <form id="formExcluirSessao" action="${pageContext.request.contextPath}/templates/aee/sessoes?acao=excluir" method="POST">
                        <input type="hidden" name="id" id="idExcluir">
                        <div class="botoes-modal">
                            <button type="submit">
                                <i class="fas fa-trash"></i> Confirmar
                            </button>
                            <button type="button" onclick="fecharModal(modalExcluir)">
                                <i class="fas fa-times"></i> Cancelar
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>

    <script>
        // Controle dos Modais
        const modais = {
            nova: document.getElementById('modalNovaSessao'),
            editar: document.getElementById('modalEditar'),
            excluir: document.getElementById('modalExcluir')
        };

        // Abrir modais
        document.querySelector('.botao-nova-sessao').addEventListener('click', () => {
            modais.nova.style.display = 'flex';
        });

        function abrirEdicao(id) {
            console.log("Abrindo edição para sessão ID:", id);
            // Aqui você implementaria a lógica para preencher o modal de edição
            modais.editar.style.display = 'flex';
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

        // Filtro de busca
        document.getElementById('filtroGeral').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll('.tabela-sessoes tbody tr.linha-principal');

            rows.forEach(row => {
                const rowText = row.textContent.toLowerCase();
                row.style.display = rowText.includes(searchTerm) ? '' : 'none';
            });
        });

        // Filtro de status
        document.getElementById('filtroStatus').addEventListener('change', function() {
            const status = this.value;
            const rows = document.querySelectorAll('.tabela-sessoes tbody tr.linha-principal');

            rows.forEach(row => {
                if (status === 'all') {
                    row.style.display = '';
                } else {
                    const statusCell = row.querySelector('.sessao-status span');
                    const rowStatus = statusCell ? statusCell.textContent.toLowerCase() : '';
                    row.style.display = rowStatus.includes(status) ? '' : 'none';
                }
            });
        });
    </script>
</body>
</html>