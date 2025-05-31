<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Novo Relatório</title>
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
            margin: 80px auto 40px;
            width: 40%;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .linha-superior {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 30px;
        }

        .form-columns {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            margin-bottom: 20px;
            width: 100%;
            max-width: 500px;
        }

        .form-column {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
            margin-top: 8px;
        }

        input, select, textarea {
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

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        input:focus, select:focus, textarea:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .botoes-modal {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
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
            background-color: #cfcfcf;
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
            <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professor'">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>
            <button class="menu-btn ativo">Relatórios</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Criar Novo Relatório</h2>
    </div>

    <div class="conteudo-principal">
        <div class="linha-superior"></div>
        <form id="formNovoRelatorio" action="${pageContext.request.contextPath}/relatorios/criar" method="POST">
            <div class="form-columns">
                <div class="form-column">
                    <input type="hidden" name="acao" value="criar">
                    <input type="hidden" name="alunoMatricula" value="${alunoMatricula}">

                    <!-- Exiba o aluno se necessário -->
                    <c:if test="${not empty aluno}">
                        <div class="info-item">
                            <label>Aluno:</label>
                            <p>${aluno.nome} (${aluno.matricula})</p>
                        </div>
                    </c:if>

                    <label for="titulo">Título do Relatório:</label>
                    <input type="text" id="titulo" name="titulo" required>

                    <label for="dataGeracao">Data do Relatório:</label>
                    <input type="date" id="dataGeracao" name="dataGeracao" required>

                    <label for="professorResponsavel">Professor Responsável:</label>
                    <select id="professorResponsavel" name="professorId" required>
                        <option value="">Selecione...</option>
                        <c:forEach items="${professores}" var="professor">
                            <option value="${professor.id}">${professor.nome} (${professor.siape})</option>
                        </c:forEach>
                    </select>

                    <label for="resumo">Resumo:</label>
                    <textarea id="resumo" name="resumo" required></textarea>

                    <label for="observacoes">Observações:</label>
                    <textarea id="observacoes" name="observacoes"></textarea>

                    <label for="recomendacoes">Recomendações:</label>
                    <textarea id="recomendacoes" name="recomendacoes"></textarea>
                </div>
            </div>

            <div class="botoes-modal">
                <button type="submit">Salvar</button>
                <button type="button" class="botao-voltar"
                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios'">
                    Voltar
                </button>
            </div>
        </form>
    </div>

    <script>
        // Define a data atual como padrão
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('dataGeracao').value = today;
        });
    </script>
</body>
</html>