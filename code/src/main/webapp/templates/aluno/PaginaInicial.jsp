<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bem-vindo ao AEE+ | Seu Espaço de Aprendizado</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Body Background (mantido do primeiro layout) */
        body {

            background-color: #E6E6FA;
            color: #333;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* ---------------------------------------------
           Sidebar (estilos reaproveitados da segunda página)
           --------------------------------------------- */
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

        /* ---------------------------------------------
           Conteúdo Principal (mantido do primeiro layout)
           --------------------------------------------- */
        .conteudo-principal {
            margin-left: 280px; /* deixa espaço para sidebar */
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
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
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

        .user-info .matricula {
            font-size: 16px;
            color: #777;
            font-weight: 500;
        }

        /* Cards de Conteúdo */
        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        }

        .card-icon {
            width: 70px;
            height: 70px;
            background: #4D44B5;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }

        .card-icon img {
            width: 40px;
            height: 40px;
            filter: invert(1);
        }

        .card h3 {
            color: #4D44B5;
            font-size: 24px;
            margin-bottom: 15px;
        }

        .card p {
            color: #555;
            line-height: 1.6;
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .card-btn {
            background: #4D44B5;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            margin-top: auto;
            width: fit-content;
        }

        .card-btn:hover {
            background: #372e9c;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(77, 68, 181, 0.4);
        }

        /* Mensagem de Boas-vindas */
        .welcome-message {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }


        .welcome-message h2 {
            color: #4D44B5;
            font-size: 28px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .welcome-message p {
            color: #555;
            line-height: 1.8;
            font-size: 18px;
            margin-bottom: 15px;
        }

        .highlight {
            background: linear-gradient(120deg, #FFD700 0%, #FFD700 100%);
            background-repeat: no-repeat;
            background-size: 100% 40%;
            background-position: 0 85%;
            padding: 0 5px;
            font-weight: 600;
        }

        /* Elementos Decorativos */
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

        /* Rodapé */
        .footer {
            text-align: center;
            padding: 30px;
            color: #4D44B5;
            font-size: 14px;
            margin-top: auto;
        }



        /* Responsividade */
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
        }
    </style>
</head>
<body>
    <!-- Elementos decorativos -->
    <div class="decorative-circle circle-1"></div>
    <div class="decorative-circle circle-2"></div>
    <div class="decorative-circle circle-3"></div>

    <!-- Sidebar (modelo da segunda página, com ícones do primeiro) -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logoAEE.png" alt="Logo AEE+" />
            <h2>AEE +</h2>
        </div>

        <!-- INPUT HIDDEN PARA MATRÍCULA -->
        <input type="hidden" id="matriculaHidden" value="${matricula}" />

        <div class="menu">
            <button class="menu-btn ativo"
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
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/meus-relatorios?matricula=${matricula}'">
                Meus Relatórios
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal (mantido do primeiro layout) -->
    <div class="conteudo-principal">
        <div class="header">
            <div class="titulo">
                <h1>Atendimento Educacional Especializado<br></h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo, Aluno!</p>
                <div class="matricula">${nome}</div>
            </div>
        </div>

        <!-- Mensagem de Boas-vindas -->
        <div class="welcome-message">
            <h2>🌟 Olá, Estudante!</h2>
            <p>Estamos muito felizes em tê-lo(a) aqui no seu espaço de aprendizado personalizado. Este é o lugar onde você encontra todo o suporte necessário para sua jornada educacional.</p>
            <p>O Atendimento Educacional Especializado (AEE) é pensado especialmente para <span class="highlight">valorizar suas habilidades únicas</span> e oferecer o apoio necessário para seu desenvolvimento.</p>
            <p>Navegue pelas opções ao lado para acessar seus recursos educacionais, informações pessoais, plano de estudos e muito mais!</p>
        </div>

        <!-- Cards de Conteúdo -->
        <div class="cards-container">
            <div class="card">
                <div class="card-icon">
                    <img src="${pageContext.request.contextPath}/static/images/informacoes.svg" alt="Informações">
                </div>
                <h3>Minhas Informações</h3>
                <p>Visualize  seus dados pessoais, e informações de contato. Mantenha tudo atualizado com seu Professor AEE para receber o melhor suporte.</p>
                <button class="card-btn"
                        onclick="window.location.href='${pageContext.request.contextPath}/templates/aluno/minhas-informacoes?matricula=' + document.getElementById('matriculaHidden').value">
                    Acessar <i>→</i>
                </button>
            </div>

            <div class="card">
                <div class="card-icon">
                    <img src="${pageContext.request.contextPath}/static/images/atendimento.svg" alt="Organização">
                </div>
                <h3>Minha Organização</h3>
                <p>Consulte seu cronograma de atendimento. Tudo organizado para otimizar seu aprendizado.</p>
                <button class="card-btn"
                        onclick="window.location.href='${pageContext.request.contextPath}/MinhaOrganizacao?matricula=' + document.getElementById('matriculaHidden').value">
                    Ver Detalhes <i>→</i>
                </button>
            </div>

            <div class="card">
                <div class="card-icon">
                    <img src="${pageContext.request.contextPath}/static/images/meuplano.svg" alt="Plano">
                </div>
                <h3>Meu Plano AEE</h3>
                <p>Acesse seu plano educacional personalizado, com objetivos, estratégias e recursos específicos para potencializar sua aprendizagem.</p>
                <button class="card-btn"
                        onclick="window.location.href='${pageContext.request.contextPath}/meu-plano?matricula=' + document.getElementById('matriculaHidden').value">
                    Ver Plano <i>→</i>
                </button>
            </div>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p id= "fo">© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p id= "fo1">Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>

    <!-- Script para efeito de digitação no título -->
    <script>
        const titulo = document.querySelector('.titulo h1 span');
        const textoOriginal = titulo.textContent;
        titulo.textContent = '';

        let i = 0;
        const velocidadeDigitacao = 100;

        function digitar() {
            if (i < textoOriginal.length) {
                titulo.textContent += textoOriginal.charAt(i);
                i++;
                setTimeout(digitar, velocidadeDigitacao);
            }
        }

        setTimeout(digitar, 800);
    </script>
</body>
</html>
