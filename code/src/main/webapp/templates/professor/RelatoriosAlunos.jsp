<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatórios do Aluno</title>
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
            width: 100%;
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

        /* ======================== BOTÃO VOLTAR ======================== */
        .botao-voltar {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #4D44B5;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.2s ease;
            margin-left: auto;
            margin-bottom: 15px;
        }

        .botao-voltar:hover {
            background: #3a3285;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }

        .botao-voltar img {
            width: 20px;
            height: 20px;
            filter: brightness(0) invert(1);
        }

        /* ======================== CONTEÚDO CONTAINER ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-top: 20px;
        }

        /* ======================== TABELA ======================== */
        .tabela-relatorios {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 16px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .tabela-relatorios th {
            background-color: #4D44B5;
            color: white;
            text-align: left;
            padding: 16px 20px;
            font-weight: 600;
        }

        .tabela-relatorios td {
            background-color: #fff;
            padding: 14px 20px;
            border-bottom: 1px solid #f0f0f0;
        }

        .tabela-relatorios tr:last-child td {
            border-bottom: none;
        }

        .tabela-relatorios tr:hover td {
            background-color: #f9f9ff;
        }

        .botoes-acoes {
            display: flex;
            gap: 10px;
        }

        .botao-detalhes {
            background-color: #6a5fcc;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-detalhes:hover {
            background-color: #6a5fcc;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .botao-gerar {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-gerar:hover {
            background-color: #218838;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .sem-relatorios {
            text-align: center;
            padding: 30px;
            color: #666;
            font-size: 18px;
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

            .botoes-acoes {
                flex-wrap: wrap;
            }

            .botao-voltar {
                padding: 8px 15px;
                font-size: 14px;
            }
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
                    onclick="window.location.href='${pageContext.request.contextPath}/telaInicialProfessor'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/inicio.svg" alt="Início" />
                Início
            </button>
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/professor/professor-alunos?siape=${siape}'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/alunos.svg" alt="Estudantes" />
                Meus Alunos
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
                    <h1>Relatórios</h1>
                </div>
            </div>

            <div class="conteudo-container">
                <!-- Botão Voltar dentro do quadrado branco, alinhado à direita -->
                <button class="botao-voltar" onclick="window.location.href='${pageContext.request.contextPath}/templates/professor/professor-alunos?siape=${siape}'">
                    Voltar
                </button>

                <!-- Tabela de Relatórios -->
                <table class="tabela-relatorios">
                                <thead>
                                    <tr>
                                        <th>Título</th>
                                        <th>Aluno</th>
                                        <th>Data</th>
                                        <th>Professor</th>
                                        <th>Ações</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty relatoriosLista}">
                                            <c:forEach items="${relatoriosLista}" var="relatorio">
                                                <tr data-id="${relatorio.id}">
                                                    <td>${relatorio.titulo}</td>
                                                    <td>${relatorio.aluno.nome}</td>
                                                    <td>
                                                        ${relatorio.dataGeracao.dayOfMonth}/${relatorio.dataGeracao.monthValue}/${relatorio.dataGeracao.year}
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty relatorio.professorAEE}">
                                                                ${relatorio.professorAEE.nome} (${relatorio.professorAEE.siape})
                                                            </c:when>
                                                            <c:otherwise>
                                                                Não atribuído
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="botoes-acoes">
                                                            <!-- Botão Detalhes -->
                                                            <button class="botao-detalhes"
                                                                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios/detalhes-professor?id=${relatorio.id}&siape=${siape}'">
                                                                Detalhes
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" style="text-align: center;">
                                                    Nenhum relatório encontrado
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
            </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 Inclui+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>
</body>
</html>