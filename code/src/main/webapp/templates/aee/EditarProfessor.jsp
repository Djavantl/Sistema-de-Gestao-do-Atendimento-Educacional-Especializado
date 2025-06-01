<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Professor</title>
    <style>
        /* Estilo idêntico ao EditarProfessorAEE.jsp */
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
            background-color: #e9ecef;
            color: #495057;
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
            <button class="menu-btn ativo" onclick="window.location.href='/templates/aee/professores'">Professores</button>
            <button class="menu-btn"onclick="window.location.href='/templates/aee/professoresAEE'">Professores AEE</button>
        </div>
    </div>

    <div class="container">
        <div class="form-header">
            <h2>Editar Professor</h2>
        </div>

        <form action="${pageContext.request.contextPath}/templates/aee/professores" method="POST">
            <input type="hidden" name="acao" value="atualizar">
            <input type="hidden" name="siape" value="${professor.siape}">

            <div class="form-grid">
                <div class="form-group">
                    <label for="nome">Nome:</label>
                    <input type="text" id="nome" name="nome" value="${professor.nome}" required>
                </div>

                <div class="form-group">
                    <label for="dataNascimento">Data Nascimento:</label>
                    <input type="date" id="dataNascimento" name="dataNascimento" value="${professor.dataNascimento}" required>
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="${professor.email}" required>
                </div>

                <div class="form-group">
                    <label for="sexo">Sexo:</label>
                    <select id="sexo" name="sexo" required>
                        <option value="Masculino" ${professor.sexo eq 'Masculino' ? 'selected' : ''}>Masculino</option>
                        <option value="Feminino" ${professor.sexo eq 'Feminino' ? 'selected' : ''}>Feminino</option>
                        <option value="Outro" ${professor.sexo eq 'Outro' ? 'selected' : ''}>Outro</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="naturalidade">Naturalidade:</label>
                    <input type="text" id="naturalidade" name="naturalidade" value="${professor.naturalidade}">
                </div>

                <div class="form-group">
                    <label for="telefone">Telefone:</label>
                    <input type="tel" id="telefone" name="telefone" value="${professor.telefone}">
                </div>

                <div class="form-group">
                    <label for="especialidade">Cursos:</label>
                    <input type="text" id="especialidade" name="especialidade" value="${professor.especialidade}" required>
                </div>
            </div>

            <div class="button-group">
                <button type="submit" class="btn btn-primary">Salvar Alterações</button>
                <button type="button" class="btn btn-secondary"
                        onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/professores'">
                    Cancelar
                </button>
            </div>
        </form>
    </div>
</body>
</html>