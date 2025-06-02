<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Sessão de Atendimento</title>
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

        /* ---------------- Sidebar ---------------- */
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
            font-size: 20px;
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

        /* ------------- Título da Página ------------- */
        #titulo {
            margin-left: 350px;
            padding-top: 40px;
        }

        #titulo h2 {
            color: rgb(12, 12, 97);
            font-size: 28px;
        }

        /* ------------- Conteúdo Principal ------------- */
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
            width: 100%;
        }

        /* ----------- BOTÕES REDUZIDOS ----------- */
        .botao-salvar {
            background-color: #4D44B5;
            color: white;
            padding: 8px 20px;        /* reduzido de 12px 25px */
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 13px;          /* reduzido de 14px */
            transition: background-color 0.3s;
        }

        .botao-salvar:hover {
            background-color: #372e9c;
        }

        .botao-cancelar {
            background-color: #e0e0e0;
            color: #333;
            padding: 8px 20px;        /* reduzido de 12px 25px */
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 13px;          /* reduzido de 14px */
            transition: background-color 0.3s;
        }

        .botao-cancelar:hover {
            background-color: #d0d0d0;
        }

        .info-aluno {
            grid-column: span 2;
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            border-left: 4px solid #4D44B5;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <!-- ---------------- Sidebar ---------------- -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/professor'">Professores</button>
            <button class="menu-btn ativo" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">Sessões</button>
            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/relatorios'">Relatórios</button>
        </div>
    </div>

    <!-- ------------- Título da Página ------------- -->
    <div id="titulo">
        <h2>Editar Sessão de Atendimento</h2>
    </div>

    <!-- ------------- Conteúdo Principal ------------- -->
    <div class="conteudo-principal">
        <form id="formEditarSessao" class="form-plano"
              action="${pageContext.request.contextPath}/templates/aee/sessoes" method="POST">
            <!-- Campos Ocultos -->
            <input type="hidden" name="acao" value="atualizar" />
            <input type="hidden" name="id" value="${sessao.id}" />
            <input type="hidden" name="alunoMatricula" value="${sessao.aluno.matricula}" />

            <!-- Informações do Aluno -->
            <div class="info-aluno">
                <label>Aluno:</label>
                <p><strong>${sessao.aluno.nome}</strong> (${sessao.aluno.matricula})</p>
            </div>

            <!-- Grupo de Campos (Data e Horário) -->
            <div class="grupo-campos">
                <div class="campo">
                    <label for="data">Data:</label>
                    <input type="date" id="data" name="data" value="${sessao.data}" required />
                </div>

                <div class="campo">
                    <label for="horario">Horário:</label>
                    <input type="time" id="horario" name="horario" value="${sessao.horario}" required />
                </div>
            </div>

            <!-- Grupo de Campos (Local e Presença) -->
            <div class="grupo-campos">
                <div class="campo">
                    <label for="local">Local:</label>
                    <input type="text" id="local" name="local" value="${sessao.local}" required />
                </div>

                <div class="campo">
                    <label for="presenca">Presença:</label>
                    <select id="presenca" name="presenca">
                        <option value="true" ${sessao.presenca == true ? "selected" : ""}>Presente</option>
                        <option value="false" ${sessao.presenca == false ? "selected" : ""}>Ausente</option>
                    </select>
                </div>
            </div>

            <!-- Observações -->
            <div class="campo">
                <label for="observacoes">Observações:</label>
                <textarea id="observacoes" name="observacoes">${sessao.observacoes}</textarea>
            </div>

            <!-- Botões de Ação -->
            <div class="botoes-acoes">
                <button type="submit" class="botao-salvar">Salvar Alterações</button>
                <button type="button" class="botao-cancelar" onclick="window.history.back()">
                    Cancelar
                </button>
            </div>
        </form>
    </div>
</body>
</html>
