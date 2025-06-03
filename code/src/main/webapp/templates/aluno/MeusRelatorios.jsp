<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meus Relatórios</title>
    <style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: #f9f9ff;
            overflow-x: hidden;
            font-family: Arial, sans-serif;
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

        #titulo h2 {
            color: rgb(12, 12, 97);
            font-size: 28px;
            margin-left: 350px;
            margin-top: 40px;
        }

        .conteudo-principal {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 40px;
            margin: 80px 0 40px 350px;
            width: 70%;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .tabela-relatorios {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        .tabela-relatorios th {
            background-color: #ecf0f1;
            color: #2c3e50;
            text-align: left;
            padding: 14px;
        }

        .tabela-relatorios td {
            background-color: #ffffff;
            padding: 14px;
            border-bottom: 1px solid #e0e0e0;
        }

        .linha-filtro input {
            width: 100%;
            padding: 8px;
            font-size: 13px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #fefefe;
        }

        .botoes-acoes {
            display: flex;
            gap: 8px;
        }

        .botao-detalhes {
            background-color: #17a2b8;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
        }

        .botao-detalhes:hover {
            background-color: #138496;
        }

        @media (max-width: 768px) {
            #titulo h2 {
                margin-left: 20px;
                margin-top: 20px;
            }

            .conteudo-principal {
                margin: 60px 20px 20px;
                width: auto;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/professor'">Professores</button>
            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">Sessões</button>
            <button class="menu-btn ativo" onclick="window.location.href='${pageContext.request.contextPath}/meus-relatorios?matricula=${matricula}'">Meus Relatórios</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Meus Relatórios</h2>
    </div>

    <div class="conteudo-principal">
        <!-- Tabela de Relatórios -->
        <table class="tabela-relatorios">
            <thead>
                <tr>
                    <th>Título</th>
                    <th>Aluno</th>
                    <th>Data</th>
                    <th>Professor</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty relatoriosLista}">
                        <c:forEach items="${relatoriosLista}" var="relatorio">
                            <tr data-id="${relatorio.id}">
                                <td>${relatorio.titulo}</td>
                                <td>${relatorio.aluno.nome}</td>
                                <td>
                                    ${relatorio.dataGeracao.dayOfMonth}/${relatorio.dataGeracao.monthValue}/${relatorio.dataGeracao.year}
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty relatorio.professorAEE}">
                                            ${relatorio.professorAEE.nome} (${relatorio.professorAEE.siape})
                                        </c:when>
                                        <c:otherwise>
                                            Não atribuído
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="botoes-acoes">
                                        <!-- Botão Detalhes -->
                                        <button class="botao-detalhes"
                                                onclick="window.location.href='${pageContext.request.contextPath}/relatorios/meus-detalhes?id=${relatorio.id}'">
                                            Detalhes
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" style="text-align: center;">
                                Nenhum relatório encontrado
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</body>
</html>