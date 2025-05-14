<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sessões de Atendimento</title>
    <link rel="stylesheet" href="PorSessao.css">
</head>
<style>@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    body{
        background-color: #f9f9ff;
        overflow-x: hidden; /* impede rolagem horizontal */
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
        color: #4D44B5; /* ou a cor desejada para o texto ativo */
    }

    #titulo h2 {
        color: rgb(12, 12, 97);
        font-size: 28px;
        margin-left: 350px; /* substitui o left fixo */
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

    /* Linha do botão */
    .linha-superior {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 30px;
    }

    /* Botão Nova Sessão */
    .botao-nova-sessao {
        background-color: #4D44B5;
        color: #ffffff;
        border: none;
        padding: 10px 22px;
        border-radius: 10px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s;
    }

    .botao-nova-sessao:hover {
        background-color: #372e9c;
    }

    form label {
        font-weight: 600;
        color: #2c3e50;
        font-size: 14px;
    }

    form select,
    form input[type="text"],
    form input[type="date"],
    form input[type="time"] {
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

    .modal-conteudo button[type="submit"] {
        background-color: #4D44B5;
        color: #ffffff;
        border: none;
        padding: 10px 18px;
        border-radius: 8px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-right: 10px;
    }

    .modal-conteudo button[type="submit"]:hover {
        background-color: #372e9c;
    }

    .modal-conteudo button:not([type="submit"]) {
        background-color: #e0e0e0;
        color: #333;
        border: none;
        padding: 10px 18px;
        border-radius: 8px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .modal-conteudo button:not([type="submit"]):hover {
        background-color: #cfcfcf;
    }

    .sessao-status {
        display: flex;
        justify-content: space-between;
        align-items: center;
        gap: 12px;
        position: relative;

        border-radius: 6px;
        padding: 10px 12px;
        width: 100%;
        box-sizing: border-box;
    }

    .botao-dropdown {
        background: transparent;
        border: none;
        cursor: pointer;
        margin-left: 8px;
    }

    .icone-dropdown {
        width: 14px;
        height: 14px;
    }

    /* Botões de ação empilhados à direita */
    .botoes-acoes {
        display: flex;
        flex-direction: column;
        gap: 6px;
        margin-left: auto;
    }

    .botoes-acoes button {
        padding: 4px 10px;
        font-size: 13px;
        border: none;
        border-radius: 4px;
        color: white;
        cursor: pointer;
        width: 70px;
    }

    .botao-editar {
        background-color: #007bff;
    }

    .botao-excluir {
        background-color: #dc3545;
    }

    .botao-editar:hover {
        background-color: #0056b3;
    }

    .botao-excluir:hover {
        background-color: #c82333;
    }

    .overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      backdrop-filter: blur(5px);
      background-color: rgba(0, 0, 0, 0.4);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 999;
    }

    /* Tabela */
    .tabela-sessoes {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
        border-radius: 8px;
        overflow: hidden;
    }

    /* Cabeçalho */
    .tabela-sessoes th {
        background-color: #ecf0f1;
        color: #2c3e50;
        text-align: left;
        padding: 14px;
    }

    /* Células */
    .tabela-sessoes td {
        background-color: #ffffff;
        padding: 14px;
        border-bottom: 1px solid #e0e0e0;
    }

    /* Filtros */
    .linha-filtro input,
    .linha-filtro select {
        width: 100%;
        padding: 8px;
        font-size: 13px;
        border: 1px solid #ccc;
        border-radius: 6px;
        background-color: #fefefe;
    }

    /* Botão Filtrar */
    .botao-filtrar {
        background-color: #1abc9c;
        color: white;
        border: none;
        padding: 8px 12px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
    }

    .botao-filtrar:hover {
        background-color: #16a085;
    }

    .presenca-status {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-weight: 500;
    }

    .botao-dropdown {
        background: none;
        border: none;
        padding: 0;
        margin-left: 6px;
        cursor: pointer;
    }

    .icone-dropdown {
        width: 12px;
        height: 12px;
        transition: transform 0.3s ease;
    }

    /* Gira o ícone ao expandir */
    .botao-dropdown.ativo .icone-dropdown {
        transform: rotate(180deg);
    }

    .conteudo-detalhes {
        background-color: #f4f4fc;
        padding: 16px;
        border-radius: 10px;
        font-size: 14px;
        color: #333;
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
        padding: 30px;
        border-radius: 16px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        width: 400px;
        text-align: center;
    }

    .modal-conteudo h3 {
        margin-bottom: 20px;
        color: #2c3e50;
    }

    .modal-conteudo button {
        margin-top: 20px;
        background-color: #e74c3c;
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 8px;
        cursor: pointer;
    }

    .modal-conteudo button:hover {
        background-color: #c0392b;
    }

    .conteudo-detalhes {
        padding: 8px;
        font-family: Arial, sans-serif;
    }

    .conteudo-detalhes textarea {
        width: 100%;
        min-height: 80px;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
        background-color: #fafafa;
        resize: vertical;
        transition: border-color 0.2s ease;
        outline: none;
    }

    .conteudo-detalhes textarea:focus {
        border-color: #007bff;
        background-color: #fff;
    }

    .conteudo-detalhes textarea::placeholder {
        color: transparent; /* Remove o placeholder */
    }
    </style>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="Group 167.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='AlunoCriar.jsp'">Estudantes</button>
            <button class="menu-btn">Professores</button>
            <button class="menu-btn ativo">Sessões</button>
            <button class="menu-btn">Usuários</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Sessões de Atendimento</h2>
    </div>

    <div class="conteudo-principal">
        <div class="linha-superior">
            <button class="botao-nova-sessao">+ Nova Sessão</button>
        </div>

        <!-- Modal Nova Sessão -->
        <div class="modal-overlay" id="modalNovaSessao">
            <div class="modal-conteudo">
                <h3>Criar Nova Sessão</h3>
                <form id="formNovaSessao" action="${pageContext.request.contextPath}/sessoes?acao=criar" method="POST">
                    <label for="aluno">Nome do Aluno:</label><br>
                    <input type="text" id="aluno" name="aluno" required list="listaAlunos">
                    <datalist id="listaAlunos">
                        <c:forEach items="${todosAlunos}" var="aluno">
                            <option value="${aluno.nome}">
                        </c:forEach>
                    </datalist><br><br>

                    <label for="data">Data:</label><br>
                    <input type="date" id="data" name="data" required><br><br>

                    <label for="horario">Horário:</label><br>
                    <input type="time" id="horario" name="horario" required><br><br>

                    <label for="local">Local:</label><br>
                    <input type="text" id="local" name="local" required><br><br>

                    <div class="botoes-modal">
                        <button type="submit">Salvar</button>
                        <button type="button" onclick="fecharModal(modalNovaSessao)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabela de Sessões -->
        <table class="tabela-sessoes">
            <thead>
                <tr>
                    <th>Aluno</th>
                    <th>Data</th>
                    <th>Horário</th>
                    <th>Local</th>
                    <th>Presença</th>
                </tr>
                <tr class="linha-filtro">
                    <th><input type="text" name="filtroAluno" placeholder="Nome do aluno"></th>
                    <th><input type="date" name="filtroData"></th>
                    <th><input type="time" name="filtroHorario"></th>
                    <th><input type="text" name="filtroLocal" placeholder="Local"></th>
                    <th>
                        <select name="filtroPresenca">
                            <option value="">Todos</option>
                            <option value="true">Presente</option>
                            <option value="false">Ausente</option>
                        </select>
                    </th>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${sessoeslista}" var="sessao">
                    <tr data-id="${sessao.id}" id="linha-${sessao.id}">
                        <td>${sessao.aluno.nome}</td>
                        <td>${sessao.data}</td>
                        <td>${sessao.horario}</td>
                        <td>${sessao.local}</td>
                        <td>
                            <div class="sessao-status">
                                <span class="${sessao.presenca ? 'texto-presente' : 'texto-ausente'}">
                                    ${sessao.presenca ? 'Presente' : 'Ausente'}
                                </span>
                                <button class="botao-dropdown" onclick="toggleDetalhes(this)">
                                    <img src="dropdown.svg" alt="seta" class="icone-dropdown">
                                </button>

                                <div class="botoes-acoes">
                                    <button class="botao-editar"
                                            onclick="abrirEdicao(${sessao.id})">Editar</button>
                                    <button class="botao-excluir"
                                            onclick="confirmarExclusao(${sessao.id})">Excluir</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="linha-detalhes" style="display: none;">
                        <td colspan="6">
                            <div class="conteudo-detalhes">
                                <p><strong>Observações:</strong> ${sessao.observacoes}</p>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Modal Edição -->
        <div class="modal-overlay" id="modalEditar">
            <div class="modal-conteudo">
                <h2>Editar Sessão</h2>
                <form id="formEditarSessao" action="${pageContext.request.contextPath}/sessoes?acao=atualizar" method="POST">
                    <input type="hidden" name="id" id="idEditar">

                    <label for="alunoEditar">Aluno:</label><br>
                    <input type="text" id="alunoEditar" name="aluno" readonly><br><br>

                    <label for="dataEditar">Data:</label><br>
                    <input type="date" id="dataEditar" name="data" required><br><br>

                    <label for="horarioEditar">Horário:</label><br>
                    <input type="time" id="horarioEditar" name="horario" required><br><br>

                    <label for="localEditar">Local:</label><br>
                    <input type="text" id="localEditar" name="local" required><br><br>

                    <label for="presencaEditar">Presença:</label><br>
                    <select id="presencaEditar" name="presenca">
                        <option value="true">Presente</option>
                        <option value="false">Ausente</option>
                    </select><br><br>

                    <div class="botoes-modal">
                        <button type="submit">Salvar</button>
                        <button type="button" onclick="fecharModal(modalEditar)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Modal Confirmação Exclusão -->
        <div class="modal-overlay" id="modalExcluir">
            <div class="modal-conteudo">
                <h3>Confirmar Exclusão</h3>
                <p>Tem certeza que deseja excluir esta sessão?</p>
                <form id="formExcluirSessao" action="${pageContext.request.contextPath}/sessoes?acao=excluir" method="POST">
                    <input type="hidden" name="id" id="idExcluir">
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
            nova: document.getElementById('modalNovaSessao'),
            editar: document.getElementById('modalEditar'),
            excluir: document.getElementById('modalExcluir')
        };

        // Abrir modais
        document.querySelector('.botao-nova-sessao').addEventListener('click', () => {
            modais.nova.style.display = 'flex';
        });

        function abrirEdicao(id) {
            console.log("Editando sessão ID:", id);

            // 1. Encontra a linha da tabela correspondente
            const linha = document.getElementById("linha-"+id);
            if (!linha) {
                console.error("Sessão não encontrada");
                return;
            }

            // 2. Extrai os dados das células
            const celulas = linha.cells;
            const dados = {
                aluno: celulas[0].textContent.trim(),
                dataBr: celulas[1].textContent.trim(),
                horario: celulas[2].textContent.trim(),
                local: celulas[3].textContent.trim(),
                presenca: celulas[4].querySelector('.sessao-status span').textContent.includes("Presente")
            };

            // 3. Converte a data para o formato yyyy-MM-dd (obrigatório para input type="date")
            const [dia, mes, ano] = dados.dataBr.split('/');
            const dataInput = `${ano}-${mes.padStart(2, '0')}-${dia.padStart(2, '0')}`;
            document.getElementById('dataEditar').value = dataInput.trim();


            // 4. Preenche os campos do formulário
            document.getElementById('idEditar').value = id;
            document.getElementById('alunoEditar').value = dados.aluno;
            document.getElementById('dataEditar').value = dataInput;
            document.getElementById('horarioEditar').value = dados.horario;
            document.getElementById('localEditar').value = dados.local;
            document.getElementById('presencaEditar').value = dados.presenca;

            // 5. Abre o modal
            document.getElementById('modalEditar').style.display = 'flex';
        }

        function confirmarExclusao(id) {
            document.getElementById('idExcluir').value = id;
            modais.excluir.style.display = 'flex';
        }

        // Fechar modais
        function fecharModal(modal) {
            modal.style.display = 'none';
        }

        // Fechar ao clicar fora
        window.onclick = function(event) {
            Object.values(modais).forEach(modal => {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            });
        }

        // Controle dos Detalhes
        function toggleDetalhes(botao) {
            const linhaDetalhes = botao.closest('tr').nextElementSibling;
            linhaDetalhes.style.display = linhaDetalhes.style.display === 'none' ? 'table-row' : 'none';
        }
    </script>
</body>
</html>