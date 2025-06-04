<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minhas Sessões</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Reset e estilos globais */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Body com gradiente roxo */
        body {
            background: #E6E6FA;
            color: #333;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* Sidebar */
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

        /* Conteúdo Principal */
        .conteudo-principal {
            margin: 80px 0 40px 350px;
            width: 70%;
            padding: 40px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 10;
        }

        #titulo h2 {
            color: #4D44B5;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .detalhes-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .botao-voltar {
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s;
        }

        .botao-voltar:hover {
            background-color: #372e9c;
        }

        /* SEÇÕES */
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
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cabecalho-sessao-futuras {
            background: #1ABC9C;
            border-bottom: 3px solid #16A085;
        }

        .cabecalho-sessao-passadas {
            background: #E74C3C;
            border-bottom: 3px solid #C0392B;
        }

        /* TABELAS */
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

        /* Elementos Decorativos */
        .decorative-circle {
            position: absolute;
            border-radius: 50%;
            z-index: 0;
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

        /* Responsividade */
        @media (max-width: 992px) {
            .sidebar {
                width: 220px;
            }

            .conteudo-principal {
                margin-left: 240px;
                width: calc(100% - 260px);
                padding: 30px;
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
                margin: 30px auto;
                width: 90%;
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
        }

        /* Status de presença */
        .texto-presente {
            color: #28a745;
            font-weight: 600;
        }

        .texto-ausente {
            color: #dc3545;
            font-weight: 600;
        }

        .texto-pendente {
            color: #ffc107;
            font-weight: 600;
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
                onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">
                 Início
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aluno/minhas-informacoes?matricula=${matricula}'">
                Minhas Informações
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/MinhaOrganizacao?matricula=${matricula}'">
                Minha Organização
            </button>

            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/meu-plano?matricula=${matricula}'">
                 Meu Plano AEE
            </button>
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aluno/minhas-sessoes?matricula=${matricula}'">
                Minhas Sessões
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/meus-relatorios?matricula=${matricula}'">
                Meus Relatórios
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div id="titulo">
            <h2>Minhas Sessões</h2>
        </div>

        <div class="detalhes-header">
            <div></div>
            <button class="botao-voltar" onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">Voltar</button>
        </div>

        <!-- Seção de Sessões Futuras -->
        <div class="secao-tabela">
            <div class="cabecalho-secao cabecalho-sessao-futuras">
                <h3><i class="fas fa-calendar-check"></i> Próximas Sessões</h3>
            </div>

            <c:choose>
                <c:when test="${not empty sessoesFuturas}">
                    <table class="tabela-sessoes">
                        <thead>
                            <tr>
                                <th>Data</th>
                                <th>Horário</th>
                                <th>Local</th>
                                <th>Presença</th>
                                <th>Observações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sessoesFuturas}" var="sessao">
                                <tr>
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
                                                ${fn:substring(sessao.observacoes, 0, 30)}${fn:length(sessao.observacoes) > 30 ? '...' : ''}
                                            </c:when>
                                            <c:otherwise>
                                                -
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; font-size: 16px; color: #666;">
                        <p>Nenhuma sessão futura agendada.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Seção de Sessões Passadas -->
        <div class="secao-tabela">
            <div class="cabecalho-secao cabecalho-sessao-passadas">
                <h3><i class="fas fa-history"></i> Sessões Passadas</h3>
            </div>

            <c:choose>
                <c:when test="${not empty sessoesPassadas}">
                    <table class="tabela-sessoes">
                        <thead>
                            <tr>
                                <th>Data</th>
                                <th>Horário</th>
                                <th>Local</th>
                                <th>Presença</th>
                                <th>Observações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${sessoesPassadas}" var="sessao">
                                <tr>
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
                                                ${fn:substring(sessao.observacoes, 0, 30)}${fn:length(sessao.observacoes) > 30 ? '...' : ''}
                                            </c:when>
                                            <c:otherwise>
                                                -
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; font-size: 16px; color: #666;">
                        <p>Nenhuma sessão passada registrada.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <script>
        // Botão Voltar
        document.querySelector('.botao-voltar').onclick = function() {
            window.location.href = '${pageContext.request.contextPath}/telaInicialAluno';
        };
    </script>
</body>
</html>