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
            border-radius: 10px;
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

        /* ======================== SEÇÕES DE CONTEÚDO ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .info-section {
            margin-bottom: 30px;
        }

        .info-section h3 {
            color: #4D44B5;
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4D44B5;
        }

        .info-content {
            background-color: #f9f9ff;
            padding: 20px;
            border-radius: 15px;
            min-height: 150px;
            box-shadow: inset 0 0 10px rgba(0,0,0,0.05);
        }

        .info-content p {
            font-size: 16px;
            line-height: 1.6;
            color: #555;
        }

        /* ======================== AVALIAÇÕES ======================== */
        .avaliacoes-container {
            margin-top: 20px;
        }

        .avaliacao-item {
            background-color: #ffffff;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
        }

        .avaliacao-item:last-child {
            margin-bottom: 0;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .info-item {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
        }

        .info-item label {
            display: block;
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .info-item p {
            margin: 0;
            font-size: 16px;
            color: #2c3e50;
            line-height: 1.5;
        }

        .acoes-avaliacao {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        /* ======================== BOTÕES ======================== */
        .botao-adicionar {
            background-color: #4D44B5;
            color: #fff;
            border: none;
            padding: 12px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
            margin-bottom: 20px;
        }

        .botao-adicionar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .botao-voltar {
            background-color: #4D44B5;
            color: #fff;
            border: none;
            padding: 12px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        }

        .botao-voltar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .botao-editar-avaliacao {
            background-color: #6a5fcc;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-editar-avaliacao:hover {
            background-color: #554bbd;
            transform: translateY(-2px);
        }

        .botao-excluir-avaliacao {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-excluir-avaliacao:hover {
            background-color: #c82333;
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

            .info-grid {
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

            .acoes-avaliacao {
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
                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/relatorios.svg" alt="Relatórios" />
                Relatórios
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div class="header">
            <div class="titulo">
                <h1>Detalhes do Relatório</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <!-- Container de conteúdo -->
        <div class="conteudo-container">
            <!-- Resumo -->
            <div class="info-section">
                <h3>Resumo</h3>
                <div class="info-content">
                    <p>${relatorio.resumo}</p>
                </div>
            </div>

            <!-- Observações -->
            <div class="info-section">
                <h3>Observações</h3>
                <div class="info-content">
                    <c:choose>
                        <c:when test="${not empty relatorio.observacoes}">
                            <p>${relatorio.observacoes}</p>
                        </c:when>
                        <c:otherwise>
                            <p>Nenhuma observação registrada</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Avaliações -->
        <div class="conteudo-container">
            <div class="info-section">
                <h3>Avaliações</h3>

                <button class="botao-adicionar"
                        onclick="window.location.href='${pageContext.request.contextPath}/avaliacao?acao=criar&relatorioId=${relatorio.id}'">
                    + Adicionar Avaliação
                </button>

                <c:if test="${not empty relatorio.avaliacoes}">
                    <div class="avaliacoes-container">
                        <c:forEach items="${relatorio.avaliacoes}" var="avaliacao" varStatus="loop">
                            <div class="avaliacao-item">
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
        </div>

        <!-- Botão Voltar -->
        <div class="linha-superior">
            <button class="botao-voltar"
                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios?alunoMatricula=${relatorio.aluno.matricula}'">
                Voltar
            </button>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>
</body>
</html>