<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Aluno</title>
    <link rel="stylesheet" href="alunos.css">
</head>
    <style>
    /* Estilos específicos para detalhes mantendo consistência */

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background-color: #f9f9ff;
        overflow-x: hidden;
    }

    /* Correção do título */
    #titulo h2 {
        color: rgb(12, 12, 97);
        font-size: 28px;
        margin-left: 350px;
        margin-top: 40px;
    }

    /* Ajuste do cabeçalho */
    .detalhes-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 0 20px; /* Adicionado para espaçamento interno */
    }

    /* Garantir que o título esteja dentro da div titulo */
    #titulo {
        margin-bottom: 20px;
    }

    .conteudo-principal {
        /* Medidas idênticas à página AlunoCriar */
        margin: 80px 0 40px 350px;
        width: 70%;
        padding: 40px;
    }

    .detalhes-header {
        display: flex;
        justify-content: space-between; /* Alinha os elementos nas extremidades */
        align-items: center;
        padding: 0 20px; /* Adiciona espaçamento interno */
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
    }

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

        .menu-btn:hover {
            background-color: rgba(255, 255, 255, 0.15);
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
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
    }

    .botao-novo-aluno {
        background-color: #4D44B5;
        color: #ffffff;
        border: none;
        padding: 10px 22px;
        border-radius: 10px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s;
    }

    .botao-novo-aluno:hover {
        background-color: #372e9c;
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

    .linha-superior {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 30px;
        gap: 15px;
        margin-top: 20px;
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

    .botoes-acoes {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-left: auto;
    }

    /* Estilos para as deficiências */
    .deficiencias-container {
        margin-top: 20px;
        border-radius: 8px;
        overflow: hidden;
    }

    .deficiencia-item {
        padding: 15px;
        background-color: #fff;
    }

    .deficiencia-item.separador {
        border-bottom: 2px solid #bfbfbf;
    }

    .acoes-deficiencia {
        grid-column: 1 / -1;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        padding: 10px 0;
        margin-top: 10px;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        align-items: start;
    }

    </style>
<body>
    <div class="sidebar">
            <div class="logo">
                <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
                <h2>Inclui+</h2>
            </div>
            <div class="menu">
                <button class="menu-btn ativo" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
                <button class="menu-btn">Professores</button>
                <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>
                <button class="menu-btn">Usuários</button>
            </div>
    </div>

    <div id="titulo">

        <h2>Detalhes do Aluno</h2>
    </div>

    <div class="conteudo-principal">
        <!-- Mensagens de feedback -->
        <c:if test="${not empty sucesso}">
            <div class="alert success">${sucesso}</div>
        </c:if>
        <c:if test="${not empty erro}">
            <div class="alert error">${erro}</div>
        </c:if>
        <div class="detalhes-header">
            <div></div>
            <button class="botao-novo-aluno" onclick="window.location.href='/templates/aee/alunos'">Voltar</button>
        </div>

        <div class="detalhes-content">
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

            <!-- Deficiências do Aluno -->
            <div class="info-section">
                <h3>Deficiências do Aluno</h3>
                <button class="botao-novo-aluno"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/CriarDeficiencia.jsp?alunoId=${aluno.id}&matricula=${aluno.matricula}'">
                    Adicionar Deficiência
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
                                        <button class="botao-novo-aluno"
                                            onclick="window.location.href='${pageContext.request.contextPath}/deficiencia?acao=editar&id=${deficiencia.id}&alunoId=${aluno.id}'">
                                            Editar
                                        </button>
                                        <form action="${pageContext.request.contextPath}/deficiencia" method="POST" style="display:inline;">
                                            <input type="hidden" name="acao" value="excluir">
                                            <input type="hidden" name="id" value="${deficiencia.id}">
                                            <input type="hidden" name="alunoId" value="${aluno.id}">
                                            <input type="hidden" name="matricula" value="${param.matricula}">
                                            <button type="submit" class="botao-novo-aluno"
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
                            <div class="info-item">
                                <label>Composição</label>
                                <p>${organizacao.composicao}</p>
                            </div>
                            <div class="info-item">
                                <label>Tipo</label>
                                <p>${organizacao.tipo}</p>
                            </div>
                        </div>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${not empty organizacao}">
                        <div style="display: flex; gap: 10px;">
                            <div class="botoes-acoes">
                                <button class="botao-novo-aluno"
                                        onclick="window.location.href='${pageContext.request.contextPath}/organizacao/editar?id=${organizacao.id}&alunoId=${aluno.id}'">
                                    Editar
                                </button>
                                <form action="${pageContext.request.contextPath}/organizacao/${organizacao.id}"
                                      method="POST"
                                      style="display:inline;">
                                    <input type="hidden" name="_method" value="DELETE">
                                    <input type="hidden" name="alunoId" value="${aluno.id}">
                                    <button type="submit" class="botao-novo-aluno"
                                            onclick="return confirm('Tem certeza que deseja excluir esta organização?')">
                                        Excluir
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <button class="botao-novo-aluno"
                                onclick="window.location.href='/templates/aee/organizacao?id=${aluno.id}&matricula=${aluno.matricula}'">
                            Adicionar Organização
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
            <!-- Relatorios -->
            <div class="info-section">
                <h3>Relatórios do Aluno</h3>
                <div>
                    <button class="botao-novo-aluno"
                            onclick="window.location.href='/templates/aee/PorRelatorio.jsp'">
                        Mostrar Relatorios
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>