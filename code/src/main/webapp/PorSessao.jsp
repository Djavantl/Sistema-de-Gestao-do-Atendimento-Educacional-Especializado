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
        overflow-x: hidden;
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

    .tabela-sessoes {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
        border-radius: 8px;
        overflow: hidden;
    }

    .tabela-sessoes th {
        background-color: #ecf0f1;
        color: #2c3e50;
        text-align: left;
        padding: 14px;
    }

    .tabela-sessoes td {
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
        color: transparent;
    }
    </style>

<body>
    <div class="sidebar">
        <div class="logo">
            <img src="Group 167.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn">Estudantes</button>
            <button class="menu-btn">Professores</button>
            <button class="menu-btn">Sessões</button>
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

        <div class="modal-overlay" id="modalNovaSessao">
            <div class="modal-conteudo">
                <h3>Criar Nova Sessão</h3>
                <form id="formNovaSessao" onsubmit="handleSalvar(event)">
                    <label for="aluno">Nome do Aluno:</label><br>
                    <input type="text" id="aluno" name="aluno"><br><br>

                    <label for="data">Data:</label><br>
                    <input type="date" id="data" name="data"><br><br>

                    <label for="hora">Hora:</label><br>
                    <input type="time" id="hora" name="hora"><br><br>

                    <label for="local">Local:</label><br>
                    <input type="text" id="local" name="local"><br><br>

                    <div class="botoes-modal">
                        <button type="submit">Salvar</button>
                        <button type="button" onclick="fecharModalNovaSessao()">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

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
                    <th><input type="text" name="aluno" placeholder="Nome do aluno" /></th>
                    <th><input type="date" name="data" /></th>
                    <th><input type="time" name="horario" /></th>
                    <th><input type="text" name="local" placeholder="Local" /></th>
                    <th>
                        <select>
                            <option value="">Todos</option>
                            <option value="presente">Presente</option>
                            <option value="ausente">Ausente</option>
                            <option value="pendente">Pendente</option>
                        </select>
                    </th>
                </tr>
            </thead>

            <tbody>
                <tr data-id="123">
                    <td>João Silva</td>
                    <td>04/05/2025</td>
                    <td>14h</td>
                    <td>Sala 3</td>
                    <td>
                        <div class="sessao-status">
                            <span class="texto-pendente">Pendente</span>
                            <button class="botao-dropdown" onclick="toggleDetalhes(this); event.stopPropagation();">
                                <img src="dropdown.svg" alt="seta" class="icone-dropdown">
                            </button>

                            <div class="botoes-acoes">
                                <button class="botao-editar" onclick="editarSessao(this)">Editar</button>
                                <button class="botao-excluir" onclick="excluirSessao(this)">Excluir</button>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr class="linha-detalhes" style="display: none;">
                      <td colspan="6">
                         <div class="conteudo-detalhes">
                             <label for="observacoes"><strong>Observações:</strong></label><br>
                             <textarea id="observacoes" name="observacoes" rows="4" style="width: 100%;">
                             </textarea>
                         </div>
                     </td>
                </tr>

                <tr data-id="123">
                    <td>João Silva</td>
                    <td>04/05/2025</td>
                    <td>14h</td>
                    <td>Sala 3</td>
                    <td>
                        <div class="sessao-status">
                            <span class="texto-pendente">Pendente</span>
                            <button class="botao-dropdown" onclick="toggleDetalhes(this); event.stopPropagation();">
                                <img src="dropdown.svg" alt="seta" class="icone-dropdown">
                            </button>

                            <div class="botoes-acoes">
                                <button class="botao-editar" onclick="editarSessao(this)">Editar</button>
                                <button class="botao-excluir" onclick="excluirSessao(this)">Excluir</button>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr class="linha-detalhes" style="display: none;">
                    <td colspan="6">
                        <div class="conteudo-detalhes">
                            <p><strong>Observações:</strong> João participou ativamente da sessão, demonstrando interesse nas atividades propostas.</p>
                        </div>
                    </td>
                </tr>
            </tbody>

        </table>
    </div>

    <div class="overlay" id="modalOverlay">
    <div class="modal-conteudo">
        <h2>Editar Sessão</h2>
        <form id="formEditarSessao" onsubmit="handleSalvarEditar(event)">
            <label for="alunoEditar">Nome do Aluno:</label><br>
            <input type="text" id="alunoEditar" name="alunoEditar"><br><br>

            <label for="dataEditar">Data:</label><br>
            <input type="date" id="dataEditar" name="dataEditar"><br><br>

            <label for="horaEditar">Hora:</label><br>
            <input type="time" id="horaEditar" name="horaEditar"><br><br>

            <label for="presencaEditar">Presença:</label><br>
            <select id="presencaEditar" name="presencaEditar">
                <option value="presente">Presente</option>
                <option value="ausente">Ausente</option>
                <option value="pendente">Pendente</option>
            </select><br><br>

            <label for="localEditar">Local:</label><br>
            <input type="text" id="localEditar" name="localEditar"><br><br>

            <div class="botoes-modal">
                <button type="submit" class="botao-nova-sessao">Salvar</button>
                <button type="button" onclick="fecharModalEditar()" class="botao-nova-sessao">Cancelar</button>
            </div>
        </form>
    </div>
