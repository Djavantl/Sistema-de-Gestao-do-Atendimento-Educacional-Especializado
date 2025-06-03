<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Aluno</title>
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

        /* ======================== CONTEÚDO DETALHES ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .detalhes-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .alert {
            padding: 15px;
            margin: 20px 0;
            border-radius: 8px;
            border: 1px solid transparent;
        }

        .success {
            background-color: #d4edda;
            border-color: #c3e6cb;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }

        /* ======================== SEÇÕES DE INFORMAÇÃO ======================== */
        .info-section {
            margin-bottom: 40px;
            padding: 25px;
            background-color: #f9f9ff;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .info-section h3 {
            color: #4D44B5;
            font-size: 22px;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e0e0ff;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .info-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .info-item label {
            display: block;
            color: #6c757d;
            font-size: 0.95em;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .info-item p {
            margin: 0;
            font-size: 1.1em;
            color: #2c3e50;
            font-weight: 600;
        }

        /* ======================== BOTÕES ======================== */
        .botao-novo-aluno {
            background-color: #4D44B5;
            color: #fff;
            border: none;
            padding: 12px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        }

        .botao-novo-aluno:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .botoes-acoes {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .botao-voltar {
            background-color: #e0e0e0;
            color: #333;
            border: none;
            padding: 12px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .botao-voltar:hover {
            background-color: #d0d0d0;
            transform: translateY(-2px);
        }

        /* ======================== DEFICIÊNCIAS ======================== */
        .deficiencias-container {
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
        }

        .deficiencia-item {
            padding: 20px;
            background-color: #fff;
            margin-bottom: 15px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .deficiencia-item.separador {
            border-bottom: 2px solid #e0e0ff;
        }

        .acoes-deficiencia {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding: 15px 0 0;
            margin-top: 15px;
        }

        .acoes-deficiencia button {
            padding: 10px 18px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            border: none;
        }

        .acoes-deficiencia .botao-editar {
            background-color: #6a5fcc;
            color: #fff;
        }

        .acoes-deficiencia .botao-editar:hover {
            background-color: #554bbd;
            transform: translateY(-2px);
        }

        .acoes-deficiencia .botao-excluir {
            background-color: #dc3545;
            color: #fff;
        }

        .acoes-deficiencia .botao-excluir:hover {
            background-color: #c82333;
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

            .botoes-acoes {
                flex-wrap: wrap;
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
            <button class="menu-btn"
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
                <h1>Detalhes do Aluno</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <div class="conteudo-container">
            <div class="detalhes-header">
                <div></div>
                <button class="botao-voltar" onclick="window.location.href='/templates/aee/alunos'">Voltar</button>
            </div>

            <!-- Mensagens de feedback -->
            <c:if test="${not empty sucesso}">
                <div class="alert success">${sucesso}</div>
            </c:if>
            <c:if test="${not empty erro}">
                <div class="alert error">${erro}</div>
            </c:if>

            <!-- Informações Pessoais -->
            <div class="info-section">
                <h3>Informações Pessoais</h3>
                <div class="info-grid">
                    <div class="info-item">
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
                    <div class="info-item">
                        <label>Naturalidade</label>
                        <p>${aluno.naturalidade}</p>
                    </div>
                    <div class="info-item">
                        <label>Email</label>
                        <p>${aluno.email}</p>
                    </div>
                    <div class="info-item">
                        <label>Telefone</label>
                        <p>${aluno.telefone}</p>
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
                    <div class="info-item">
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
                <button class="botao-novo-aluno"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/CriarDeficiencia.jsp?alunoId=${aluno.id}&matricula=${aluno.matricula}'">
                    Adicionar Condições Especiais
                </button>

                <c:if test="${not empty deficiencias}">
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
                                    <div class="acoes-deficiencia">
                                        <button class="botao-editar"
                                            onclick="window.location.href='${pageContext.request.contextPath}/deficiencia?acao=editar&id=${deficiencia.id}&alunoId=${aluno.id}'">
                                            Editar
                                        </button>
                                        <form action="${pageContext.request.contextPath}/deficiencia" method="POST" style="display:inline;">
                                            <input type="hidden" name="acao" value="excluir">
                                            <input type="hidden" name="id" value="${deficiencia.id}">
                                            <input type="hidden" name="alunoId" value="${aluno.id}">
                                            <input type="hidden" name="matricula" value="${param.matricula}">
                                            <button type="submit" class="botao-excluir"
                                                onclick="return confirm('Tem certeza que deseja excluir esta deficiência?')">
                                                Excluir
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>

            <!-- Organização de Atendimento -->
            <div class="info-section">
                <h3>Organização de Atendimento</h3>
                <c:if test="${not empty organizacao}">
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
                        <div class="info-item">
                            <label>Composição</label>
                            <p>${organizacao.composicao}</p>
                        </div>
                        <div class="info-item">
                            <label>Tipo</label>
                            <p>${organizacao.tipo}</p>
                        </div>
                    </div>
                    <div class="acoes-deficiencia">
                        <button class="botao-editar"
                            onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/organizacao?acao=editar&alunoM=${aluno.matricula}&alunoId=${aluno.id}'">
                            Editar
                        </button>
                        <form action="${pageContext.request.contextPath}/templates/aee/organizacao" method="POST" style="display:inline;">
                            <input type="hidden" name="acao" value="excluir">
                            <input type="hidden" name="alunoId" value="${aluno.id}">
                            <input type="hidden" name="alunoM" value="${aluno.matricula}">
                            <button type="submit" class="botao-excluir"
                                    onclick="return confirm('Tem certeza que deseja excluir esta organização?')">
                                Excluir
                            </button>
                        </form>
                    </div>
                </c:if>
                <c:if test="${empty organizacao}">
                    <button class="botao-novo-aluno"
                            onclick="window.location.href='/templates/aee/organizacao?id=${aluno.id}&matricula=${aluno.matricula}'">
                        Adicionar Organização
                    </button>
                </c:if>
            </div>

            <!-- Relatorios -->
            <div class="info-section">
                <h3>Relatórios do Aluno</h3>
                <div>
                    <button class="botao-novo-aluno"
                        onclick="window.location.href='${pageContext.request.contextPath}/relatorios?alunoMatricula=${aluno.matricula}'">
                        Mostrar Relatórios
                    </button>
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