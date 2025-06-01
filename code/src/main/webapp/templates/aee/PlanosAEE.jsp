<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planos AEE</title>
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
            color: #0c0c61;
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

        .linha-superior {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 30px;
        }

        .botao-novo-plano {
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s;
        }

        .botao-novo-plano:hover {
            background-color: #372e9c;
        }

        .tabela-planos {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        .tabela-planos th {
            background-color: #ecf0f1;
            color: #2c3e50;
            text-align: left;
            padding: 14px;
        }

        .tabela-planos td {
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

        .container-acoes {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
        }

        .botao-acao {
            padding: 8px 15px; /* Ajuste para melhor proporção */
            border-radius: 10px; /* Mesmo radius do botão novo */
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 13px;
        }

        /* ESTILO ATUALIZADO PARA O BOTÃO DETALHES */
        .botao-detalhes-plano {
            background-color: #17a2b8;
            color: #ffffff; /* Texto branco */
        }

        .botao-detalhes-plano:hover {
            background-color: #138496;
        }

        @media (max-width: 768px) {
            .container-acoes {
                flex-wrap: wrap;
                justify-content: flex-start;
            }

            .botao-acao {
                flex: 1 1 45%;
            }

            #titulo h2 {
                margin-left: 20px;
                font-size: 1.5rem;
            }

            .conteudo-principal {
                margin: 100px 20px 40px;
                width: auto;
            }
        }

        .botao-acao i {
            margin-right: 5px;
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
            <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professores'">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>
            <button class="menu-btn ativo">Planos AEE</button>
            <button class="menu-btn">Usuários</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Planos AEE</h2>
    </div>

    <div class="conteudo-principal">
        <div class="linha-superior">
            <button class="botao-novo-plano" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/criarPlanoAEE'">+ Novo Plano</button>
        </div>

        <!-- Tabela de Planos AEE -->
        <table class="tabela-planos">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Aluno</th>
                    <th>Professor</th>
                    <th>Data Início</th>
                    <th style="width: 180px">Ações</th>
                </tr>
                <tr class="linha-filtro">
                    <th><input type="text" placeholder="Filtrar ID" oninput="filtrarColuna(this, 0)"></th>
                    <th><input type="text" placeholder="Filtrar Aluno" oninput="filtrarColuna(this, 1)"></th>
                    <th><input type="text" placeholder="Filtrar Professor" oninput="filtrarColuna(this, 2)"></th>
                    <th><input type="text" placeholder="Filtrar Data" oninput="filtrarColuna(this, 3)"></th>
                    <th></th>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${empty planosLista}">
                        <tr>
                            <td colspan="5">Nenhum plano encontrado.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${planosLista}" var="plano">
                            <!-- Linha principal -->
                            <tr class="linha-principal">
                                <td>${plano.id}</td>
                                <td>${plano.nomeAluno}</td>
                                <td>${plano.nomeProfessor}</td>
                                <td><fmt:formatDate value="${plano.dataInicio}" pattern="dd/MM/yyyy" /></td>
                                <td>
                                    <div class="container-acoes">
                                        <!-- BOTÃO ATUALIZADO COM NOVO ESTILO -->
                                        <button class="botao-acao botao-detalhes-plano"
                                            onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/detalhes-plano?id=${plano.id}'">Detalhes
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <script>
        // Função para filtrar por coluna
        function filtrarColuna(input, colIndex) {
            const valor = input.value.toLowerCase();
            document.querySelectorAll('.linha-principal').forEach(linha => {
                const conteudo = linha.cells[colIndex].textContent.toLowerCase();
                linha.style.display = conteudo.includes(valor) ? '' : 'none';
            });
        }
    </script>
</body>
</html>