</div>

<div class="overlay" id="modalExcluirOverlay" style="display: none;">
    <div class="modal-conteudo">
        <h3>Você tem certeza que deseja excluir esta sessão?</h3>
        <div class="botoes-modal">
            <button class="botao-confirmar" onclick="confirmarExclusao()">Confirmar</button>
            <button class="botao-cancelar" onclick="fecharModalExcluir()">Cancelar</button>
        </div>
    </div>
</div>

    <script src="PorSessao.js"></script>
</body>

<script>
    const modalNovaSessao = document.getElementById('modalNovaSessao');
    const botaoNovaSessao = document.querySelector('.botao-nova-sessao');

    botaoNovaSessao.addEventListener('click', () => {
        modalNovaSessao.style.display = 'flex';
    });

    function fecharModalNovaSessao() {
        modalNovaSessao.style.display = 'none';
    }

    const botoesMenu = document.querySelectorAll('.menu-btn');
    botoesMenu.forEach(btn => {
        btn.addEventListener('click', () => {
            botoesMenu.forEach(b => b.classList.remove('ativo'));
            btn.classList.add('ativo');
        });
    });

    function toggleDetalhes(botao) {
        const linhaSessao = botao.closest('tr');
        const linhaDetalhes = linhaSessao.nextElementSibling;

        if (linhaDetalhes.style.display === "none") {
            linhaDetalhes.style.display = "table-row";
            botao.classList.add('ativo');
        } else {
            linhaDetalhes.style.display = "none";
            botao.classList.remove('ativo');
        }
    }

    function editarSessao(btn) {
        const linhaSessao = btn.closest('tr');
        const aluno = linhaSessao.querySelector('td:nth-child(1)').textContent;
        const data = linhaSessao.querySelector('td:nth-child(2)').textContent;
        const hora = linhaSessao.querySelector('td:nth-child(3)').textContent;
        const local = linhaSessao.querySelector('td:nth-child(4)').textContent;

        document.getElementById('alunoEditar').value = aluno;
        document.getElementById('dataEditar').value = data;
        document.getElementById('horaEditar').value = hora;
        document.getElementById('localEditar').value = local;

        const overlay = document.getElementById('modalOverlay');
        overlay.style.display = 'flex';
    }

    function fecharModalEditar() {
        const overlay = document.getElementById('modalOverlay');
        overlay.style.display = 'none';
    }

    let sessaoParaExcluir = null;

    function excluirSessao(botao) {
        const linha = botao.closest('tr');
        const idSessao = linha.getAttribute('data-id');
        sessaoParaExcluir = idSessao;

        document.getElementById('modalExcluirOverlay').style.display = 'flex';
    }

    function confirmarExclusao() {
        if (sessaoParaExcluir !== null) {
            console.log("Sessão a excluir:", sessaoParaExcluir);

            const linha = document.querySelector(`tr[data-id="${sessaoParaExcluir}"]`);
            if (linha) linha.remove();

            fecharModalExcluir();
            sessaoParaExcluir = null;
        }
    }

    function fecharModalExcluir() {
        document.getElementById('modalExcluirOverlay').style.display = 'none';
        sessaoParaExcluir = null;
    }</script>
</html>
