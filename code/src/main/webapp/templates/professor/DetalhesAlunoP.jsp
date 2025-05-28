<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Aluno</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            background-color: #f9f9ff;
            overflow-x: hidden;
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
            z-index: 1000;
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
            width: 100%;
        }

        .menu-btn:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }

        .menu-btn.ativo {
            background-color: #f9f9ff;
            color: #4D44B5;
        }

        #titulo h2 {
            color: rgb(12, 12, 97);
            font-size: 28px;
            margin-left: 350px;
            margin-top: 40px;
        }

        .conteudo-principal {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 40px;
            margin: 80px 0 40px 350px;
            width: 70%;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .detalhes-header {
            display: flex;
            justify-content: flex-end;
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
            margin-bottom: 40px;
        }

        .info-section h3 {
            color: #4D44B5;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #4D44B5;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .info-item {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
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
            word-break: break-word;
        }

        .deficiencias-container {
            margin-top: 20px;
        }

        .deficiencia-item {
            padding: 15px;
            background-color: #fff;
            border-bottom: 1px solid #dee2e6;
        }

        @media (max-width: 1200px) {
            .conteudo-principal {
                width: 85%;
                margin-left: 300px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 200px;
            }
            .conteudo-principal {
                margin-left: 250px;
                padding: 25px;
            }
            #titulo h2 {
                margin-left: 250px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 60px;
                padding: 10px;
            }
            .logo h2,
            .menu-btn span {
                display: none;
            }
            .conteudo-principal {
                margin-left: 80px;
                width: calc(100% - 100px);
            }
            #titulo h2 {
                margin-left: 100px;
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn ativo" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professor">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>
            <button class="menu-btn">Usuários</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Detalhes do Aluno</h2>
    </div>

    <div class="conteudo-principal">
        <div class="detalhes-header">
            <button class="botao-voltar" onclick="window.history.back()">Voltar</button>
        </div>

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
        <c:if test="${not empty deficiencias}">
            <div class="info-section">
                <h3>Condições Especiais</h3>
                <div class="deficiencias-container">
                    <c:forEach items="${deficiencias}" var="deficiencia">
                        <div class="deficiencia-item">
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
            </div>
        </c:if>

        <!-- Organização de Atendimento -->
        <c:if test="${not empty organizacao}">
            <div class="info-section">
                <h3>Organização de Atendimento</h3>
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
            </div>
        </c:if>
    </div>
</body>
</html>