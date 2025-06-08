<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Nova Sessão</title>
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
        .botoes-modal button {
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

        /* Botões de ação SEM ícones (como solicitado) */
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

        /* ======================== FORMULÁRIO DE CRIAÇÃO ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-top: 20px;
        }

        .formulario-titulo {
            text-align: center;
            margin-bottom: 30px;
        }

        .formulario-titulo h2 {
            color: #4D44B5;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .formulario-titulo p {
            color: #666;
            font-size: 18px;
            max-width: 600px;
            margin: 0 auto;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            max-width: 800px;
            margin: 0 auto;
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
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .input-group label i {
            color: #4D44B5;
        }

        .input-group input,
        .input-group select,
        .input-group textarea {
            padding: 14px 18px;
            font-size: 16px;
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
            background-color: #fff;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        .botoes-formulario {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-top: 40px;
        }

        .botoes-formulario button {
            border: none;
            padding: 14px 35px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .botao-salvar {
            background-color: #4D44B5;
            color: #fff;
        }

        .botao-salvar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(77, 68, 181, 0.3);
        }

        .botao-cancelar {
            background-color: #e0e0e0;
            color: #333;
        }

        .botao-cancelar:hover {
            background-color: #cfcfcf;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
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

            .form-grid {
                grid-template-columns: 1fr;
            }

            .botoes-formulario {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- Elementos decorativos -->
    <div class="decorative-circle circle-1"></div>
    <div class="decorative-circle circle-2"></div>
    <div class="decorative-circle circle-3"></div>

    <!-- Sidebar - Idêntico à página de criação de aluno -->
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
            <button class="menu-btn ativo"
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
                <h1>Criar Nova Sessão</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <div class="conteudo-container">


            <form id="formNovaSessao" action="${pageContext.request.contextPath}/templates/aee/sessoes?acao=criar" method="POST">
                <div class="form-grid">
                    <div class="input-group">
                        <label for="aluno"><i class="fas fa-user-graduate"></i> Aluno:</label>
                        <select name="aluno_matricula" id="aluno" required>
                            <option value="" disabled selected>Selecione um aluno</option>
                            <c:forEach items="${todosAlunos}" var="aluno">
                                <option value="${aluno.matricula}">${aluno.nome}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="input-group">
                        <label for="data"><i class="fas fa-calendar-day"></i> Data:</label>
                        <input type="date" id="data" name="data" required>
                    </div>

                    <div class="input-group">
                        <label for="horario"><i class="fas fa-clock"></i> Horário:</label>
                        <input type="time" id="horario" name="horario" required>
                    </div>

                    <div class="input-group">
                        <label for="local"><i class="fas fa-map-marker-alt"></i> Local:</label>
                        <input type="text" id="local" name="local" placeholder="Ex: Sala de AEE" required>
                    </div>

                    <div class="input-group full-width">
                        <label for="observacoes"><i class="fas fa-sticky-note"></i> Observações:</label>
                        <textarea id="observacoes" name="observacoes" rows="4" placeholder="Descreva os objetivos ou pontos importantes desta sessão..."></textarea>
                    </div>
                </div>

                <div class="botoes-formulario">
                    <button type="submit" class="botao-salvar">
                         Salvar Sessão
                    </button>
                    <button type="button" class="botao-cancelar" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">
                         Cancelar
                    </button>
                </div>
            </form>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>

    <script>
        // Configuração da data mínima para hoje
        document.getElementById('data').min = new Date().toISOString().split('T')[0];

        // Validação do formulário
        document.getElementById('formNovaSessao').addEventListener('submit', function(e) {
            const aluno = document.getElementById('aluno').value;
            const data = document.getElementById('data').value;
            const horario = document.getElementById('horario').value;
            const local = document.getElementById('local').value;

            if (!aluno || !data || !horario || !local) {
                e.preventDefault();
                alert('Por favor, preencha todos os campos obrigatórios.');
                return false;
            }
            return true;
        });
    </script>
</body>
</html>