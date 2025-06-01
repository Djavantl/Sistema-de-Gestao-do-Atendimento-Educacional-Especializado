<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professores</title>
    <style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f9f9ff;
            overflow-x: hidden;
            font-family: Arial, sans-serif;
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

        #titulo h2 {
            color: #0c0c61;
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

        .linha-superior {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 30px;
        }

        .botao-novo-professor {
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s;
        }

        .botao-novo-professor:hover {
            background-color: #372e9c;
        }

        form label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
            display: block;
            margin-top: 10px;
        }

        form select,
        form input[type="text"],
        form input[type="date"],
        form input[type="email"],
        form input[type="tel"] {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-top: 4px;
            margin-bottom: 16px;
            background-color: #fefefe;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        form select:focus,
        form input:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .tabela-professores {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        .tabela-professores th {
            background-color: #ecf0f1;
            color: #2c3e50;
            text-align: left;
            padding: 14px;
        }

        .tabela-professores td {
            background-color: #ffffff;
            padding: 14px;
            border-bottom: 1px solid #e0e0e0;
        }

        .linha-filtro input,
        .linha-filtro select {
            width: 100%;
            padding: 8px;
            font-size: 13px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #fefefe;
        }

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
            z-index: 1000;
        }

        .modal-conteudo {
            background-color: #ffffff;
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            margin: 20px;
        }

        .botoes-modal {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            gap: 10px;
        }

        .botoes-modal button{
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s;
        }

        .container-especialidade {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .especialidade-texto {
            flex-grow: 1;
            min-width: 0;
        }

        .container-acoes {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
            margin-top: 8px;
        }

        .botao-acao {
            padding: 6px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 13px;
        }

        .botao-acao i {
            font-size: 12px;
        }

        .botao-editar {
            background-color: #4D44B5;
            color: white;
        }

        .botao-editar:hover {
            background-color: #3a328a;
        }

        .botao-excluir {
            background-color: #dc3545;
            color: white;
        }

        .botao-excluir:hover {
            background-color: #bb2d3b;
        }

        .botao-detalhes {
            background-color: #e9ecef;
            color: #495057;
        }

        .botao-detalhes:hover {
            background-color: #dee2e6;
        }

        .botao-detalhes .icone-seta {
            transition: transform 0.3s ease;
            display: inline-block;
        }

        .botao-detalhes.ativo .icone-seta {
            transform: rotate(180deg);
        }

        .linha-detalhes {
            display: none;
        }

        .linha-detalhes.visible {
            display: table-row;
        }

        .detalhes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            padding: 8px;
        }

        .detalhe-item {
            display: flex;
            flex-direction: column;
        }

        .detalhe-label {
            font-weight: 600;
            color: #4D44B5;
            margin-bottom: 4px;
            font-size: 13px;
        }

        .detalhe-valor {
            color: #495057;
            font-size: 14px;
        }

        .erro {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #dc3545;
            color: white;
            padding: 15px;
            border-radius: 5px;
            z-index: 10000;
        }

        @media (max-width: 768px) {
            .container-acoes {
                flex-wrap: wrap;
                justify-content: flex-start;
            }

            .botao-acao {
                flex: 1 1 45%;
            }

            .especialidade-texto {
                width: 100%;
                margin-bottom: 8px;
            }

            #titulo h2 {
                margin-left: 20px;
                font-size: 1.5rem;
            }

            .conteudo-principal {
                margin: 100px 20px 40px;
                width: auto;
            }

            .modal-conteudo {
                padding: 15px;
                width: 95%;
            }
        }

        .botao-acao i {
            margin-right: 5px;
        }

        .botao-detalhes.ativo .icone-seta {
            transform: rotate(180deg);
            transition: transform 0.3s ease;
        }

        /* Modal de Exclusão - Estilo Consistente */
        #modalExcluir .modal-conteudo {
            border-top: 3px solid #4D44B5; /* Roxo principal */
        }

        #modalExcluir h3 {
            color: #4D44B5; /* Roxo do tema */
            border-bottom: 2px solid #ecf0f1; /* Cinza claro da tabela */
        }

        #modalExcluir p {
            color: #6c757d; /* Cinza médio padrão */
        }

        #modalExcluir .botoes-modal button[type="submit"] {
            background-color: #4D44B5; /* Roxo principal */
            border-color: #4D44B5;
        }

        #modalExcluir .botoes-modal button[type="submit"]:hover {
            background-color: #3b32a0; /* Roxo mais escuro */
            border-color: #3b32a0;
        }

        #modalExcluir .botoes-modal button[type="button"] {
            background-color: #6c757d; /* Cinza dos botões */
            border-color: #6c757d;
            color: #ffffff;
        }

        #modalExcluir .botoes-modal button[type="button"]:hover {
            background-color: #5a6268; /* Cinza hover */
            border-color: #5a6268;
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
            <button class="menu-btn ativo">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professoresAEE'">Professores AEE</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Professores</h2>
    </div>

    <div class="conteudo-principal">
        <div class="linha-superior">
            <button class="botao-novo-professor">+ Novo Professor</button>
        </div>

        <!-- Modal Novo Professor -->
        <div class="modal-overlay" id="modalNovoProfessor">
            <div class="modal-conteudo">
                <h2>Cadastrar Novo Professor</h2>
                <form id="formNovoProfessor"
                      action="${pageContext.request.contextPath}/templates/aee/professores?acao=criar"
                      method="POST">
                    <label for="nome">Nome Completo:</label>
                    <input type="text" id="nome" name="nome" required>

                    <label for="dataNascimento">Data de Nascimento:</label>
                    <input type="date" id="dataNascimento" name="dataNascimento" required>

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>

                    <label for="sexo">Sexo:</label>
                    <select id="sexo" name="sexo" required>
                        <option value="">Selecione</option>
                        <option value="Masculino">Masculino</option>
                        <option value="Feminino">Feminino</option>
                        <option value="Outro">Outro</option>
                    </select>

                    <label for="naturalidade">Naturalidade:</label>
                    <input type="text" id="naturalidade" name="naturalidade">

                    <label for="telefone">Telefone:</label>
                    <input type="tel" id="telefone" name="telefone">

                    <label for="siape">SIAPE:</label>
                    <input type="text" id="siape" name="siape" required>

                    <label for="especialidade">Especialidade:</label>
                    <input type="text" id="especialidade" name="especialidade" required>

                    <div class="botoes-modal">
                        <button type="submit">Salvar</button>
                        <button type="button" onclick="fecharModal(modalNovoProfessor)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
         <%-- Linha de debug --%>
            <div style="display: none;">
                ProfessoresLista: ${not empty professoresLista} | Tamanho: ${professoresLista.size()}
            </div>
        <!-- Tabela de Professores -->
            <table class="tabela-professores">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>SIAPE</th>
                        <th>Email</th>
                        <th>Telefone</th>
                        <th>Especialidade</th>
                        <th style="width: 180px">Ações</th>
                    </tr>
                    <tr class="linha-filtro">
                        <th><input type="text" placeholder="Nome"></th>
                        <th><input type="text" placeholder="SIAPE"></th>
                        <th><input type="text" placeholder="Email"></th>
                        <th><input type="text" placeholder="Telefone"></th>
                        <th><input type="text" placeholder="Especialidade"></th>
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    <c:choose>
                        <c:when test="${empty professoresLista}">
                            <tr>
                                <td colspan="5">Nenhum professor encontrado.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${professoresLista}" var="professor">
                                <!-- Linha principal -->
                                <tr class="linha-principal" data-id="${professor.siape}">
                                    <td>${professor.nome}</td>
                                    <td>${professor.siape}</td>
                                    <td>${professor.email}</td>
                                    <td>${professor.telefone}</td>
                                    <td>${professor.especialidade}</td> <!-- Apenas texto -->
                                    <td>
                                        <div class="container-acoes">
                                            <button class="botao-acao botao-editar"
                                                onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/professores?acao=editar&siape=${professor.siape}'">
                                                 Editar
                                            </button>
                                            <button class="botao-acao botao-excluir" onclick="confirmarExclusao('${professor.siape}')">
                                                Excluir
                                            </button>
                                            <button class="botao-acao botao-detalhes" onclick="toggleDetalhes(this)">
                                                 Detalhes
                                            </button>
                                        </div>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/templates/professor/professor-alunos?siape=${professor.siape}">
                                          Ver Alunos
                                        </a>
                                    </td>
                                </tr>

                                <!-- Linha de detalhes -->
                                <tr class="linha-detalhes">
                                    <td colspan="5">
                                        <div class="detalhes-content">
                                            <div class="detalhes-grid">
                                                <div class="detalhe-item">
                                                    <span class="detalhe-label">Nascimento:</span>
                                                    <span class="detalhe-valor">${professor.dataNascimento}</span>
                                                </div>
                                                <div class="detalhe-item">
                                                    <span class="detalhe-label">Sexo:</span>
                                                    <span class="detalhe-valor">${professor.sexo}</span>
                                                </div>
                                                <div class="detalhe-item">
                                                    <span class="detalhe-label">Naturalidade:</span>
                                                    <span class="detalhe-valor">${professor.naturalidade}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

        <!-- Modal Confirmação Exclusão -->
        <div class="modal-overlay" id="modalExcluir">
            <div class="modal-conteudo">
                <h3>Confirmar Exclusão</h3>
                <p>Tem certeza que deseja excluir este professor?</p>
                <form id="formExcluirProfessor"
                      action="${pageContext.request.contextPath}/templates/aee/professores?acao=excluir"
                      method="POST">
                    <input type="hidden" name="siape" id="siapeExcluir">
                    <div class="botoes-modal">
                        <button type="submit">Confirmar</button>
                        <button type="button" onclick="fecharModal(modalExcluir)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // Controle dos Modais
        const modais = {
            novo: document.getElementById('modalNovoProfessor'),
            editar: document.getElementById('modalEditar'),
            excluir: document.getElementById('modalExcluir')
        };

        // Abrir modais
        document.querySelector('.botao-novo-professor').addEventListener('click', () => {
            modais.novo.style.display = 'flex';
        });

        // Função abrirEdicao corrigida
        function abrirEdicao(siape) {
            const linha = document.querySelector(`tr[data-id="${siape}"]`);
            const detalhes = linha.nextElementSibling.querySelector('.detalhes-content');

            // Preencher formulário com dados corretos
            document.getElementById('nomeEditar').value = linha.cells[0].textContent;
            document.getElementById('siapeEditar').value = siape;
            // ... outros campos ...

            // Mostrar modal
            document.getElementById('modalEditar').style.display = 'flex';
        }

        function confirmarExclusao(siape) {
            document.getElementById('siapeExcluir').value = siape;
            modais.excluir.style.display = 'flex';
        }

        // Fechar modais
        function fecharModal(modal) {
            modal.style.display = 'none';
        }

        function mostrarErro(mensagem) {
            const divErro = document.createElement('div');
            divErro.className = 'erro';
            divErro.textContent = mensagem;
            document.body.appendChild(divErro);
            setTimeout(() => divErro.remove(), 3000);
        }

        // Fechar ao clicar fora
        window.onclick = function(event) {
            Object.values(modais).forEach(modal => {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            });
        }

        // Função toggleDetalhes atualizada
        function toggleDetalhes(botao) {
            const linhaPrincipal = botao.closest('.linha-principal');
            const linhaDetalhes = linhaPrincipal.nextElementSibling;
            const icone = botao.querySelector('.icone-seta');

            linhaDetalhes.classList.toggle('visible');
            icone.style.transform = linhaDetalhes.classList.contains('visible')
                ? 'rotate(180deg)'
                : 'rotate(0deg)';
        }

        // Filtro simplificado
        document.querySelectorAll('.linha-filtro input').forEach(input => {
            input.addEventListener('input', (e) => {
                const colIndex = e.target.parentElement.cellIndex;
                const valor = e.target.value.toLowerCase();

                document.querySelectorAll('.linha-principal').forEach(linha => {
                    const conteudo = linha.cells[colIndex].textContent.toLowerCase();
                    linha.style.display = conteudo.includes(valor) ? '' : 'none';
                });
            });
        });
    </script>
</body>
</html>