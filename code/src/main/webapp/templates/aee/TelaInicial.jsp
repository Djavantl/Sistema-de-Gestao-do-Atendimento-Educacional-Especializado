<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet" />

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #1E1E2F, #0F0F1A);
            display: flex;
            height: 100vh;
            overflow: hidden;
            color: #fff;
        }

        .sidebar {
            width: 250px;
            background: linear-gradient(180deg, #1E1E2F, #0F0F1A);
            padding: 30px 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            box-shadow: 0 8px 32px rgba(0,0,0,0.6);
            border-right: 1px solid rgba(255,255,255,0.1);
        }

        .logo {
            text-align: center;
            margin-bottom: 50px;
        }

        .logo img {
            width: 80px;
            margin-bottom: 10px;
            filter: drop-shadow(0 2px 5px rgba(0,0,0,0.5));
        }

        .menu {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .menu-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 20px;
            background: linear-gradient(135deg, #242533, #42404f);
            border: none;
            border-radius: 8px;
            color: #fff;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0,0,0,0.3);
            text-align: left;
        }

        .menu-btn img {
            width: 20px;
            height: 20px;
        }

        .menu-btn:hover {
            background: linear-gradient(135deg, #7E74FF, #6457FF);
            transform: translateY(-2px);
            box-shadow: 0 6px 10px rgba(0,0,0,0.4);
        }

        .menu-btn.ativo {
            background: linear-gradient(135deg, #9D8CFF, #7A6FFF);
            color: #fff;
        }

        .content {
            flex: 1;
            padding: 50px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .content h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: #fff;
            background: linear-gradient(90deg, #6C63FF, #5145CD);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .sobre-aee {
            background: rgba(30, 30, 47, 0.9);
            border-radius: 16px;
            padding: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            margin-bottom: 20px;
        }

        .sobre-aee h2 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            border-bottom: 1px solid rgba(255,255,255,0.2);
            padding-bottom: 8px;
            color: #fff;
        }

        .sobre-aee p {
            color: #ccc;
            line-height: 1.6;
            font-size: 0.95rem;
        }

        .content-layout {
            display: flex;
            flex-direction: column; /* empilha os cards verticalmente */
            align-items: flex-start; /* alinha os cards à esquerda */
            gap: 30px;
            margin-top: 0; /* já tem margem no .content, pode ser 0 aqui */

            position: relative;
            border-radius: 12px;
            padding: 0;
            box-shadow: none;
            min-height: auto;
            background: none;
        }

        /* Oculta a seção de imagem, já que não queremos ela ao lado */
        .image-section {
            display: none;
        }

        .main-content {
            flex: 1 1 100%;
            display: flex;
            flex-direction: column;
            gap: 20px;
            width: 100%; /* ocupa a largura completa */
        }

        .card {
            background: rgba(30, 30, 47, 0.9);
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.4);
        }

        .card h2 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #fff;
            border-bottom: 1px solid rgba(255,255,255,0.2);
            padding-bottom: 10px;
        }

        .card p {
            color: #ccc;
            line-height: 1.6;
        }
    </style>
</head>

<body>
    <div class="sidebar">
        <div>
            <div class="logo">
                <img src="${pageContext.request.contextPath}/static/images/logo1.svg" alt="Logo" />
            </div>
            <div class="menu">
                <button class="menu-btn ativo" onclick="window.location.href='/templates/aee/TelaInicial.jsp'">
                    <img src="${pageContext.request.contextPath}/static/images/inicio.svg" alt="Início" />
                    Início
                </button>
                <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">
                    <img src="${pageContext.request.contextPath}/static/images/aluno.svg" alt="Estudantes" />
                    Estudantes
                </button>
                <button class="menu-btn" onclick="window.location.href='/templates/aee/professores'">
                    <img src="${pageContext.request.contextPath}/static/images/professor.svg" alt="Professores" />
                    Professores
                </button>
                <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">
                    <img src="${pageContext.request.contextPath}/static/images/sessoes.svg" alt="Sessões" />
                    Sessões
                </button>
                <button class="menu-btn" onclick="window.location.href='/templates/aee/planosAEE'">
                    <img src="${pageContext.request.contextPath}/static/images/planoaee.svg" alt="Planos AEE" />
                    Planos AEE
                </button>
                <button class="menu-btn" onclick="window.location.href='/templates/aee/relatorios'">
                    <img src="${pageContext.request.contextPath}/static/images/relatorios.svg" alt="Relatórios" />
                    Relatórios
                </button>
            </div>
        </div>
    </div>

    <div class="content">
        <h1>Bem-vindo ao AEE+</h1>

        <div class="sobre-aee">
            <h2>Sobre o AEE+</h2>
            <p>O Sistema de Gestão do Atendimento Educacional Especializado (AEE+) foi criado para facilitar o acompanhamento
                e a organização dos processos relacionados ao atendimento de alunos com necessidades educacionais específicas.
                Com uma interface intuitiva, o sistema permite gerenciar estudantes, professores, sessões, planos personalizados
                e relatórios, garantindo uma abordagem inclusiva, eficiente e centrada no desenvolvimento individual de cada aluno.
                Dessa forma, o AEE+ contribui para uma educação mais acessível e de qualidade para todos.</p>
        </div>

        <div class="content-layout">
            <div class="image-section">
                <!-- oculto -->
            </div>

            <div class="main-content">
                <div class="card">
                    <h2>Gestão de Estudantes</h2>
                    <p>Acompanhe e gerencie informações importantes sobre os estudantes atendidos no programa AEE.</p>
                </div>

                <div class="card">
                    <h2>Gestão de Professores</h2>
                    <p>Cadastre e mantenha atualizado o quadro de professores responsáveis pelo atendimento especializado.</p>
                </div>

                <div class="card">
                    <h2>Sessões de Atendimento</h2>
                    <p>Organize e registre as sessões realizadas, garantindo a qualidade e o acompanhamento contínuo.</p>
                </div>

                <div class="card">
                    <h2>Planos AEE</h2>
                    <p>Gerencie os planos personalizados de atendimento educacional especializado, assegurando que cada estudante receba o suporte necessário para seu desenvolvimento.</p>
                </div>

                <div class="card">
                    <h2>Relatórios</h2>
                    <p>Crie, visualize e acompanhe relatórios detalhados sobre o progresso dos estudantes e a eficácia das intervenções realizadas no programa AEE.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
