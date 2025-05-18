<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatórios</title>
</head>
<style>@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    body{
        background-color: #f9f9ff;
        overflow-x: hidden;
        font-family: Arial, sans-serif;
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

    .menu-btn:hover {
        background-color: rgba(255, 255, 255, 0.15);
    }

    .menu-btn.ativo {
        background-color: #f9f9ff;
        color: #4D44B5;
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
        margin: 80px 0 40px 350px;
        width: 70%;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    }

    .linha-superior {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 30px;
    }

    .botao-novo-relatorio {
        background-color: #4D44B5;
        color: #ffffff;
        border: none;
        padding: 10px 22px;
        border-radius: 10px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s;
    }

    .botao-novo-relatorio:hover {
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
    form textarea {
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

    form textarea {
        min-height: 100px;
        resize: vertical;
    }

    form select:focus,
    form input:focus,
    form textarea:focus {
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

    .relatorio-status {
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

    .tabela-relatorios {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
        border-radius: 8px;
        overflow: hidden;
    }

    .tabela-relatorios th {
        background-color: #ecf0f1;
        color: #2c3e50;
        text-align: left;
        padding: 14px;
    }

    .tabela-relatorios td {
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

    .icone-dropdown {
        width: 12px;
        height: 12px;
        transition: transform 0.3s ease;
    }

    .botao-dropdown.ativo .icone-dropdown {
        transform: rotate(180deg);
    }

    .linha-detalhes {
        background-color: #f8f9fa;
    }

    .linha-detalhes td {
        padding: 0 !important;
    }

    .conteudo-detalhes {
        padding: 16px;
        background-color: #f1f3f5;
        border-radius: 0 0 8px 8px;
    }

    .conteudo-detalhes p {
        margin: 8px 0;
        color: #495057;
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
        width: 90%;
        max-width: 500px;
        max-height: 90vh;
        overflow-y: auto;
    }

    .modal-conteudo h2,
    .modal-conteudo h3 {
        margin-bottom: 20px;
        color: #2c3e50;
        text-align: center;
    }

    .botoes-modal {
        display: flex;
        justify-content: flex-end;
        margin-top: 20px;
        gap: 10px;
    }

    @media (max-width: 768px) {
        #titulo h2 {
            margin-left: 20px;
            margin-top: 20px;
        }

        .conteudo-principal {
            margin: 60px 20px 20px;
            width: auto;
        }
    }
</style>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn">Estudantes</button>
            <button class="menu-btn">Professores</button>
            <button class="menu-btn">Sessões</button>
            <button class="menu-btn ativo">Relatórios</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Relatórios</h2>
    </div>

    <div class="conteudo-principal">
        <div class="linha-superior">
            <button class="botao-novo-relatorio">+ Novo Relatório</button>
        </div>

        <!-- Modal Novo Relatório -->
        <div class="modal-overlay" id="modalNovoRelatorio">
            <div class="modal-conteudo">
                <h2>Criar Novo Relatório</h2>
                <form id="formNovoRelatorio" action="${pageContext.request.contextPath}/relatorios?acao=criar" method="POST">
                    <label for="titulo">Título:</label>
                    <input type="text" id="titulo" name="titulo" required>

                    <label for="dataGeracao">Data de Geração:</label>
                    <input type="date" id="dataGeracao" name="dataGeracao" required>

                    <label for="aluno">Aluno:</label>
                    <select id="aluno" name="aluno" required>
                        <option value="">Selecione um aluno</option>
                        <c:forEach items="${todosAlunos}" var="aluno">
                            <option value="${aluno.matricula}">${aluno.nome}</option>
                        </c:forEach>
                    </select>

                    <label for="professorAEE">Professor AEE:</label>
                    <select id="professorAEE" name="professorAEE">
                        <option value="">Selecione um professor</option>
                        <c:forEach items="${todosProfessores}" var="professor">
                            <option value="${professor.siape}">${professor.nome}</option>
                        </c:forEach>
                    </select>

                    <label for="resumo">Resumo:</label>
                    <textarea id="resumo" name="resumo" required></textarea>

                    <label for="observacoes">Observações:</label>
                    <textarea id="observacoes" name="observacoes"></textarea>

                    <div class="botoes-modal">
                        <button type="submit">Salvar</button>
                        <button type="button" onclick="fecharModal(modalNovoRelatorio)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabela de Relatórios -->
        <table class="tabela-relatorios">
            <thead>
                <tr>
                    <th>Título</th>
                    <th>Aluno</th>
                    <th>Data</th>
                    <th>Professor</th>
                    <th>Ações</th>
                </tr>
                <tr class="linha-filtro">
                    <th><input type="text" name="filtroTitulo" placeholder="Título"></th>
                    <th><input type="text" name="filtroAluno" placeholder="Aluno"></th>
                    <th><input type="date" name="filtroData"></th>
                    <th><input type="text" name="filtroProfessor" placeholder="Professor"></th>
                    <th></th>
                </tr>
            </thead>

            <tbody>
                <c:forEach items="${relatoriosLista}" var="relatorio">
                    <tr data-id="${relatorio.id}" id="linha-${relatorio.id}">
                        <td>${relatorio.titulo}</td>
                        <td>${relatorio.aluno.nome}</td>
                        <td>${relatorio.dataGeracao}</td>
                        <td>${relatorio.professorAEE.nome}</td>
                        <td>
                            <div class="relatorio-status">
                                <span>Relatório</span>
                                <button class="botao-dropdown" onclick="toggleDetalhes(this)">
                                    <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTcuNDEsOC41OEwxMiwxMy4xN0wxNi41OSw4LjU4TDE4LDEwTDEyLDE2TDYsMTBMNy40MSw4LjU4WiIgLz48L3N2Zz4=" alt="seta" class="icone-dropdown">
                                </button>

                                <div class="botoes-acoes">
                                    <button class="botao-editar"
                                            onclick="abrirEdicao(${relatorio.id})">Editar</button>
                                    <button class="botao-excluir"
                                            onclick="confirmarExclusao(${relatorio.id})">Excluir</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr class="linha-detalhes" style="display: none;">
                        <td colspan="6">
                            <div class="conteudo-detalhes">
                                <p><strong>Resumo:</strong> ${relatorio.resumo}</p>
                                <p><strong>Observações:</strong> ${relatorio.observacoes}</p>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Modal Edição -->
        <div class="modal-overlay" id="modalEditar">
            <div class="modal-conteudo">
                <h2>Editar Relatório</h2>
                <form id="formEditarRelatorio" action="${pageContext.request.contextPath}/relatorios?acao=atualizar" method="POST">
                    <input type="hidden" name="id" id="idEditar">

                    <label for="tituloEditar">Título:</label>
                    <input type="text" id="tituloEditar" name="titulo" required>

                    <label for="dataGeracaoEditar">Data de Geração:</label>
                    <input type="date" id="dataGeracaoEditar" name="dataGeracao" required>

                    <label for="alunoEditar">Aluno:</label>
                    <input type="text" id="alunoEditar" name="aluno" readonly>

                    <label for="professorAEEEditar">Professor AEE:</label>
                    <input type="text" id="professorAEEEditar" name="professorAEE" readonly>

                    <label for="resumoEditar">Resumo:</label>
                    <textarea id="resumoEditar" name="resumo" required></textarea>

                    <label for="observacoesEditar">Observações:</label>
                    <textarea id="observacoesEditar" name="observacoes"></textarea>

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
                <p>Tem certeza que deseja excluir este relatório?</p>
                <form id="formExcluirRelatorio" action="${pageContext.request.contextPath}/relatorios?acao=excluir" method="POST">
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
            novo: document.getElementById('modalNovoRelatorio'),
            editar: document.getElementById('modalEditar'),
            excluir: document.getElementById('modalExcluir')
        };

        // Abrir modais
        document.querySelector('.botao-novo-relatorio').addEventListener('click', () => {
            modais.novo.style.display = 'flex';
        });

        function abrirEdicao(id) {
            console.log("Editando relatório ID:", id);

            // 1. Encontra a linha da tabela correspondente
            const linha = document.getElementById("linha-"+id);
            if (!linha) {
                console.error("Relatório não encontrado");
                return;
            }

            // 2. Extrai os dados das células
            const celulas = linha.cells;
            const dados = {
                titulo: celulas[0].textContent.trim(),
                aluno: celulas[1].textContent.trim(),
                dataBr: celulas[2].textContent.trim(),
                professor: celulas[3].textContent.trim()
            };

            // 3. Extrai os detalhes expandidos
            const linhaDetalhes = linha.nextElementSibling;
            let resumo = '';
            let observacoes = '';

            if (linhaDetalhes && linhaDetalhes.classList.contains('linha-detalhes')) {
                const detalhes = linhaDetalhes.querySelector('.conteudo-detalhes');
                if (detalhes) {
                    const textos = detalhes.querySelectorAll('p');
                    if (textos.length > 0) resumo = textos[0].textContent.split(':')[1].trim();
                    if (textos.length > 1) observacoes = textos[1].textContent.split(':')[1].trim();
                }
            }

            // 4. Converte a data para o formato yyyy-MM-dd
            const [dia, mes, ano] = dados.dataBr.split('/');
            const dataInput = `${ano}-${mes.padStart(2, '0')}-${dia.padStart(2, '0')}`;

            // 5. Preenche os campos do formulário
            document.getElementById('idEditar').value = id;
            document.getElementById('tituloEditar').value = dados.titulo;
            document.getElementById('dataGeracaoEditar').value = dataInput;
            document.getElementById('alunoEditar').value = dados.aluno;
            document.getElementById('professorAEEEditar').value = dados.professor;
            document.getElementById('resumoEditar').value = resumo;
            document.getElementById('observacoesEditar').value = observacoes;

            // 6. Abre o modal
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

            // Alterna classe ativo no botão
            botao.classList.toggle('ativo');
        }
    </script>
</body>
</html>