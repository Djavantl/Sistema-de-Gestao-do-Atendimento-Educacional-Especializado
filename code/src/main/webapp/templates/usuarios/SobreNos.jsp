<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sobre Nós | Sistema de Gestão do AEE</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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

        /* Cabeçalho */
        .header {
            background: #4D44B5;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo h1 {
            color: white;
            font-size: 28px;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 50px;
            transition: background-color 0.3s;
        }

        .nav-links a:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }

        /* Conteúdo Principal */
        .main-content {
            max-width: 1200px;
            margin: 60px auto;
            padding: 0 20px;
        }

        .page-title {
            color: #4D44B5;
            font-size: 42px;
            margin-bottom: 40px;
            text-align: center;
            font-weight: 800;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .about-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        .about-section h2 {
            color: #4D44B5;
            font-size: 28px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .about-section p {
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

        .tech-stack {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin: 30px 0;
        }

        .tech-item {
            background: #f9f9ff;
            border-radius: 12px;
            padding: 15px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s;
        }

        .tech-item,
        .about-section a {
            text-decoration: none;
            color: inherit;
        }

        .tech-item:hover,
        .about-section a:hover {
            color: #007bff;
        }

        .tech-item i {
            color: #4D44B5;
            font-size: 24px;
        }

        .team-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 40px;
        }

        .team-section h2 {
            color: #4D44B5;
            font-size: 28px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .team-members {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
            margin-top: 30px;
        }

        .team-member {
            background: #f9f9ff;
            border-radius: 20px;
            padding: 25px;
            width: 220px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .member-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #e0e0e0;
            margin: 0 auto 10px;
        }

        .member-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .team-member h3 {
            color: #4D44B5;
            margin-bottom: 5px;
        }

        .team-member h3 a {
            text-decoration: none;
            color: inherit;
        }

        .team-member h3 a:hover {
            color: #007bff;
        }


        .team-member p {
            color: #777;
            font-size: 16px;
        }

        .advisor {
            background: rgba(77, 68, 181, 0.1);
            border-left: 4px solid #4D44B5;
            padding: 20px;
            margin-top: 30px;
            border-radius: 0 12px 12px 0;
        }

        /* Botões de Autenticação */
        .auth-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 40px;
            flex-wrap: wrap;
        }

        .auth-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            width: 300px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .auth-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .auth-card i {
            font-size: 50px;
            color: #4D44B5;
            margin-bottom: 20px;
        }

        .auth-card h3 {
            color: #4D44B5;
            font-size: 24px;
            margin-bottom: 20px;
        }

        .auth-btn {
            display: inline-block;
            background: #4D44B5;
            color: white;
            text-decoration: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            margin-top: 15px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        .auth-btn:hover {
            background: #372e9c;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(77, 68, 181, 0.4);
        }

        .auth-links {
            margin-top: 20px;
            font-size: 16px;
        }

        .auth-links a {
            color: #4D44B5;
            font-weight: 600;
            text-decoration: none;
        }

        .auth-links a:hover {
            text-decoration: underline;
        }

        /* Rodapé */
        .footer {
            text-align: center;
            padding: 30px;
            color: #4D44B5;
            font-size: 14px;
            margin-top: 60px;
            background: rgba(255, 255, 255, 0.8);
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

        /* Responsividade */
        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                padding: 15px;
            }

            .logo {
                margin-bottom: 15px;
            }

            .nav-links {
                width: 100%;
                justify-content: center;
            }

            .team-members {
                flex-direction: column;
                align-items: center;
            }

            .auth-container {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <!-- Círculos decorativos -->
    <div class="decorative-circle circle-1"></div>
    <div class="decorative-circle circle-2"></div>
    <div class="decorative-circle circle-3"></div>

    <!-- Cabeçalho -->
    <header class="header">
        <div class="logo">
            <h1>AEE+</h1>
        </div>
        <nav class="nav-links">
            <a href="#auth-section"><i class="fas fa-sign-in-alt"></i> Login</a>
            <a href="#auth-section"><i class="fas fa-user-plus"></i> Cadastro</a>
        </nav>
    </header>

    <!-- Conteúdo Principal -->
    <main class="main-content">
        <h1 class="page-title">Sobre Nós</h1>

        <section class="about-section">
            <h2><i class="fas fa-book"></i> O Projeto</h2>
            <p>Este repositório contém um sistema para o gerenciamento e monitoramento do <span class="highlight">Atendimento Educacional Especializado (AEE)</span>, com foco no desenvolvimento de cada estudante e na valorização de suas habilidades únicas.</p>
            <br>
            <br>

            <h2><i class="fas fa-question-circle"></i> O que é o AEE?</h2>
            <p>O AEE é uma modalidade de ensino complementar, pensada para oferecer recursos, estratégias e suporte pedagógico individualizado a alunos com deficiência, transtornos globais do desenvolvimento ou altas habilidades/superdotação.</p>
            <p>Seu objetivo é garantir o acesso, a permanência e o progresso desses estudantes no cotidiano escolar, promovendo a inclusão efetiva e o respeito às suas especificidades.</p>

            <p>A plataforma permite que educadores e gestores escolares planejem, acompanhem e documentem todo o processo de AEE de forma simples e eficiente.</p>
            <br>
            <br>

            <h2><i class="fas fa-laptop-code"></i> Tecnologias Utilizadas</h2>
            <div class="tech-stack">
                <a href="https://www.docker.com/" target="_blank" class="tech-item">
                    <i class="fab fa-docker"></i>
                    <span>Docker</span>
                </a>

                <a href="https://docs.docker.com/compose/" target="_blank" class="tech-item">
                    <i class="fas fa-server"></i>
                    <span>Docker Compose</span>
                </a>

                <a href="https://www.mysql.com/" target="_blank" class="tech-item">
                    <i class="fas fa-database"></i>
                    <span>MySQL 8</span>
                </a>

                <a href="https://flywaydb.org/" target="_blank" class="tech-item">
                    <i class="fas fa-plane"></i>
                    <span>Flyway</span>
                </a>

                <a href="https://docs.oracle.com/en/java/javase/17/" target="_blank" class="tech-item">
                    <i class="fab fa-java"></i>
                    <span>Java 17</span>
                </a>
            </div>

            <p><strong>Repositório completo no GitHub:</strong>
                <a href="https://github.com/Djavantl/Sistema-de-Gestao-do-Atendimento-Educacional-Especializado.git" target="_blank">
                    https://github.com/Djavantl/Sistema-de-Gestao-do-Atendimento-Educacional-Especializado.git
                </a>
            </p>

        </section>

        <section class="team-section">
            <h2><i class="fas fa-users"></i> Equipe de Desenvolvimento</h2>
            <p>Projeto realizado como atividade avaliativa da disciplina <span class="highlight">Linguagem de Programação Orientada a Objetos</span>.</p>

            <div class="team-members">
                <div class="team-member">
                    <div class="member-avatar">
                        <img src="${pageContext.request.contextPath}/static/images/avatar/aparecida.jpg" alt="Aparecida">
                    </div>
                    <h3>
                        <a href="https://github.com/ajoxxavier" target="_blank">Aparecida Jaine de Oliveira Xavier</a>
                    </h3>
                    <p>Desenvolvedora<br>Full Stack</p>
                </div>

                <div class="team-member">
                    <div class="member-avatar">
                        <img src="${pageContext.request.contextPath}/static/images/avatar/djavan.jpeg" alt="Djavan Teixeira Lopes">
                    </div>
                    <h3>
                        <a href="https://github.com/Djavantl" target="_blank">Djavan Teixeira Lopes</a>
                    </h3>
                    <p>Desenvolvedor<br>Full Stack</p>
                </div>

                <div class="team-member">
                    <div class="member-avatar">
                        <img src="${pageContext.request.contextPath}/static/images/avatar/gabriel.jpeg" alt="Gabriel Rocha Gomes">
                    </div>
                    <h3>
                        <a href="https://github.com/Rocha0919" target="_blank">Gabriel Rocha Gomes</a>
                    </h3>
                    <p>Desenvolvedor<br>Full Stack</p>
                </div>

                <div class="team-member">
                    <div class="member-avatar">
                        <img src="${pageContext.request.contextPath}/static/images/avatar/marley.jpeg" alt="Marley Teixeira Meira">
                    </div>
                    <h3>
                        <a href="https://github.com/Mxrlrey" target="_blank">Marley Teixeira Meira</a>
                    </h3>
                    <p>Desenvolvedor<br>Full Stack</p>
                </div>

                <div class="team-member">
                    <div class="member-avatar">
                        <img src="${pageContext.request.contextPath}/static/images/avatar/pabloo.jpeg" alt="Pablo Henrique Azevedo">
                    </div>
                    <h3>
                        <a href="https://github.com/Little-hair77" target="_blank">Pablo Henrique Azevedo</a>
                    </h3>
                    <p>Desenvolvedor<br>Full Stack</p>
                </div>

                <div class="team-member">
                    <div class="member-avatar">
                        <img src="${pageContext.request.contextPath}/static/images/avatar/woquiton.png" alt="Woquiton Lima Fernandes">
                    </div>
                    <h3>
                        <a href="https://github.com/Woquiton" target="_blank">Woquiton Lima Fernandes</a>
                    </h3>
                    <p>Professor<br>Orientador do Projeto</p>
                </div>
            </div>


        </section>

        <section id="auth-section" class="auth-container">
            <div class="auth-card">
                <i class="fas fa-user-plus"></i>
                <h3>Criar Conta</h3>
                <p>Cadastre-se para acessar todas as funcionalidades do sistema de gestão do AEE.</p>
                <a href="/templates/usuarios/cadastro.jsp" class="auth-btn">Cadastre-se</a>
                <div class="auth-links">
                    Já tem uma conta? <a href="/templates/usuarios/login.jsp">Faça login</a>
                </div>
            </div>

            <div class="auth-card">
                <i class="fas fa-sign-in-alt"></i>
                <h3>Acessar Sistema</h3>
                <p>Faça login para gerenciar alunos, planos educacionais e acompanhar o progresso.</p>
                <a href="/templates/usuarios/login.jsp" class="auth-btn">Login</a>
                <div class="auth-links">
                    Não tem uma conta? <a href="/templates/usuarios/cadastro.jsp">Cadastre-se</a>
                </div>
            </div>
        </section>
    </main>

    <!-- Rodapé -->
    <footer class="footer">
        <p>© 2025 AEE+ Sistema de Gestão do Atendimento Educacional Especializado. Licenciado sob MIT.</p>
    </footer>
</body>
</html>