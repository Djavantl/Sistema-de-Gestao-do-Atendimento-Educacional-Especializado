<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minha Organização</title>
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

        /* ======================== CONTEÚDO ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .detalhes-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .botao-voltar {
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-voltar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .info-section {
            margin-bottom: 30px;
        }

        .info-section h3 {
            color: #4D44B5;
            margin-bottom: 20px;
            border-bottom: 2px solid #4D44B5;
            padding-bottom: 10px;
            font-size: 24px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .info-item {
            background-color: #f8f9ff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .info-item.span-2 {
            grid-column: span 2;
        }

        .info-item label {
            display: block;
            color: #6c757d;
            font-size: 16px;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .info-item p {
            margin: 0;
            font-size: 18px;
            color: #2c3e50;
            font-weight: 600;
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
            margin-top: auto;
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

            .info-grid {
                grid-template-columns: 1fr;
            }

            .info-item.span-2 {
                grid-column: span 1;
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
                    onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/inicio.svg" alt="Início" />
                Início
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aluno/minhas-informacoes?matricula=${matricula}'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/alunos.svg" alt="Estudantes" />
                Informações
            </button>
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/MinhaOrganizacao?matricula=${matricula}'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/sessoes.svg" alt="Sessões" />
                Organização
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/meu-plano?matricula=${matricula}'">
                <img src="${pageContext.request.contextPath}/static/images/meuplano.svg" alt="Planos AEE" />
                Plano AEE
            </button>

            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aluno/minhas-sessoes?matricula=${matricula}'">
                    <img src="${pageContext.request.contextPath}/static/images/atendimento.svg" alt="Sessões" />
                Sessões
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/meus-relatorios?matricula=${matricula}'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/relatorios.svg" alt="Relatórios" />
                Relatórios
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
                <h1>Minha Organização</h1>
            </div>
        </div>

        <div class="conteudo-container">
            <div class="detalhes-header">
                <div></div>
                <button class="botao-voltar" onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">Voltar</button>
            </div>
            <input type="hidden" id="matriculaHidden" value="${matricula}" />

            <div class="detalhes-content">
                <div class="info-section">
                    <h3>Dados do Aluno</h3>
                    <div class="info-grid">
                        <div class="info-item span-2">
                            <label>Nome</label>
                            <p>${aluno.nome}</p>
                        </div>
                        <div class="info-item">
                            <label>Turma</label>
                            <p>${aluno.turma}</p>
                        </div>
                    </div>
                </div>

                <div class="info-section">
                    <h3>Organização de Atendimento</h3>
                    <c:choose>
                        <c:when test="${not empty organizacao}">
                            <div class="info-grid">
                                <div class="info-item">
                                    <label>Período</label>
                                    <p>${organizacao.periodo}</p>
                                </div>
                                <div class="info-item">
                                    <label>Duração</label>
                                    <p>${organizacao.duracao}</p>
                                </div>
                                <div class="info-item">
                                    <label>Frequência</label>
                                    <p>${organizacao.frequencia}</p>
                                </div>
                                <div class="info-item span-2">
                                    <label>Composição</label>
                                    <p>${organizacao.composicao}</p>
                                </div>
                                <div class="info-item">
                                    <label>Tipo</label>
                                    <p>${organizacao.tipo}</p>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="info-item">
                                <p>Nenhuma organização de atendimento cadastrada.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>
</body>
</html>