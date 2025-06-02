<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organização de Atendimento</title>
    <style>
        /* Mesmos estilos da página original */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background-color: #f9f9ff; overflow-x: hidden; }
        .sidebar { position: fixed; top: 0; left: 0; width: 250px; height: 100%; background-color: #4D44B5; color: white; padding: 20px; display: flex; flex-direction: column; align-items: center; }
        .logo { display: flex; align-items: center; gap: 10px; margin-bottom: 30px; }
        .logo img { width: 40px; height: 40px; object-fit: contain; }
        .menu { width: 100%; display: flex; flex-direction: column; gap: 30px; margin-top: 40px; }
        .menu-btn { background-color: transparent; color: #ffffff; border: none; padding: 14px 20px; text-align: left; font-size: 16px; border-radius: 12px; cursor: pointer; transition: background-color 0.3s; }
        .menu-btn:hover { background-color: rgba(255, 255, 255, 0.15); }
        .menu-btn.ativo { background-color: #f9f9ff; color: #4D44B5; }
        .conteudo-principal { margin: 80px 0 40px 350px; width: 70%; padding: 40px; }
        #titulo h2 { color: rgb(12, 12, 97); font-size: 28px; margin-bottom: 20px; }
        .detalhes-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .botao-voltar { background-color: #4D44B5; color: #ffffff; border: none; padding: 10px 22px; border-radius: 10px; cursor: pointer; font-size: 15px; transition: background-color 0.3s; }
        .botao-voltar:hover { background-color: #372e9c; }
        .info-section { margin-bottom: 30px; }
        .info-section h3 { color: #4D44B5; margin-bottom: 15px; border-bottom: 2px solid #4D44B5; padding-bottom: 5px; }
        .info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; align-items: start; }
        .info-item { background-color: #f8f9fa; padding: 15px; border-radius: 8px; }
        .info-item label { display: block; color: #6c757d; font-size: 0.9em; margin-bottom: 5px; }
        .info-item p { margin: 0; font-size: 1em; color: #2c3e50; }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'" >Início</button>
            <button class="menu-btn" >Minhas Informações</button>
            <button class="menu-btn ativo" >Minha Organização</button>
            <button class="menu-btn" >Meu PlanoAEE</button>
            <button class="menu-btn" >Meus Relatórios</button>
        </div>
    </div>

    <div class="conteudo-principal">
        <div id="titulo">
            <h2>Organização de Atendimento</h2>
        </div>

        <div class="detalhes-header">
            <div></div>
            <button class="botao-voltar" onclick="window.location.href='/templates/aee/alunos'">Voltar</button>
        </div>

        <div class="detalhes-content">
            <div class="info-section">
                <h3>Dados do Aluno</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Nome</label>
                        <p>${aluno.nome}</p>
                    </div>
                    <div class="info-item">
                        <label>Matrícula</label>
                        <p>${aluno.matricula}</p>
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
                    <c:otherwise>
                        <p>Nenhuma organização de atendimento cadastrada.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>