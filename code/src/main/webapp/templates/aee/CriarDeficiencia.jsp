<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Deficiências</title>
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
                    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
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

                /* ======================== FORMULÁRIO PADRÃO ======================== */
                .conteudo-container {
                    background: rgba(255, 255, 255, 0.95);
                    border-radius: 20px;
                    padding: 40px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                    position: relative;
                    overflow: hidden;
                    max-width: 700px;
                    margin: 0 auto;
                    width: 100%;
                }

                .form-titulo {
                    text-align: center;
                    margin-bottom: 30px;
                    color: #4D44B5;
                    font-size: 32px;
                    font-weight: 700;
                }

                .form-grid {
                    display: grid;
                    grid-template-columns: 1fr;
                    gap: 25px;
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
                }

                .input-group input,
                .input-group select,
                .input-group textarea {
                    padding: 12px 16px;
                    font-size: 15px;
                    border: 1px solid #ddd;
                    border-radius: 12px;
                    background-color: #fafafa;
                    transition: all 0.3s ease;
                    width: 100%;
                }

                .input-group input:focus,
                .input-group select:focus,
                .input-group textarea:focus {
                    border-color: #4D44B5;
                    box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
                    outline: none;
                }

                .botoes-form {
                    display: flex;
                    justify-content: flex-end;
                    gap: 15px;
                    margin-top: 30px;
                }

                .botao-salvar {
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

                .botao-salvar:hover {
                    background-color: #372e9c;
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(77, 68, 181, 0.3);
                }

                .botao-voltar {
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

                .botao-voltar:hover {
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

                    .header {
                        flex-direction: column;
                        align-items: stretch;
                    }

                    .user-info {
                        min-width: auto;
                        margin-top: 15px;
                    }
                }

                @media (max-width: 576px) {
                    .conteudo-principal {
                        padding: 15px;
                    }

                    .conteudo-container {
                        padding: 25px;
                    }

                    .botoes-form {
                        flex-direction: column;
                    }

                    .botao-salvar, .botao-voltar {
                        width: 100%;
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
                <h1>Criar Condição Especial</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <div class="conteudo-container">


            <form id="formNovaDeficiencia" action="${pageContext.request.contextPath}/deficiencia" method="POST">
                <input type="hidden" name="acao" value="criar">
                <input type="hidden" name="alunoId" value="${param.alunoId}">
                <input type="hidden" name="matricula" value="${param.matricula}">

                <div class="form-grid">
                    <div class="input-group">
                        <label for="nome">Nome da Condição:</label>
                        <input type="text" id="nome" name="nome" required>
                    </div>

                    <div class="input-group">
                        <label for="descricao">Descrição:</label>
                        <input type="text" id="descricao" name="descricao" required>
                    </div>

                    <div class="input-group">
                        <label for="grau">Grau de Severidade:</label>
                        <input type="text" id="grau" name="grau">
                    </div>

                    <div class="input-group">
                        <label for="cid">Código CID:</label>
                        <input type="text" id="cid" name="cid" required>
                    </div>
                </div>

                <div class="botoes-form">
                    <button class="botao-salvar" type="submit">Salvar</button>
                    <button class="botao-voltar" type="button"
                            onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/detalhes-aluno?id=${param.alunoId}'">
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
</body>
</html>