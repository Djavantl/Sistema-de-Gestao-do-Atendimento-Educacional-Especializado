<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Todos os Relatórios</title>
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
        .linha-superior {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 30px;
        }
        .botao-novo-relatorio {
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s;
        }
        .botao-novo-relatorio:hover {
            background-color: #372e9c;
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
        .botoes-acoes {
            display: flex;
            gap: 8px;
        }
        .botao-editar {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
        }
        .botao-excluir {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
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
        .botao-editar:hover {
            background-color: #0056b3;
        }
        .botao-excluir:hover {
            background-color: #c82333;
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
    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn">Estudantes</button>
            <button class="menu-btn">Professores</button>
            <button class="menu-btn">Sessões</button>
            <button class="menu-btn ativo">Relatórios</button>
        </div>
    </div>

    <!-- TÍTULO -->
    <div id="titulo">
        <h2>Todos os Relatórios</h2>
    </div>

    <!-- CONTEÚDO PRINCIPAL -->
    <div class="conteudo-principal">
        <div class="linha-superior">
            <!-- Botão para criar um novo relatório -->
            <button class="botao-novo-relatorio"
                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios/novo'">
                + Novo Relatório
            </button>
        </div>

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
                    <!-- Se houver relatórios, lista-os -->
                    <c:when test="${not empty relatoriosLista}">
                        <c:forEach items="${relatoriosLista}" var="relatorio">
                            <tr data-id="${relatorio.id}">
                                <td>${relatorio.titulo}</td>
                                <td>
                                    ${relatorio.aluno.nome}
                                    (<small>${relatorio.aluno.matricula}</small>)
                                </td>
                                <td>
                                    <fmt:formatDate value="${relatorio.dataGeracao}" pattern="dd/MM/yyyy" />
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty relatorio.professorAEE}">
                                            ${relatorio.professorAEE.nome}
                                            (<small>${relatorio.professorAEE.siape}</small>)
                                        </c:when>
                                        <c:otherwise>
                                            Não atribuído
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="botoes-acoes">
                                        <!-- Botão Editar -->
                                        <button class="botao-editar"
                                                onclick="window.location.href='${pageContext.request.contextPath}/relatorios/editar?id=${relatorio.id}'">
                                            Editar
                                        </button>

                                        <!-- Botão Detalhes -->
                                        <button class="botao-detalhes"
                                                onclick="window.location.href='${pageContext.request.contextPath}/relatorios/detalhes?id=${relatorio.id}'">
                                            Detalhes
                                        </button>

                                        <!-- Botão Excluir (abre modal) -->
                                        <button class="botao-excluir"
                                                onclick="confirmarExclusao(${relatorio.id})">
                                            Excluir
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <!-- Caso contrário, mostra mensagem -->
                    <c:otherwise>
                        <tr>
                            <td colspan="5" style="text-align: center; color: #888;">
                                Nenhum relatório encontrado.
                            </td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <!-- Modal de Confirmação de Exclusão -->
        <div class="modal-overlay" id="modalExcluir" style="display: none;
             position: fixed; top:0; left:0; width:100%; height:100%;
             background: rgba(0,0,0,0.5); justify-content: center; align-items: center;">
            <div class="modal-conteúdo" style="background: white; padding: 20px; border-radius: 8px; width: 300px;">
                <h3>Confirmar Exclusão</h3>
                <p>Tem certeza que deseja excluir este relatório?</p>
                <form id="formExcluirRelatorio" action="${pageContext.request.contextPath}/relatorios/excluir" method="POST">
                    <input type="hidden" name="id" id="idExcluir">
                    <div class="botoes-modal" style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px;">
                        <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer;">
                            Confirmar
                        </button>
                        <button type="button" onclick="fecharModal()"
                                style="background-color: #e0e0e0; color: #333; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer;">
                            Cancelar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        const modalExcluir = document.getElementById('modalExcluir');

        function confirmarExclusao(id) {
            document.getElementById('idExcluir').value = id;
            modalExcluir.style.display = 'flex';
        }

        function fecharModal() {
            modalExcluir.style.display = 'none';
        }

        window.onclick = function(event) {
            if (event.target === modalExcluir) {
                fecharModal();
            }
        }
    </script>
</body>
</html>
