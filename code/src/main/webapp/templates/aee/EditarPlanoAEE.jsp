<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Plano AEE</title>
    <style>
        /* ======================== RESET E BASE ======================== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #E6E6FA;
            color: #333;
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* ======================== SIDEBAR ======================== */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background: #4D44B5;
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            z-index: 100;
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

        .logo h2 {
            color: #ffffff;
            font-size: 24px;
            font-weight: 700;
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
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .menu-btn:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }

        .menu-btn.ativo {
            background-color: #f9f9ff;
            color: #4D44B5;
        }

        .menu-btn img {
            width: 24px;
            height: 24px;
            filter: brightness(0) invert(1);
        }

        .menu-btn.ativo img {
            filter: invert(26%) sepia(33%) saturate(3500%) hue-rotate(261deg) brightness(86%) contrast(85%);
        }

        /* ======================== CONTEÚDO PRINCIPAL ======================== */
        .conteudo-principal {
            margin-left: 280px;
            padding: 40px 60px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            margin-bottom: 30px;
        }

        .titulo h1 {
            color: #4D44B5;
            font-size: 42px;
            font-weight: 800;
            line-height: 1.2;
            max-width: 600px;
        }

        .user-info {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            padding: 20px 25px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            min-width: 280px;
            text-align: center;
        }

        .user-info p {
            color: #4D44B5;
            font-weight: 600;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .user-info .funcao {
            font-size: 16px;
            color: #777;
            font-weight: 500;
        }

        /* ======================== FORMULÁRIO ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .form-plano {
            display: grid;
            gap: 25px;
        }

        .grupo-campos {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        .campo {
            display: flex;
            flex-direction: column;
        }

        .campo label {
            font-weight: 600;
            color: #555;
            font-size: 15px;
            margin-bottom: 8px;
        }

        .campo input,
        .campo textarea,
        .campo select {
            width: 100%;
            padding: 12px 16px;
            font-size: 15px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #fafafa;
            transition: all 0.3s ease;
        }

        .campo input:focus,
        .campo textarea:focus,
        .campo select:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .campo textarea {
            height: 120px;
            resize: vertical;
        }

        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 12px;
            font-weight: 500;
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

        /* ======================== BOTÕES ======================== */
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
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .botao-salvar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(77, 68, 181, 0.3);
        }

        .botao-cancelar {
            background-color: #e0e0e0;
            color: #333;
            padding: 12px 25px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .botao-cancelar:hover {
            background-color: #d0d0d0;
            transform: translateY(-2px);
        }

        .botao-excluir {
            background-color: #dc3545;
            color: white;
            padding: 12px 25px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .botao-excluir:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        /* ======================== ELEMENTOS DECORATIVOS ======================== */
        .decorative-circle {
            position: absolute;
            border-radius: 50%;
            z-index: -1;
        }

        .circle-1 {
            width: 300px;
            height: 300px;
            background: rgba(255, 215, 0, 0.15);
            top: -150px;
            right: -150px;
        }

        .circle-2 {
            width: 200px;
            height: 200px;
            background: rgba(77, 68, 181, 0.15);
            bottom: -100px;
            right: 200px;
        }

        .circle-3 {
            width: 150px;
            height: 150px;
            background: rgba(255, 255, 255, 0.1);
            bottom: 100px;
            left: 350px;
        }

        /* ======================== RODAPÉ ======================== */
        .footer {
            text-align: center;
            padding: 30px;
            color: #4D44B5;
            font-size: 14px;
            margin-top: auto;
        }

        /* ======================== RESPONSIVIDADE ======================== */
        @media (max-width: 1200px) {
            .conteudo-principal {
                padding: 30px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 220px;
            }

            .conteudo-principal {
                margin-left: 220px;
            }

            .header {
                flex-direction: column;
                gap: 20px;
                align-items: flex-start;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                padding: 20px;
            }

            .conteudo-principal {
                margin-left: 0;
                padding: 25px;
            }

            .menu {
                flex-direction: row;
                flex-wrap: wrap;
                margin-top: 20px;
                gap: 10px;
            }

            .menu-btn {
                padding: 12px 15px;
                font-size: 15px;
            }

            .grupo-campos {
                grid-template-columns: 1fr;
            }
        }
        .logout-btn {
                   margin-top: auto; /* Empurra para o final da sidebar */
                   background-color: transparent !important; /* Mantém o fundo normal */
                   color: #ffffff !important; /* Mantém o texto branco */
               }

               .logout-btn:hover {
                   background-color: #ff6b6b !important; /* Vermelho no hover */
                   color: #ffffff !important; /* Texto branco no hover */
               }

               .logout-btn img {
                   filter: brightness(0) invert(1); /* Ícone branco sempre */
               }
    </style>
</head>
<body>
    <!-- Elementos decorativos -->
    <div class="decorative-circle circle-1"></div>
    <div class="decorative-circle circle-2"></div>
    <div class="decorative-circle circle-3"></div>

    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logoAEE.png" alt="Logo AEE+" />
            <h2>AEE +</h2>
        </div>

        <div class="menu">
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/TelaInicial.jsp'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/inicio.svg" alt="Início" />
                Início
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/alunos'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/alunos.svg" alt="Estudantes" />
                Estudantes
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/sessoes.svg" alt="Sessões" />
                Sessões
            </button>
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/planosAEE'">
                <img src="${pageContext.request.contextPath}/static/images/meuplano.svg" alt="Planos AEE" />
                Planos AEE
            </button>
            <button class="menu-btn logout-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/Logout.svg" alt="Sair" />
                Sair
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div class="header">
            <div class="titulo">
                <h1>Editar Plano de Atendimento Educacional Especializado</h1>
            </div>
        </div>

        <div class="conteudo-container">
            <c:if test="${not empty success}">
                <div class="alert alert-sucesso">${success}</div>
            </c:if>
            <c:if test="${not empty erro}">
                <div class="alert alert-erro">${erro}</div>
            </c:if>

            <form class="form-plano" action="${pageContext.request.contextPath}/templates/aee/planoAEE/atualizar" method="post">
                <!-- Campo oculto para o ID do Plano -->
                <input type="hidden" name="id" value="${plano.id}" />

                <div class="grupo-campos">
                    <div class="campo">
                        <label for="professor_siape">Professor Responsável:</label>
                        <select name="professor_siape" id="professor_siape">
                            <option value="">Selecione um professor</option>
                            <c:forEach var="professor" items="${professores}">
                                <option value="${professor.siape}"
                                    ${plano.professorAEE.siape == professor.siape ? 'selected' : ''}>
                                    ${professor.nome}
                                </option>
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
                            <option value="${aluno.matricula}" readonly>${aluno.nome}</option>
                         
                        </select>

                    </div>

                    <div class="campo">
                        <label for="dataInicio">Data de Início:</label>
                        <input type="date" id="dataInicio" name="dataInicio"
                               value="${plano.dataInicio}" required>
                    </div>
                </div>

                <div class="campo">
                    <label for="recomendacoes">Recomendações:</label>
                    <textarea id="recomendacoes" name="recomendacoes" rows="4"
                              placeholder="Recomendações pedagógicas, estratégias de ensino...">${plano.recomendacoes}</textarea>
                </div>

                <div class="campo">
                    <label for="observacoes">Observações:</label>
                    <textarea id="observacoes" name="observacoes" rows="4"
                              placeholder="Informações relevantes sobre o aluno...">${plano.observacoes}</textarea>
                </div>

                <div class="botoes-acoes">
                    <button type="submit" class="botao-salvar">Atualizar Plano AEE</button>
                    <button type="button" class="botao-cancelar" onclick="window.history.back()">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
    <!-- Rodapé -->
    <div class="footer">
        <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
        <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
    </div>

    <script>
        function confirmarExclusao() {
            if(confirm('Tem certeza que deseja excluir este plano? Esta ação não pode ser desfeita.')) {
                window.location.href = '/plano/excluir?id=${plano.id}';
            }
        }
    </script>
</body>
</html>