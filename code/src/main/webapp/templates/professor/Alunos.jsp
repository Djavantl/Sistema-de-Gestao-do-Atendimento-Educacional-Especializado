<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alunos Vinculados</title>
    <link rel="stylesheet" href="alunos.css">
</head>
<style>
    @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

    /* Estilos Gerais */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background-color: #f9f9ff;
        overflow-x: hidden;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Sidebar */
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
        width: 80px;
        height: 80px;
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

    /* Conteúdo Principal */
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

    /* Tabela */
    .tabela-alunos {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
        border-radius: 8px;
        overflow: hidden;
        margin-top: 20px;
    }

    .tabela-alunos th,
    .tabela-alunos td {
        padding: 14px;
        text-align: left;
    }

    .tabela-alunos th {
        background-color: #ecf0f1;
        color: #2c3e50;
        font-weight: 600;
    }

    .tabela-alunos td {
        background-color: #ffffff;
        border-bottom: 1px solid #e0e0e0;
    }

    /* Botões e Ações */
    .botoes-acoes {
        display: flex;
        gap: 8px;
    }

    .botao-ver-mais {
        background-color: #17a2b8;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        transition: background-color 0.3s;
    }

    .botao-ver-mais:hover {
        background-color: #138496;
    }

    /* Modal Overlay */
    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        backdrop-filter: blur(5px);
        background-color: rgba(0, 0, 0, 0.2);
        display: none;
        justify-content: center;
        align-items: center;
        z-index: 2000;
    }

    /* Responsividade */
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

        .tabela-alunos {
            font-size: 12px;
        }
    }

    @media (max-width: 576px) {
        .conteudo-principal {
            padding: 15px;
            margin-left: 70px;
            width: calc(100% - 80px);
        }

        .tabela-alunos th,
        .tabela-alunos td {
            padding: 10px;
        }

        .botoes-acoes {
            flex-direction: column;
        }
    }

    /* Efeitos de Transição */
    tr {
        transition: background-color 0.2s;
    }

    tr:hover {
        background-color: #f8f9fa;
    }

    /* Scrollbar Personalizada */
    ::-webkit-scrollbar {
        width: 8px;
    }

    ::-webkit-scrollbar-track {
        background: #f1f1f1;
    }

    ::-webkit-scrollbar-thumb {
        background: #4D44B5;
        border-radius: 4px;
    }

    ::-webkit-scrollbar-thumb:hover {
        background: #372e9c;
    }
</style>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logoAEE.png" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn ativo">Meus Alunos</button>


        </div>
    </div>

    <div id="titulo">
        <h2>Alunos Vinculados</h2>
    </div>

    <div class="conteudo-principal">
            <table class="tabela-alunos">
                <thead>
                    <tr>
                        <th>Matrícula</th>
                        <th>Nome</th>
                        <th>Curso</th>
                        <th>Turma</th>
                        <th>Responsável</th>
                        <th>Telefone</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${alunosVinculados}" var="aluno">
                        <tr>
                            <td>${aluno.matricula}</td>
                            <td>${aluno.nome}</td>
                            <td>${aluno.curso}</td>
                            <td>${aluno.turma}</td>
                            <td>${aluno.responsavel}</td>
                            <td>${aluno.telefone}</td>
                            <td>
                                <div class="botoes-acoes">
                                    <button class="botao-ver-mais"
                                            onclick="window.location.href='${pageContext.request.contextPath}/templates/professor/detalhes-alunoP?matricula=${aluno.matricula}'">
                                        Detalhes
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
</body>
</html>