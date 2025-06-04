<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${meta != null ? 'Editar Meta' : 'Adicionar Nova Meta'}</title>
    <style>
        /* RESET E BASE */
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

        /* SIDEBAR */
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

        /* CONTEÚDO PRINCIPAL */
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

        /* FORMULÁRIO */
        .info-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .info-section h2 {
            color: #4D44B5;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            color: #4D44B5;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 16px;
            background-color: #f9f9ff;
            transition: all 0.3s ease;
            outline: none;
        }

        .form-group textarea {
            min-height: 150px;
            resize: vertical;
        }

        .form-group textarea:focus,
        .form-group select:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
        }

        .botoes-form {
            display: flex;
            gap: 10px;
            margin-top: 30px;
            justify-content: flex-end;
        }

        .btn-submit,
        .btn-cancelar {
            padding: 10px 20px;
            font-size: 14px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
        }

        .btn-submit {
            background-color: #4D44B5;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btn-submit:hover {
            background-color: #372e9c;
        }

        .btn-cancelar {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
        }

        .btn-cancelar:hover {
            background-color: #5a6268;
        }

        /* ELEMENTOS DECORATIVOS */
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

        /* RODAPÉ */
        .footer {
            text-align: center;
            padding: 30px;
            color: #4D44B5;
            font-size: 14px;
            margin-top: auto;
        }

        /* RESPONSIVIDADE */
        @media (max-width: 992px) {
            .sidebar {
                width: 220px;
            }

            .conteudo-principal {
                margin-left: 220px;
                padding: 30px;
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

            .botoes-form {
                flex-direction: column;
                align-items: stretch;
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
            <button class="menu-btn ativo"
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
            <button class="menu-btn"
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
                <h1>${meta != null ? 'Editar Meta' : 'Adicionar Nova Meta'}</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <!-- Formulário de Meta -->
        <div class="info-section">
            <h2>${meta != null ? 'Editar Meta' : 'Adicionar Nova Meta'}</h2>

            <form action="${pageContext.request.contextPath}/templates/aee/metas/salvar" method="post">
                <input type="hidden" name="planoId" value="${planoId}">
                <c:if test="${meta != null}">
                    <input type="hidden" name="metaId" value="${meta.id}">
                </c:if>

                <div class="form-group">
                    <label for="descricao">Descrição:</label>
                    <textarea id="descricao" name="descricao" required>${meta != null ? meta.descricao : ''}</textarea>
                </div>

                <div class="form-group">
                    <label for="status">Status:</label>
                    <select id="status" name="status">
                        <option value="Pendente" ${meta != null && meta.status == 'Pendente' ? 'selected' : ''}>Pendente</option>
                        <option value="Em Andamento" ${meta != null && meta.status == 'Em Andamento' ? 'selected' : ''}>Em Andamento</option>
                        <option value="Concluído" ${meta != null && meta.status == 'Concluído' ? 'selected' : ''}>Concluído</option>
                    </select>
                </div>

                <div class="botoes-form">
                    <button type="submit" class="btn-submit">Salvar</button>
                    <a href="${pageContext.request.contextPath}/templates/aee/detalhes-plano?id=${planoId}" class="btn-cancelar">Cancelar</a>
                </div>
            </form>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>
</body>
</html>
