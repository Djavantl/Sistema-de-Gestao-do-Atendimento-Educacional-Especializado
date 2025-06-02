<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minhas Informações</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Body Background (igual à primeira página) */
        body {
            background: #E6E6FA;
            color: #333;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* ---------------------------------------------
           Sidebar (estilos reaproveitados da primeira página)
           --------------------------------------------- */
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

        /* Conteúdo Principal */
        .conteudo-principal {
            margin: 80px 0 40px 350px;
            width: 70%;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            z-index: 10;
        }

        #titulo h2 {
            color: #4D44B5;
            font-size: 28px;
            margin-bottom: 20px;
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
            padding: 10px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s;
        }

        .botao-voltar:hover {
            background-color: #372e9c;
        }

        .info-section {
            margin-bottom: 30px;
        }

        .info-section h3 {
            color: #4D44B5;
            margin-bottom: 15px;
            border-bottom: 2px solid #4D44B5;
            padding-bottom: 5px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(200px, 1fr));
            gap: 15px;
            align-items: start;
        }

        .info-item {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
        }

        .info-item label {
            display: block;
            color: #6c757d;
            font-size: 0.9em;
            margin-bottom: 5px;
        }

        .info-item p {
            margin: 0;
            font-size: 1em;
            color: #2c3e50;
        }

        .deficiencias-container {
            margin-top: 20px;
        }

        .deficiencia-item {
            padding: 15px;
            background-color: #fff;
        }

        .deficiencia-item.separador {
            border-bottom: 2px solid #bfbfbf;
        }

        /* Elementos Decorativos */
        .decorative-circle {
            position: absolute;
            border-radius: 50%;
            z-index: 0;
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
        @media (max-width: 992px) {
            .sidebar {
                width: 220px;
            }

            .conteudo-principal {
                margin-left: 240px;
                width: calc(100% - 260px);
                padding: 30px;
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
                margin: 30px auto;
                width: 90%;
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

        .info-item.span-2 {
            grid-column: span 2;
        }
    </style>
</head>
<body>
    <!-- Elementos decorativos -->
    <div class="decorative-circle circle-1"></div>
    <div class="decorative-circle circle-2"></div>
    <div class="decorative-circle circle-3"></div>

    <!-- Sidebar (igual à primeira página) -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logoAEE.png" alt="Logo AEE+" />
            <h2>AEE +</h2>
        </div>

        <div class="menu">
            <button class="menu-btn"
                onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">
                 Início
            </button>
            <button class="menu-btn ativo"
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
                    onclick="window.location.href='#'">
                Meus Relatórios
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div id="titulo">
            <h2>Minhas Informações</h2>
        </div>

        <div class="detalhes-header">
            <div></div>
            <button class="botao-voltar" onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">Voltar</button>
        </div>

        <div class="detalhes-content">
            <!-- Informações Pessoais -->
            <div class="info-section">
                <h3>Informações Pessoais</h3>
                <div class="info-grid">
                    <div class="info-item span-2">
                        <label>Nome Completo</label>
                        <p>${aluno.nome}</p>
                    </div>
                    <div class="info-item">
                        <label>Data de Nascimento</label>
                        <p>${aluno.dataNascimento}</p>
                    </div>
                    <div class="info-item">
                        <label>Sexo</label>
                        <p>${aluno.sexo}</p>
                    </div>
                    <div class="info-item span-2">
                        <label>Email</label>
                        <p>${aluno.email}</p>
                    </div>
                    <div class="info-item">
                        <label>Telefone</label>
                        <p>${aluno.telefone}</p>
                    </div>
                    <div class="info-item">
                        <label>Naturalidade</label>
                        <p>${aluno.naturalidade}</p>
                    </div>
                </div>
            </div>

            <!-- Informações Acadêmicas -->
            <div class="info-section">
                <h3>Informações Acadêmicas</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Matrícula</label>
                        <p>${aluno.matricula}</p>
                    </div>
                    <div class="info-item">
                        <label>Curso</label>
                        <p>${aluno.curso}</p>
                    </div>
                    <div class="info-item">
                        <label>Turma</label>
                        <p>${aluno.turma}</p>
                    </div>
                </div>
            </div>

            <!-- Contatos -->
            <div class="info-section">
                <h3>Contatos</h3>
                <div class="info-grid">
                    <div class="info-item span-2">
                        <label>Responsável</label>
                        <p>${aluno.responsavel}</p>
                    </div>
                    <div class="info-item">
                        <label>Tel. Responsável</label>
                        <p>${aluno.telResponsavel}</p>
                    </div>
                    <div class="info-item">
                        <label>Tel. Trabalho</label>
                        <p>${aluno.telTrabalho}</p>
                    </div>
                </div>
            </div>

            <!-- Condições do Aluno -->
            <div class="info-section">
                <h3>Condições do Aluno</h3>
                <c:choose>
                    <c:when test="${not empty deficiencias}">
                        <div class="deficiencias-container">
                            <c:forEach items="${deficiencias}" var="deficiencia" varStatus="loop">
                                <div class="deficiencia-item ${not loop.last ? 'separador' : ''}">
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <label>Nome</label>
                                            <p>${deficiencia.nome}</p>
                                        </div>
                                        <div class="info-item">
                                            <label>Descrição</label>
                                            <p>${deficiencia.descricao}</p>
                                        </div>
                                        <div class="info-item">
                                            <label>Grau</label>
                                            <p>${deficiencia.grauSeveridade}</p>
                                        </div>
                                        <div class="info-item">
                                            <label>CID</label>
                                            <p>${deficiencia.cid}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p>Nenhuma condição especial cadastrada.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>