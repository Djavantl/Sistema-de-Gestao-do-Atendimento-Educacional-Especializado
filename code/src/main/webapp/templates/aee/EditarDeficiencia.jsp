<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Deficiência</title>
    <style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f9f9ff;

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
        }

        .menu-btn.ativo {
            background-color: #f9f9ff;
            color: #4D44B5;
        }

        .menu-btn:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }

        .container {
            margin: 80px 0 40px 350px;
            width: 60%;
            padding: 40px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);

        }

        .form-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .form-header h2 {
            color: #4D44B5;
        }

        .form-columns {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            margin-bottom: 20px;
            width: 100%;
            max-width: 500px;
        }

        label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
            margin-top: 8px;
        }

        input, select {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-top: 4px;
            margin-bottom: 12px;
            background-color: #fefefe;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        input:focus, select:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .botoes-modal {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
            width: 100%;
        }

        button[type="submit"] {
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }



        button[type="submit"]:hover {
            background-color: #372e9c;
        }

        .botao-voltar {
            background-color: #e0e0e0;
            color: #333;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .botao-voltar:hover {
            background-color: #d0d0d0;
        }

        .conteudo-principal {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 40px;
            margin: 80px auto 40px; /* Alterado para centralizar */
            width: 40%;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            display: flex;
            flex-direction: column;
            align-items: center;
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
    <div class="conteudo-principal">
        <div class="form-header">
            <h2>Editar Condição</h2>
        </div>
        <form action="${pageContext.request.contextPath}/deficiencia" method="POST">
            <input type="hidden" name="acao" value="atualizar">
            <input type="hidden" name="id" value="${deficiencia.id}">
            <input type="hidden" name="alunoId" value="${param.alunoId}">
            <input type="hidden" name="matricula" value="${param.matricula}">

            <div class="form-columns">
                <div class="form-column">
                    <label for="nome">Nome da Condição:</label>
                    <input type="text" id="nome" name="nome" value="${deficiencia.nome}" required>

                    <label for="descricao">Descrição:</label>
                    <input type="text" id="descricao" name="descricao" value="${deficiencia.descricao}" required>

                    <label for="grau">Grau de severidade:</label>
                    <input type="text" id="grau" name="grau" value="${deficiencia.grauSeveridade}">

                    <label for="cid">CID:</label>
                    <input type="text" id="cid" name="cid" value="${deficiencia.cid}" required>
                </div>
            </div>
            <div class="botoes-modal">
                <button type="submit">Salvar Alterações</button>
                <button type="button" class="botao-voltar"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/detalhes-aluno?id=${param.alunoId}'">
                    Cancelar
                </button>
            </div>
        </form>
    </div>
</body>
</html>