<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Organização de Atendimento</title>
    <style>
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

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            color: #6c757d;
            margin-bottom: 5px;
            font-weight: 600;
        }

        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            background-color: #f8f9fa;
        }

        .button-group {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .btn {
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-primary {
            background-color: #4D44B5;
            color: white;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn:hover {
            opacity: 0.9;
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
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professores'">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>

        </div>
     </div>

    <div class="container">
        <div class="form-header">
            <h2>Editar Organização de Atendimento</h2>
        </div>

        <form action="${pageContext.request.contextPath}/templates/aee/organizacao" method="POST">
            <input type="hidden" name="acao" value="atualizar">
            <input type="hidden" name="alunoM" value="${aluno.matricula}">
            <input type="hidden" name="alunoId" value="${aluno.id}">

            <div class="form-grid">
                <div class="form-group">
                    <label for="periodo">Período:</label>
                    <input type="text" id="periodo" name="periodo" value="${organizacao.periodo}" required>
                </div>

                <div class="form-group">
                    <label for="duracao">Duração:</label>
                    <input type="text" id="duracao" name="duracao" value="${organizacao.duracao}" required>
                </div>

                <div class="form-group">
                    <label for="frequencia">Frequência:</label>
                    <input type="text" id="frequencia" name="frequencia" value="${organizacao.frequencia}">
                </div>

                <div class="form-group">
                    <label for="composicao">Composição:</label>
                    <input type="text" id="composicao" name="composicao" value="${organizacao.composicao}" required>
                </div>

                <div class="form-group">
                    <label for="tipo">Tipo de Atendimento:</label>
                    <select id="tipo" name="tipo">
                        <option value="Individual" ${organizacao.tipo eq 'Individual' ? 'selected' : ''}>Individual</option>
                        <option value="Parceria" ${organizacao.tipo eq 'Parceria' ? 'selected' : ''}>Parceria</option>
                        <option value="Grupo" ${organizacao.tipo eq 'Grupo' ? 'selected' : ''}>Grupo</option>
                    </select>
                </div>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                <button type="button" class="btn btn-secondary"
                        onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/detalhes-aluno?id=${aluno.id}'">
                    Cancelar
                </button>
            </div>
        </form>
    </div>
</body>
</html>