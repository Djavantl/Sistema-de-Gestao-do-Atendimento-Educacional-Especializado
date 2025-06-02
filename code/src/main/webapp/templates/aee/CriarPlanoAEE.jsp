<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Plano AEE</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f9f9ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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

        .logo h2 {
            color: white;
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

        #titulo {
            margin-left: 350px;
            padding-top: 40px;
        }

        #titulo h2 {
            color: rgb(12, 12, 97);
            font-size: 28px;
        }

        .conteudo-principal {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 40px;
            margin: 30px 0 40px 350px;
            width: 70%;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .form-plano {
            display: grid;
            gap: 25px;
        }

        .grupo-campos {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
        }

        .campo {
            display: flex;
            flex-direction: column;
        }

        .campo label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .campo input,
        .campo textarea,
        .campo select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            background-color: #fefefe;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .campo input:focus,
        .campo textarea:focus,
        .campo select:focus {
            outline: none;
            border-color: #4D44B5;
            box-shadow: 0 0 0 2px rgba(77, 68, 181, 0.2);
        }

        .campo textarea {
            height: 120px;
            resize: vertical;
        }

        .botoes-acoes {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .botao-salvar {
            background-color: #4D44B5;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .botao-salvar:hover {
            background-color: #372e9c;
        }

        .botao-cancelar {
            background-color: #e0e0e0;
            color: #333;
            padding: 12px 25px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .botao-cancelar:hover {
            background-color: #d0d0d0;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .alert-sucesso {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-erro {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn ativo" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/alunos'">Estudantes</button>
                        <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/professores'">Professores</button>
                        <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/planosAEE'">Planos AEE</button>
                        <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">Sessões</button>
                        <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/relatorios'">Relatórios</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Criar Plano de Atendimento Educacional Especializado (Plano AEE)</h2>
    </div>

    <div class="conteudo-principal">
        <c:if test="${not empty success}">
            <div class="alert alert-sucesso">${success}</div>
        </c:if>
        <c:if test="${not empty erro}">
            <div class="alert alert-erro">${erro}</div>
        </c:if>

        <form class="form-plano" action="${pageContext.request.contextPath}/templates/aee/planoAEE/inserir" method="post">
            <div class="grupo-campos">
                <div class="campo">
                    <label for="professor_siape">Professor Responsável:</label>
                    <select name="professor_siape" id="professor_siape">
                      <option value="">Selecione um professor</option>
                      <c:forEach var="professor" items="${professores}">
                        <option value="${professor.siape}">${professor.nome}</option>
                      </c:forEach>
                    </select>

                    <c:if test="${empty professores}">
                        <p style="color: #dc3545; margin-top: 5px;">
                            Nenhum professor encontrado.
                            <a href="${pageContext.request.contextPath}/templates/aee/professores" style="color: #4D44B5;">
                                Cadastrar novo professor
                            </a>
                        </p>
                    </c:if>
                </div>

                <div class="campo">
                    <label for="aluno_matricula">Aluno:</label>
                    <select name="aluno_matricula" id="aluno_matricula">
                      <option value="">Selecione um aluno</option>
                      <c:forEach var="aluno" items="${alunos}">
                        <option value="${aluno.matricula}">${aluno.nome}</option>
                      </c:forEach>
                    </select>
                    <c:if test="${empty alunos}">
                        <p style="color: #dc3545; margin-top: 5px;">
                            Nenhum aluno encontrado.
                            <a href="${pageContext.request.contextPath}/templates/aee/alunos" style="color: #4D44B5;">
                                Cadastrar novo aluno
                            </a>
                        </p>
                    </c:if>
                </div>

                <div class="campo">
                    <label for="dataInicio">Data de Início:</label>
                    <input type="date" id="dataInicio" name="dataInicio"
                           value="${param.dataInicio}" required>
                </div>
            </div>

            <div class="campo">
                <label for="recomendacoes">Recomendações:</label>
                <textarea id="recomendacoes" name="recomendacoes" rows="4"
                          placeholder="Recomendações pedagógicas, estratégias de ensino...">${param.recomendacoes}</textarea>
            </div>

            <div class="campo">
                <label for="observacoes">Observações:</label>
                <textarea id="observacoes" name="observacoes" rows="4"
                          placeholder="Informações relevantes sobre o aluno...">${param.observacoes}</textarea>
            </div>

            <div class="botoes-acoes">
                <button type="submit" class="botao-salvar">Salvar Plano AEE</button>
                <button type="button" class="botao-cancelar" onclick="window.history.back()">Cancelar</button>
            </div>
        </form>
    </div>

    <script>
        // Script para melhorar a experiência do usuário
        document.addEventListener('DOMContentLoaded', function() {
            // Focar no primeiro campo ao carregar a página
            document.getElementById('professor_siape').focus();

            // Atualizar o ano mínimo para a data de início
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            const minDate = `${year}-${month}-${day}`;
            document.getElementById('dataInicio').min = minDate;

            // Verificar se há dados para restaurar após erro
            if('${not empty erro}') {
                // Tentar manter os valores selecionados
                const professorSelect = document.getElementById('professor_siape');
                const alunoSelect = document.getElementById('aluno_matricula');

                if('${not empty param.professor_siape}') {
                    professorSelect.value = '${param.professor_siape}';
                }

                if('${not empty param.aluno_matricula}') {
                    alunoSelect.value = '${param.aluno_matricula}';
                }
            }
        });
    </script>
</body>
</html>