<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todos os Relatórios</title>
    <style>
        /* Estilos idênticos à página original, mas sem .linha-superior e .botao-novo-relatorio */
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

        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .tabela-relatorios {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 16px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .tabela-relatorios th {
            background-color: #4D44B5;
            color: white;
            text-align: left;
            padding: 16px 20px;
            font-weight: 600;
        }

        .tabela-relatorios td {
            background-color: #fff;
            padding: 14px 20px;
            border-bottom: 1px solid #f0f0f0;
        }

        .tabela-relatorios tr:last-child td {
            border-bottom: none;
        }

        .tabela-relatorios tr:hover td {
            background-color: #f9f9ff;
        }

        .botoes-acoes {
            display: flex;
            gap: 10px;
        }

        .botao-detalhes {
            background-color: #e0e0e0;
            color: #333;
            border: none;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-detalhes:hover {
            background-color: #d0d0d0;
            transform: translateY(-2px);
        }

        .botao-editar {
            background-color: #6a5fcc;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-editar:hover {
            background-color: #554bbd;
            transform: translateY(-2px);
        }

        .botao-excluir {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-excluir:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

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

        #modalExcluir .modal-conteudo {
            text-align: center;
            padding: 40px;
        }

        #modalExcluir p {
            font-size: 18px;
            margin-bottom: 30px;
            color: #555;
            line-height: 1.6;
        }

        #modalExcluir .botoes-modal {
            justify-content: center;
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
        }

        .botoes-modal button[type="button"]:hover {
            background-color: #cfcfcf;
            transform: translateY(-2px);
        }

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

        .footer {
            text-align: center;
            padding: 30px;
            color: #4D44B5;
            font-size: 14px;
            margin-top: 40px;
        }

        @media (max-width: 1200px) {
            .conteudo-principal {
                padding: 30px;
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
                <img src="${pageContext.request.contextPath}/static/images/sidebar/inicio.svg" alt="Início" />
                Início
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/alunos'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/alunos.svg" alt="Estudantes" />
                Estudantes
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/sessoes.svg" alt="Sessões" />
                Sessões
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/planosAEE'">
                <img src="${pageContext.request.contextPath}/static/images/meuplano.svg" alt="Planos AEE" />
                Planos AEE
            </button>
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios/todos'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/relatorios.svg" alt="Relatórios" />
                Relatórios
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div class="header">
            <div class="titulo">
                <h1>Todos os Relatórios</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <div class="conteudo-container">
            <!-- Tabela de Relatórios (sem botão de adicionar) -->
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
                                    <td>${relatorio.dataGeracao}</td>
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
                                            <button class="botao-editar"
                                                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios/editar?id=${relatorio.id}'">
                                                Editar
                                            </button>
                                            <button class="botao-detalhes"
                                                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios/detalhes?id=${relatorio.id}'">
                                                Detalhes
                                            </button>
                                            <button class="botao-excluir"
                                                    onclick="confirmarExclusao(${relatorio.id})">
                                                Excluir
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

            <!-- Modal de Confirmação de Exclusão -->
            <div class="modal-overlay" id="modalExcluir">
                <div class="modal-conteudo">
                    <h3>Confirmar Exclusão</h3>
                    <p>Tem certeza que deseja excluir este relatório? Esta ação não pode ser desfeita.</p>
                    <form id="formExcluirRelatorio" action="${pageContext.request.contextPath}/relatorios/excluir" method="POST">
                        <input type="hidden" name="id" id="idExcluir">
                        <div class="botoes-modal">
                            <button type="submit">Confirmar Exclusão</button>
                            <button type="button" onclick="fecharModal(modalExcluir)">Cancelar</button>
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
        const modalExcluir = document.getElementById('modalExcluir');

        function confirmarExclusao(id) {
            document.getElementById('idExcluir').value = id;
            modalExcluir.style.display = 'flex';
        }

        function fecharModal(modal) {
            modal.style.display = 'none';
        }

        window.onclick = function(event) {
            if (event.target === modalExcluir) {
                modalExcluir.style.display = 'none';
            }
        }
    </script>
</body>
</html>