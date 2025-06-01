<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Relatório</title>
    <style>
        /* Mesmos estilos do DetalhesAluno.jsp para manter consistência */

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f9f9ff;
            overflow-x: hidden;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Cabeçalho de título */
        #titulo {
            margin-left: 350px;
            padding-top: 40px;
            margin-bottom: 20px;
        }
        #titulo h2 {
            color: rgb(12, 12, 97);
            font-size: 28px;
        }

        /* Sidebar igual ao DetalhesAluno */
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

        .logo h2 {
            color: white;
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

        /* Conteúdo principal */
        .conteudo-principal {
            margin: 80px 0 40px 350px;
            width: 70%;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
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
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: start;
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

        /* Botões de ação */
        .linha-superior {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 30px;
            gap: 15px;
            margin-top: 20px;
        }

        .botoes-acoes {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-left: auto;
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

        .alert {
            padding: 15px;
            margin: 20px 0;
            border-radius: 8px;
            border: 1px solid transparent;
        }

        .success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        /* Estilos para lista de avaliações */
        .avaliacoes-container {
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
        }

        .avaliacao-item {
            padding: 15px;
            background-color: #fff;
        }

        .avaliacao-item.separador {
            border-bottom: 2px solid #bfbfbf;
        }

        .acoes-avaliacao {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 10px;
        }

        .botao-adicionar {
            background-color: #4D44B5;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            cursor: pointer;
            margin-bottom: 15px;
        }

        .botao-editar-avaliacao {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
        }

        .botao-excluir-avaliacao {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
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
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professor'">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>
            <button class="menu-btn ativo">Relatórios</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Detalhes do Relatório</h2>
    </div>

    <div class="conteudo-principal">
        <!-- Resumo -->
        <div class="info-section">
            <h3>Resumo</h3>
            <div class="info-item">
                <p style="min-height: 150px;">${relatorio.resumo}</p>
            </div>
        </div>

        <!-- Observações -->
        <div class="info-section">
            <h3>Observações</h3>
            <div class="info-item">
                <c:choose>
                    <c:when test="${not empty relatorio.observacoes}">
                        <p style="min-height: 100px;">${relatorio.observacoes}</p>
                    </c:when>
                    <c:otherwise>
                        <p style="min-height: 100px;">Nenhuma observação registrada</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Avaliações -->
        <div class="info-section">
            <h3>Avaliações</h3>

            <button class="botao-adicionar"
                    onclick="window.location.href='${pageContext.request.contextPath}/avaliacao?acao=criar&relatorioId=${relatorio.id}'">
                Adicionar Avaliação
            </button>

            <c:if test="${not empty relatorio.avaliacoes}">
                <div class="avaliacoes-container">
                    <c:forEach items="${relatorio.avaliacoes}" var="avaliacao" varStatus="loop">
                        <div class="avaliacao-item ${not loop.last ? 'separador' : ''}">
                            <div class="info-grid">
                                <div class="info-item">
                                    <label>Área</label>
                                    <p>${avaliacao.area}</p>
                                </div>
                                <div class="info-item">
                                    <label>Desempenho Verificado</label>
                                    <p>${avaliacao.desempenhoVerificado}</p>
                                </div>
                                <div class="info-item">
                                    <label>Observações</label>
                                    <p>${avaliacao.observacoes}</p>
                                </div>
                            </div>
                            <div class="acoes-avaliacao">
                                <button class="botao-editar-avaliacao"
                                        onclick="window.location.href='${pageContext.request.contextPath}/avaliacao?acao=editar&id=${avaliacao.id}&relatorioId=${relatorio.id}'">
                                    Editar
                                </button>
                                <form action="${pageContext.request.contextPath}/avaliacao" method="POST" style="display:inline;">
                                    <input type="hidden" name="acao" value="excluir" />
                                    <input type="hidden" name="id" value="${avaliacao.id}" />
                                    <input type="hidden" name="relatorioId" value="${relatorio.id}" />
                                    <button type="submit" class="botao-excluir-avaliacao"
                                        onclick="return confirm('Tem certeza que deseja excluir esta avaliação?')">
                                        Excluir
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>

        <!-- Botão Voltar -->
        <div class="linha-superior">
            <button class="botao-novo-aluno"
                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios?alunoMatricula=${relatorio.aluno.matricula}'">
                Voltar
            </button>
        </div>
    </div>
</body>
</html>
