<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professores do Aluno</title>
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

        /* ======================== CONTEÚDO ESPECÍFICO DA PÁGINA ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-top: 20px;
        }

        .header-aluno {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #f5f5f5;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
        }

        .info-aluno {
            font-size: 18px;
            color: #4D44B5;
        }

        .info-aluno span {
            font-weight: 700;
            color: #2c3e50;
        }

        .botao-novo-professor {
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

        .botao-novo-professor:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        /* ======================== TABELA ======================== */
        .tabela-professores {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .tabela-professores th {
            background-color: #4D44B5;
            color: white;
            text-align: left;
            padding: 16px 20px;
            font-weight: 600;
        }

        .tabela-professores td {
            background-color: #fff;
            padding: 14px 20px;
            border-bottom: 1px solid #f0f0f0;
        }

        .tabela-professores tr:last-child td {
            border-bottom: none;
        }

        .tabela-professores tr:hover td {
            background-color: #f9f9ff;
        }

        .container-acoes {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .botao-acao {
            padding: 8px 16px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 14px;
            font-weight: 600;
        }

        .botao-excluir {
            background-color: #dc3545;
            color: white;
        }

        .botao-excluir:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(220, 53, 69, 0.3);
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
            width: 500px;
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

        .modal-conteudo p {
            font-size: 18px;
            margin-bottom: 30px;
            color: #555;
            line-height: 1.6;
            text-align: center;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 25px;
        }

        .input-group label {
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 15px;
            color: #555;
        }

        .input-group select {
            padding: 12px 16px;
            font-size: 15px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #fafafa;
            transition: all 0.3s ease;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234D44B5' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
        }

        .input-group select:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .botoes-modal {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        .botoes-modal button[type="submit"] {
            background-color: #4D44B5;
            color: #fff;
            border: none;
            padding: 12px 28px;
            border-radius: 10px;
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
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
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

            .header-aluno {
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

            .container-acoes {
                flex-wrap: wrap;
                justify-content: flex-start;
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
                <h1>Professores do Aluno</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <div class="conteudo-container">
            <div class="header-aluno">
                <div class="info-aluno">
                    Aluno: <span>${aluno.nome}</span> | Matrícula: <span>${aluno.matricula}</span>
                </div>
                <button class="botao-novo-professor" onclick="abrirModal(modais.vincular)">+ Adicionar Professor</button>
            </div>

            <!-- Modal Vincular Professor -->
            <div class="modal-overlay" id="modalVincularProfessor">
                <div class="modal-conteudo">
                    <h3>Vincular Professor</h3>
                    <form id="formVincularProfessor"
                          action="${pageContext.request.contextPath}/templates/aee/professores-aluno?acao=vincular&matricula=${aluno.matricula}"
                          method="POST">
                        <div class="input-group">
                            <label for="professorSelect">Selecione o Professor:</label>
                            <select id="professorSelect" name="siape" required>
                                <option value="">Selecione um professor</option>
                                <c:forEach items="${todosProfessores}" var="prof">
                                    <option value="${prof.siape}">${prof.nome} (${prof.especialidade})</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="botoes-modal">
                            <button type="submit">Vincular</button>
                            <button type="button" onclick="fecharModal(modalVincularProfessor)">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Tabela de Professores Vinculados -->
            <table class="tabela-professores">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>SIAPE</th>
                        <th>Cursos</th>
                        <th>Ações</th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${empty professoresAluno}">
                            <tr>
                                <td colspan="4" style="text-align: center; padding: 30px;">Nenhum professor vinculado</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${professoresAluno}" var="prof">
                                <tr class="linha-principal" data-id="${prof.siape}">
                                    <td>${prof.nome}</td>
                                    <td>${prof.siape}</td>
                                    <td>${prof.especialidade}</td>
                                    <td>
                                        <div class="container-acoes">
                                            <button class="botao-acao botao-excluir"
                                                    onclick="confirmarDesvinculacao('${prof.siape}')">
                                                Remover
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- Modal Confirmação Desvinculação -->
            <div class="modal-overlay" id="modalDesvincular">
                <div class="modal-conteudo">
                    <h3>Confirmar Desvinculação</h3>
                    <p>Tem certeza que deseja remover este professor?</p>
                    <form id="formDesvincularProfessor"
                          action="${pageContext.request.contextPath}/templates/aee/professores-aluno?acao=desvincular&matricula=${aluno.matricula}"
                          method="POST">
                        <input type="hidden" name="siape" id="siapeDesvincular">
                        <div class="botoes-modal">
                            <button type="submit">Confirmar</button>
                            <button type="button" onclick="fecharModal(modalDesvincular)">Cancelar</button>
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
            vincular: document.getElementById('modalVincularProfessor'),
            desvincular: document.getElementById('modalDesvincular')
        };

        function abrirModal(modal) {
            modal.style.display = 'flex';
        }

        function fecharModal(modal) {
            modal.style.display = 'none';
        }

        function confirmarDesvinculacao(siape) {
            document.getElementById('siapeDesvincular').value = siape;
            abrirModal(modais.desvincular);
        }

        // Fechar modais clicando fora do conteúdo
        window.addEventListener('click', function(event) {
            for (const key in modais) {
                if (event.target === modais[key]) {
                    fecharModal(modais[key]);
                }
            }
        });
    </script>
</body>
</html>