<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Novo Relatório</title>
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

        /* ======================== FORMULÁRIO ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .form-plano {
            display: grid;
            gap: 25px;
        }

        .grupo-campos {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
        }

        .campo {
            display: flex;
            flex-direction: column;
            margin-bottom: 18px;
        }

        .campo label {
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 15px;
            color: #555;
        }

        .campo input,
        .campo textarea,
        .campo select {
            padding: 12px 16px;
            font-size: 15px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #fafafa;
            transition: all 0.3s ease;
        }

        .campo input:focus,
        .campo textarea:focus,
        .campo select:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .campo textarea {
            height: 120px;
            resize: vertical;
        }

        .info-aluno {
            grid-column: span 2;
            background-color: #f0f4ff;
            border-radius: 12px;
            padding: 20px;
            border-left: 4px solid #4D44B5;
            margin-bottom: 15px;
        }

        .info-aluno p {
            font-weight: 600;
            color: #4D44B5;
        }

        .professor-info {
            display: none;
            margin-top: 10px;
            padding: 15px;
            background-color: #f0f4ff;
            border-radius: 12px;
            border-left: 3px solid #4D44B5;
        }

        .professor-info p {
            font-weight: 500;
            color: #555;
        }

        /* ======================== BOTÕES ======================== */
        .botoes-acoes {
            margin-top: 20px;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            width: 100%;
        }

        .botao-salvar {
            background-color: #4D44B5;
            color: white;
            padding: 12px 25px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        }

        .botao-salvar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .botao-cancelar {
            background-color: #e0e0e0;
            color: #333;
            padding: 12px 25px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .botao-cancelar:hover {
            background-color: #d0d0d0;
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

            .grupo-campos {
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
                <h1>Criar Novo Relatório</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <div class="conteudo-container">
            <form id="formNovoRelatorio" class="form-plano" action="${pageContext.request.contextPath}/relatorios/criar" method="POST">
                <input type="hidden" name="acao" value="criar">

                <!-- Aluno pré-selecionado -->
                <c:if test="${not empty aluno}">
                    <input type="hidden" name="alunoMatricula" value="${aluno.matricula}">
                    <div class="info-aluno">
                        <label>Aluno:</label>
                        <p><strong>${aluno.nome}</strong> (${aluno.matricula})</p>
                    </div>
                </c:if>

                <div class="grupo-campos">
                    <!-- Professor -->
                    <div class="campo">
                        <label for="professorSiape">SIAPE do Professor:</label>
                        <input type="text" id="professorSiape" name="professorSiape" required
                               placeholder="Digite o SIAPE do professor">
                        <div class="professor-info" id="professorInfo">
                            <label>Professor:</label>
                            <p id="professorNome"></p>
                        </div>
                    </div>
                </div>

                <div class="grupo-campos">
                    <!-- Título -->
                    <div class="campo">
                        <label for="tituloRelatorio">Título do Relatório:</label>
                        <input type="text" id="tituloRelatorio" name="titulo" required>
                    </div>

                    <!-- Data -->
                    <div class="campo">
                        <label for="dataGeracao">Data do Relatório:</label>
                        <input type="date" id="dataGeracao" name="dataGeracao" required>
                    </div>
                </div>

                <!-- Campos de texto -->
                <div class="campo">
                    <label for="resumo">Resumo:</label>
                    <textarea id="resumo" name="resumo" required></textarea>
                </div>

                <div class="campo">
                    <label for="observacoes">Observações:</label>
                    <textarea id="observacoes" name="observacoes"></textarea>
                </div>

                <!-- Botões -->
                <div class="botoes-acoes">
                    <button type="submit" class="botao-salvar">Salvar</button>
                    <button type="button" class="botao-cancelar"
                        onclick="window.location.href='${pageContext.request.contextPath}/relatorios${aluno != null && aluno.matricula != null ? '?alunoMatricula=' += aluno.matricula : ''}'">
                        Voltar
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
        // Busca automática do professor ao digitar o SIAPE
        document.getElementById('professorSiape').addEventListener('blur', function() {
            const siape = this.value.trim();
            if (!siape) return;

            fetch('${pageContext.request.contextPath}/buscarProfessor?siape=' + siape)
                .then(response => response.json())
                .then(professor => {
                    const infoDiv = document.getElementById('professorInfo');
                    const nomeSpan = document.getElementById('professorNome');

                    if (professor && professor.nome) {
                        nomeSpan.textContent = professor.nome;
                        infoDiv.style.display = 'block';
                    } else {
                        nomeSpan.textContent = '';
                        infoDiv.style.display = 'none';
                        alert('Professor não encontrado com este SIAPE');
                    }
                })
                .catch(error => {
                    console.error('Erro ao buscar professor:', error);
                });
        });

        // Define a data atual como padrão
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('dataGeracao').value = today;
        });
    </script>
</body>
</html>