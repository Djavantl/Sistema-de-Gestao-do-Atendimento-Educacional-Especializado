<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestão de Professores</title>
    <style>
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

        /* ======================== TABELA ======================== */
        .linha-superior {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
        }

        .botao-novo-professor {
            background-color: #4D44B5;
            color: #fff;
            border: none;
            padding: 12px 22px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        }

        .botao-novo-professor:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .tabela-professores {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 16px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .tabela-professores th {
            background-color: #4D44B5;
            color: white;
            text-align: left;
            padding: 16px 20px;
            font-weight: 600;
        }

        .tabela-professores td {
            background-color: #fff;
            padding: 14px 20px;
            border-bottom: 1px solid #f0f0f0;
        }

        .tabela-professores tr:last-child td {
            border-bottom: none;
        }

        .tabela-professores tr:hover td {
            background-color: #f9f9ff;
        }

        .botoes-acoes {
            display: flex;
            gap: 10px;
        }

        .botao-detalhes {
            background-color: #e0e0e0;
            color: #333;
            border: none;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-detalhes:hover {
            background-color: #d0d0d0;
            transform: translateY(-2px);
        }

        .botao-editar {
            background-color: #6a5fcc;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-editar:hover {
            background-color: #554bbd;
            transform: translateY(-2px);
        }

        .botao-excluir {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 8px 16px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .botao-excluir:hover {
            background-color: #c82333;
            transform: translateY(-2px);
        }

        /* ======================== MODAIS ======================== */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            backdrop-filter: blur(4px);
            background-color: rgba(0, 0, 0, 0.3);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }

        .modal-conteudo {
            background-color: #fff;
            border-radius: 20px;
            width: 650px;
            max-width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            padding: 30px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }

        .modal-conteudo h3 {
            text-align: center;
            margin-bottom: 25px;
            color: #4D44B5;
            font-size: 26px;
            font-weight: 700;
        }

        .section-group {
            margin-bottom: 30px;
        }

        .section-group h4 {
            font-size: 18px;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 2px solid #f0f0f0;
            color: #4D44B5;
            font-weight: 600;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }

        .input-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 18px;
        }

        .input-group label {
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 15px;
            color: #555;
        }

        .input-group input,
        .input-group select {
            padding: 12px 16px;
            font-size: 15px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #fafafa;
            transition: all 0.3s ease;
        }

        .input-group input:focus,
        .input-group select:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        .botoes-modal {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 20px;
        }

        .botoes-modal button[type="submit"] {
            background-color: #4D44B5;
            color: #fff;
            border: none;
            padding: 12px 28px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .botoes-modal button[type="submit"]:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(77, 68, 181, 0.3);
        }

        .botoes-modal button[type="button"] {
            background-color: #e0e0e0;
            color: #333;
            border: none;
            padding: 12px 28px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .botoes-modal button[type="button"]:hover {
            background-color: #cfcfcf;
            transform: translateY(-2px);
        }

        /* Modal Exclusão */
        #modalExcluir .modal-conteudo {
            text-align: center;
            padding: 40px;
        }

        #modalExcluir p {
            font-size: 18px;
            margin-bottom: 30px;
            color: #555;
            line-height: 1.6;
        }

        #modalExcluir .botoes-modal {
            justify-content: center;
        }

        /* ======================== DETALHES EXPANDIDOS ======================== */
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
            padding: 16px;
            background-color: #f9f9ff;
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
            margin-top: 40px;
        }

        /* ======================== RESPONSIVIDADE ======================== */
        @media (max-width: 1200px) {
            .conteudo-principal {
                padding: 30px;
            }

            .form-grid {
                grid-template-columns: 1fr;
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

            .botoes-acoes {
                flex-wrap: wrap;
            }
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
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/professores'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/professores.svg" alt="Professores" />
                Professores
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/sessoes.svg" alt="Sessões" />
                Sessões
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/planosAEE'">
                <img src="${pageContext.request.contextPath}/static/images/meuplano.svg" alt="Planos AEE" />
                Planos AEE
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/relatorios'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/relatorios.svg" alt="Relatórios" />
                Relatórios
            </button>
        </div>
    </div>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div class="header">
            <div class="titulo">
                <h1>Gestão de Professores</h1>
            </div>
            <div class="user-info">
                <p>Bem-vindo(a), Professor!</p>
                <div class="funcao">${nome}</div>
            </div>
        </div>

        <div class="conteudo-container">
            <div class="linha-superior">
                <button class="botao-novo-professor">+ Novo Professor</button>
            </div>

            <!-- === Modal Novo Professor === -->
            <div class="modal-overlay" id="modalNovoProfessor">
                <div class="modal-conteudo">
                    <h3>Cadastrar Novo Professor</h3>
                    <form id="formNovoProfessor" action="${pageContext.request.contextPath}/templates/aee/professores?acao=criar" method="POST">
                        <!-- Seção: Informações Pessoais -->
                        <div class="section-group">
                            <h4>Informações Pessoais</h4>
                            <div class="form-grid">
                                <!-- Nome (linha inteira) -->
                                <div class="input-group full-width">
                                    <label for="nome">Nome Completo:</label>
                                    <input type="text" id="nome" name="nome" required>
                                </div>

                                <!-- Data de Nascimento -->
                                <div class="input-group">
                                    <label for="dataNascimento">Data de Nascimento:</label>
                                    <input type="date" id="dataNascimento" name="dataNascimento" required>
                                </div>

                                <!-- Sexo -->
                                <div class="input-group">
                                    <label for="sexo">Sexo:</label>
                                    <select id="sexo" name="sexo">
                                        <option value="Masculino">Masculino</option>
                                        <option value="Feminino">Feminino</option>
                                        <option value="Outro">Outro</option>
                                    </select>
                                </div>

                                <!-- Naturalidade -->
                                <div class="input-group">
                                    <label for="naturalidade">Naturalidade:</label>
                                    <input type="text" id="naturalidade" name="naturalidade">
                                </div>

                                <!-- SIAPE -->
                                <div class="input-group">
                                    <label for="siape">SIAPE:</label>
                                    <input type="text" id="siape" name="siape" required>
                                </div>

                                <!-- Especialidade -->
                                <div class="input-group">
                                    <label for="especialidade">Especialidade:</label>
                                    <input type="text" id="especialidade" name="especialidade" required>
                                </div>

                                <!-- E-mail (linha inteira) -->
                                <div class="input-group full-width">
                                    <label for="email">Email:</label>
                                    <input type="email" id="email" name="email" required>
                                </div>

                                <!-- Telefone -->
                                <div class="input-group">
                                    <label for="telefone">Telefone:</label>
                                    <input type="text" id="telefone" name="telefone">
                                </div>
                            </div>
                        </div>

                        <div class="botoes-modal">
                            <button type="submit">Salvar</button>
                            <button type="button" onclick="fecharModal(modalNovoProfessor)">Cancelar</button>
                        </div>
                    </form>
                </div>
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
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty professoresLista}">
                            <tr>
                                <td colspan="6">Nenhum professor encontrado.</td>
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
                                    <td>${professor.especialidade}</td>
                                    <td>
                                        <div class="botoes-acoes">
                                            <button class="botao-editar"
                                                onclick="abrirEdicao(this, '${professor.siape}')">Editar</button>
                                            <button class="botao-excluir"
                                                onclick="confirmarExclusao('${professor.siape}')">Excluir</button>
                                            <button class="botao-detalhes"
                                                onclick="toggleDetalhes(this)">Detalhes</button>
                                        </div>
                                    </td>
                                </tr>

                                <!-- Linha de detalhes -->
                                <tr class="linha-detalhes">
                                    <td colspan="6">
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
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- === Modal Editar Professor === -->
            <div class="modal-overlay" id="modalEditar">
                <div class="modal-conteudo">
                    <h3>Editar Professor</h3>
                    <form id="formEditarProfessor" action="${pageContext.request.contextPath}/templates/aee/professores?acao=atualizar" method="POST">
                        <input type="hidden" name="siape" id="editSiape">

                        <!-- Seção: Informações Pessoais -->
                        <div class="section-group">
                            <h4>Informações Pessoais</h4>
                            <div class="form-grid">
                                <!-- Nome (linha inteira) -->
                                <div class="input-group full-width">
                                    <label for="editNome">Nome Completo:</label>
                                    <input type="text" id="editNome" name="nome" required>
                                </div>

                                <!-- Data de Nascimento -->
                                <div class="input-group">
                                    <label for="editDataNascimento">Data de Nascimento:</label>
                                    <input type="date" id="editDataNascimento" name="dataNascimento" required>
                                </div>

                                <!-- Sexo -->
                                <div class="input-group">
                                    <label for="editSexo">Sexo:</label>
                                    <select id="editSexo" name="sexo">
                                        <option value="Masculino">Masculino</option>
                                        <option value="Feminino">Feminino</option>
                                        <option value="Outro">Outro</option>
                                    </select>
                                </div>

                                <!-- Naturalidade -->
                                <div class="input-group">
                                    <label for="editNaturalidade">Naturalidade:</label>
                                    <input type="text" id="editNaturalidade" name="naturalidade">
                                </div>

                                <!-- SIAPE -->
                                <div class="input-group">
                                    <label for="editSiape">SIAPE:</label>
                                    <input type="text" id="editSiape" name="siape" required disabled>
                                </div>

                                <!-- Especialidade -->
                                <div class="input-group">
                                    <label for="editEspecialidade">Especialidade:</label>
                                    <input type="text" id="editEspecialidade" name="especialidade" required>
                                </div>

                                <!-- E-mail (linha inteira) -->
                                <div class="input-group full-width">
                                    <label for="editEmail">Email:</label>
                                    <input type="email" id="editEmail" name="email" required>
                                </div>

                                <!-- Telefone -->
                                <div class="input-group">
                                    <label for="editTelefone">Telefone:</label>
                                    <input type="text" id="editTelefone" name="telefone">
                                </div>
                            </div>
                        </div>

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
                    <p>Tem certeza que deseja excluir este professor? Esta ação não pode ser desfeita.</p>
                    <form id="formExcluirProfessor" action="${pageContext.request.contextPath}/templates/aee/professores?acao=excluir" method="POST">
                        <input type="hidden" name="siape" id="siapeExcluir">
                        <div class="botoes-modal">
                            <button type="submit">Confirmar Exclusão</button>
                            <button type="button" onclick="fecharModal(modalExcluir)">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>

    <script>
        // Controle dos Modais
        const modais = {
            novo: document.getElementById('modalNovoProfessor'),
            editar: document.getElementById('modalEditar'),
            excluir: document.getElementById('modalExcluir')
        };

        document.querySelector('.botao-novo-professor').addEventListener('click', () => {
            modais.novo.style.display = 'flex';
        });

        function abrirEdicao(botaoEditar, siape) {
            const linha = botaoEditar.closest('tr');
            const linhaDetalhes = linha.nextElementSibling;
            const detalhes = linhaDetalhes.querySelector('.detalhes-grid');

            // Preenche os campos do formulário
            document.getElementById('editSiape').value = siape;
            document.getElementById('editNome').value = linha.cells[0].textContent;
            document.getElementById('editSiape').value = linha.cells[1].textContent;
            document.getElementById('editEmail').value = linha.cells[2].textContent;
            document.getElementById('editTelefone').value = linha.cells[3].textContent;
            document.getElementById('editEspecialidade').value = linha.cells[4].textContent;

            // Preenche detalhes
            const detalhesItems = detalhes.querySelectorAll('.detalhe-item');
            document.getElementById('editDataNascimento').value = detalhesItems[0].querySelector('.detalhe-valor').textContent;
            document.getElementById('editSexo').value = detalhesItems[1].querySelector('.detalhe-valor').textContent;
            document.getElementById('editNaturalidade').value = detalhesItems[2].querySelector('.detalhe-valor').textContent;

            // Abre o modal
            modais.editar.style.display = 'flex';
        }

        function confirmarExclusao(siape) {
            document.getElementById('siapeExcluir').value = siape;
            modais.excluir.style.display = 'flex';
        }

        function fecharModal(modal) {
            modal.style.display = 'none';
        }

        function toggleDetalhes(botao) {
            const linha = botao.closest('tr');
            const linhaDetalhes = linha.nextElementSibling;

            // Alternar visibilidade da linha de detalhes
            linhaDetalhes.classList.toggle('visible');

            // Alterar texto do botão
            if (linhaDetalhes.classList.contains('visible')) {
                botao.textContent = 'Ocultar';
            } else {
                botao.textContent = 'Detalhes';
            }
        }

        window.onclick = function(event) {
            Object.values(modais).forEach(modalDiv => {
                if (event.target === modalDiv) {
                    modalDiv.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>