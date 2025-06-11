<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bem-vindo ao AEE+ | Painel do Professor</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Body Background */
        body {
            background-color: #E6E6FA;
            color: #333;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* ---------------------------------------------
           Sidebar
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

        .menu-btn img {
            width: 24px;
            height: 24px;
            filter: brightness(0) invert(1); /* Garante ícones brancos */
        }

        .menu-btn.ativo img {
            filter: invert(26%) sepia(33%) saturate(3500%) hue-rotate(261deg) brightness(86%) contrast(85%);
        }
       .logout-btn {
           margin-top: auto; /* Empurra para o final da sidebar */
           background-color: transparent !important; /* Mantém o fundo normal */
           color: #ffffff !important; /* Mantém o texto branco */
       }

       .logout-btn:hover {
           background-color: #ff6b6b !important; /* Vermelho no hover */
           color: #ffffff !important; /* Texto branco no hover */
       }

       .logout-btn img {
           filter: brightness(0) invert(1); /* Ícone branco sempre */
       }
        /* ---------------------------------------------
           Conteúdo Principal
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

        .user-info .funcao {
            font-size: 16px;
            color: #777;
            font-weight: 500;
        }

        /* Cards de Conteúdo */
        .cards-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 3 colunas na primeira fileira */
            gap: 30px;
            margin-top: 20px;
        }

        /* Container para segunda fileira */
        .second-row {
            grid-column: 1 / -1;
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 0;
        }

        .second-row .card {
            width: calc(33.333% - 15px); /* Mantém mesma largura dos cards de cima */
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
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
            filter: brightness(0) invert(1);
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
        @media (max-width: 1200px) {
            .cards-container {
                grid-template-columns: repeat(2, 1fr); /* 2 colunas em telas médias */
            }

            .second-row {
                flex-wrap: wrap;
            }

            .second-row .card {
                width: calc(50% - 15px);
            }
        }

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

            .cards-container {
                grid-template-columns: 1fr; /* 1 coluna em telas pequenas */
            }

            .second-row {
                flex-direction: column;
            }

            .second-row .card {
                width: 100%;
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
            <button class="menu-btn ativo"
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
            <button class="menu-btn logout-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/Logout.svg" alt="Sair" />
                Sair
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div class="header">
            <div class="titulo">
                <h1>Painel de Controle do Professor AEE<br></h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <!-- Mensagem de Boas-vindas -->
        <div class="welcome-message">
            <h2>🌟 Olá, Professor(a)!</h2>
            <p>Estamos felizes em tê-lo(a) aqui no seu espaço de gestão educacional especializada. Este é o lugar onde você gerencia todo o ecossistema de suporte para seus estudantes.</p>
            <p>O Atendimento Educacional Especializado (AEE) é uma ferramenta poderosa para <span class="highlight">potencializar o desenvolvimento</span> de cada estudante, valorizando suas habilidades únicas.</p>
            <p>Utilize este painel para gerenciar estudantes, acompanhar sessões, criar planos educacionais personalizados e gerar relatórios detalhados sobre o progresso dos alunos.</p>
        </div>

        <!-- Cards de Conteúdo -->
        <div class="cards-container">
            <!-- Primeira fileira com 3 cards -->
            <div class="card">
                <div class="card-icon">
                    <img src="${pageContext.request.contextPath}/static/images/aluno.svg" alt="Estudantes">
                </div>
                <h3>Gestão de Estudantes</h3>
                <p>Acompanhe e gerencie informações importantes sobre os estudantes atendidos no programa AEE.</p>
                <button class="card-btn"
                        onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/alunos'">
                    Gerenciar <i>→</i>
                </button>
            </div>
            <div class="card">
                <div class="card-icon">
                    <img src="${pageContext.request.contextPath}/static/images/sessoes.svg" alt="Sessões">
                </div>
                <h3>Sessões de Atendimento</h3>
                <p>Organize e registre as sessões realizadas, garantindo a qualidade e o acompanhamento contínuo.</p>
                <button class="card-btn"
                        onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">
                    Gerenciar <i>→</i>
                </button>
            </div>
            <div class="card">
                <div class="card-icon">
                    <img src="${pageContext.request.contextPath}/static/images/professor.svg" alt="Professor">
                </div>
                <h3>Vínculo de Professores</h3>
                <p>Vincule os professores com seus estudantes atendidos no programa AEE.</p>
            </div>

            <!-- Segunda fileira com 2 cards centralizados -->
            <div class="second-row">
                <div class="card">
                    <div class="card-icon">
                        <img src="${pageContext.request.contextPath}/static/images/meuplano.svg" alt="Planos">
                    </div>
                    <h3>Planos AEE</h3>
                    <p>Gerencie os planos personalizados de atendimento educacional especializado para cada estudante.</p>
                    <button class="card-btn"
                            onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/planosAEE'">
                        Gerenciar <i>→</i>
                    </button>
                </div>

                <div class="card">
                    <div class="card-icon">
                        <img src="${pageContext.request.contextPath}/static/images/sidebar/relatorios.svg" alt="Relatórios">
                    </div>
                    <h3>Relatórios</h3>
                    <p>Visualize e acompanhe relatórios detalhados sobre o progresso dos estudantes.</p>
                    <button class="card-btn"
                            onclick="window.location.href='${pageContext.request.contextPath}/relatorios/todos'">
                        Relatorios <i>→</i>
                    </button>
                </div>
            </div>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>
</body>
</html>