<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TelaInicial</title>
    <link rel="stylesheet" href="telaInicial.css">
    <style>
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
            z-index: 100;
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

        html, body {
            width: 100%;
            height: 100%;
            margin: 0;
            padding: 0;
            background: linear-gradient(to right, #4D44B5 0%, #4D44B5 20%, #2E2691 100%, #1F196F 75%);
        }

        .footer {
            width: 100%;
            height: 120vh;
            position: absolute;
            bottom: 0;
            left: 0;
            background-color: #ffffff;
            clip-path: path('M0 700 C320 600 480 800 640 700 C800 600 960 800 1120 700 C1280 600 1440 800 1600 700 C1760 600 1920 800 1920 700 L1920 1080 L0 1080 Z');
        }

        .titulo {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 50;
        }

        .titulo h1 {
            font-family: 'Poppins', sans-serif;
            color: white;
            font-size: 30px;
            margin: 0;
        }

        .titulo {
            margin-top: 40px;
            margin-left: 750px;
        }

        .imagem {
            position: fixed;
            top: 200px;
            right: 20px;
            z-index: 9999;
            width: 550px;
            height: auto;
        }

        .imagem img {
            width: 100%;
            height: auto;
            object-fit: contain;
        }

        .exp {
            padding: 20px;
            margin: 20px auto;
            width: 300px;
            height: 350px;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 1rem;
            color: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            overflow-y: auto;
            text-align: justify;
            margin-top: 50px;
            margin-left: 500px;
        }

        .exp::before {
            content: "ℹ️ ";
            font-size: 1.2rem;
            display: inline-block;
            margin-right: 4px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/Group 167.svg" alt="Logo" />
            <h2>AEE +</h2>
        </div>

        <!-- INPUT HIDDEN PARA MATRICULA -->
        <input type="hidden" id="matriculaHidden" value="${matricula}" />

        <div class="menu">
            <button class="menu-btn ativo">Início</button>
            <button class="menu-btn">Minhas Informações</button>
            <button class="menu-btn" id="btnMinhaOrganizacao">Minha Organização</button>
            <button class="menu-btn">Meu PlanoAEE</button>
            <button class="menu-btn">Meus Relatórios</button>
        </div>
    </div>

    <div class="footer"></div>

    <div class="titulo"><h1>Atendimento Educacional Especializado</h1></div>

    <div class="exp">
        O que é o Plano AEE?
        O Plano de Atendimento Educacional Especializado (AEE) é um documento que organiza e orienta as estratégias pedagógicas voltadas aos alunos com deficiência, transtornos globais do desenvolvimento ou altas habilidades/superdotação. Ele visa garantir o acesso, a participação e a aprendizagem desses estudantes, promovendo a inclusão escolar de forma planejada e individualizada.
    </div>

    <div class="imagem"><img src="${pageContext.request.contextPath}/static/images/incluimg.png" alt="img"></div>

    <!-- SCRIPT PARA LER A MATRÍCULA E REDIRECIONAR -->
    <script>
        document.getElementById('btnMinhaOrganizacao').addEventListener('click', function() {
            // lê o valor da matrícula que está no input hidden
            var mat = document.getElementById('matriculaHidden').value;
            // monta a URL de destino concatenando a matrícula
            var url = '${pageContext.request.contextPath}/MinhaOrganizacao?matricula=' + mat;
            window.location.href = url;
        });
    </script>
</body>
</html>
