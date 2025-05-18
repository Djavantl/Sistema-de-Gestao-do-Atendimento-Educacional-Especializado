<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Organização de Atendimento</title>
    <style>
        /* Estilos consistentes com o restante do sistema */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f9f9ff;
            font-family: Arial, sans-serif;
        }

        .container {
            margin: 80px 0 40px 350px;
            width: 70%;
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
        <!-- Sidebar igual às outras páginas -->
    </div>

    <div class="container">
        <div class="form-header">
            <h2>Editar Organização de Atendimento</h2>
        </div>

        <form action="${pageContext.request.contextPath}/templates/aee/organizacao" method="POST">
            <input type="hidden" name="acao" value="atualizar">
            <input type="hidden" name="id" value="${organizacao.id}">
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
                <button type="button" class="btn btn-secondary"
                        onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/detalhes-aluno?id=${aluno.id}'">
                    Cancelar
                </button>
                <button type="submit" class="btn btn-primary">Salvar Alterações</button>
            </div>
        </form>
    </div>
</body>
</html>