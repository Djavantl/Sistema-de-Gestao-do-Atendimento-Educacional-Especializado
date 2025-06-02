<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestão de Alunos</title>
    <link rel="stylesheet" href="alunos.css">
</head>
<style>
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

/* ----------------- RESET E BASE ----------------- */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    background-color: #f2f4f8;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    overflow-x: hidden;
    color: #333;
}

h2, h3, h4 {
    font-weight: 600;
    color: #2c3e50;
}

/* ----------------- SIDEBAR ----------------- */
.sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: 250px;
    height: 100%;
    background-color: #4D44B5;
    color: #fff;
    padding: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
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
}

.menu {
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 20px;
    margin-top: 40px;
}

.menu-btn {
    background: transparent;
    color: #fff;
    border: none;
    padding: 12px 16px;
    text-align: left;
    font-size: 16px;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.25s;
}

.menu-btn:hover {
    background-color: rgba(255, 255, 255, 0.15);
}

.menu-btn.ativo {
    background-color: #fff;
    color: #4D44B5;
}

/* ----------------- TÍTULO E CONTEÚDO ----------------- */
#titulo h2 {
    margin-left: 300px;
    margin-top: 30px;
    font-size: 26px;
}

.conteudo-principal {
    background-color: #fff;
    border-radius: 16px;
    padding: 30px 30px 40px 30px;
    margin: 90px 20px 40px 300px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.linha-superior {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 20px;
}

.botao-novo-aluno {
    background-color: #4D44B5;
    color: #fff;
    border: none;
    padding: 10px 22px;
    border-radius: 8px;
    cursor: pointer;
    font-size: 15px;
    transition: background-color 0.25s;
}

.botao-novo-aluno:hover {
    background-color: #372e9c;
}

/* ----------------- TABELA DE ALUNOS ----------------- */
.tabela-alunos {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    font-size: 14px;
    border-radius: 8px;
    overflow: hidden;
}

.tabela-alunos th {
    background-color: #eceef5;
    color: #2c3e50;
    text-align: left;
    padding: 14px;
}

.tabela-alunos td {
    background-color: #fff;
    padding: 14px;
    border-bottom: 1px solid #e0e0e0;
}

.botoes-acoes {
    display: flex;
    gap: 8px;
}

.botao-editar {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    transition: background-color 0.2s;
}

.botao-editar:hover {
    background-color: #0056b3;
}

.botao-excluir {
    background-color: #dc3545;
    color: #fff;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    transition: background-color 0.2s;
}

.botao-excluir:hover {
    background-color: #c82333;
}

.botao-ver-mais {
    background-color: #17a2b8;
    color: #fff;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    transition: background-color 0.2s;
}

.botao-ver-mais:hover {
    background-color: #138496;
}

/* ----------------- MODAIS ----------------- */
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
    z-index: 1000;
}

.modal-conteudo {
    background-color: #fff;
    border-radius: 12px;
    width: 650px;
    max-width: 90%;
    max-height: 90vh;
    overflow-y: auto;
    padding: 30px 30px 40px 30px;
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
}

.modal-conteudo h3 {
    text-align: center;
    margin-bottom: 20px;
}

/* Seções dentro do modal */
.section-group {
    margin-bottom: 25px;
}

.section-group h4 {
    font-size: 16px;
    margin-bottom: 12px;
    padding-bottom: 4px;
    border-bottom: 2px solid #eceef5;
    color: #4D44B5;
}

.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 25px;
}

/* Cada grupo de label+input */
.input-group {
    display: flex;
    flex-direction: column;
    margin-bottom: 14px;
}

.input-group label {
    font-weight: 600;
    margin-bottom: 6px;
    font-size: 14px;
    color: #2c3e50;
}

.input-group input,
.input-group select {
    padding: 10px 14px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #fafafa;
    transition: border-color 0.25s, box-shadow 0.25s;
}

.input-group input:focus,
.input-group select:focus {
    border-color: #4D44B5;
    box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
    outline: none;
}

/* Campos que devem ocupar a linha inteira */
.full-width {
    grid-column: 1 / -1;
}

.botoes-modal {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    margin-top: 10px;
}

.botoes-modal button[type="submit"] {
    background-color: #4D44B5;
    color: #fff;
    border: none;
    padding: 12px 24px;
    border-radius: 8px;
    font-size: 15px;
    cursor: pointer;
    transition: background-color 0.25s;
}

.botoes-modal button[type="submit"]:hover {
    background-color: #372e9c;
}

.botoes-modal button[type="button"] {
    background-color: #e0e0e0;
    color: #333;
    border: none;
    padding: 12px 24px;
    border-radius: 8px;
    font-size: 15px;
    cursor: pointer;
    transition: background-color 0.25s;
}

.botoes-modal button[type="button"]:hover {
    background-color: #cfcfcf;
}

/* Ajuste de scroll interno do modal */
.modal-conteudo::-webkit-scrollbar {
    width: 8px;
}

.modal-conteudo::-webkit-scrollbar-thumb {
    background-color: rgba(0,0,0,0.2);
    border-radius: 4px;
}

/* ----------------- FIM DO CSS ----------------- */
</style>
<body>
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
        <h2>Gestão de Alunos</h2>
    </div>

    <div class="conteudo-principal">
        <div class="linha-superior">
            <button class="botao-novo-aluno">+ Novo Aluno</button>
        </div>

        <!-- === Modal Novo Aluno === -->
        <div class="modal-overlay" id="modalNovoAluno">
            <div class="modal-conteudo">
                <h3>Cadastrar Novo Aluno</h3>
                <form id="formNovoAluno" action="${pageContext.request.contextPath}/templates/aee/alunos?acao=criar" method="POST">

                    <!-- Seção: Informações Pessoais e Acadêmicas -->
                    <div class="section-group">
                        <h4>Informações do Aluno</h4>
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

                            <!-- Matrícula -->
                            <div class="input-group">
                                <label for="matricula">Matrícula:</label>
                                <input type="text" id="matricula" name="matricula" required>
                            </div>

                            <!-- Curso -->
                            <div class="input-group">
                                <label for="curso">Curso:</label>
                                <input type="text" id="curso" name="curso" required>
                            </div>

                            <!-- Turma -->
                            <div class="input-group">
                                <label for="turma">Turma:</label>
                                <input type="text" id="turma" name="turma" required>
                            </div>

                            <!-- E-mail (linha inteira) -->
                            <div class="input-group ">
                                <label for="email">Email:</label>
                                <input type="email" id="email" name="email">
                            </div>

                            <!-- Telefone -->
                            <div class="input-group">
                                <label for="telefone">Telefone:</label>
                                <input type="text" id="telefone" name="telefone">
                            </div>
                        </div>
                    </div>

                    <!-- Seção: Informações do Responsável -->
                    <div class="section-group">
                        <h4>Informações do Responsável</h4>
                        <div class="form-grid">
                            <!-- Nome do Responsável (ocupando metade da tela) -->
                            <div class="input-group full-width">
                                <label for="responsavel">Nome do Responsável:</label>
                                <input type="text" id="responsavel" name="responsavel">
                            </div>

                            <!-- Telefone Responsável -->
                            <div class="input-group">
                                <label for="telResponsavel">Tel. Responsável:</label>
                                <input type="text" id="telResponsavel" name="telResponsavel">
                            </div>

                            <!-- Telefone Trabalho -->
                            <div class="input-group">
                                <label for="telTrabalho">Tel. Trabalho:</label>
                                <input type="text" id="telTrabalho" name="telTrabalho">
                            </div>
                        </div>
                    </div>

                    <div class="botoes-modal">
                        <button type="submit">Salvar</button>
                        <button type="button" onclick="fecharModal(modalNovoAluno)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabela de Alunos -->
        <table class="tabela-alunos">
            <thead>
                <tr>
                    <th>Matrícula</th>
                    <th>Nome</th>
                    <th>Curso</th>
                    <th>Turma</th>
                    <th>Responsável</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${alunos}" var="aluno">
                    <tr data-id="${aluno.id}"
                        data-nome="${aluno.nome}"
                        data-datanascimento="${aluno.dataNascimento}"
                        data-email="${aluno.email}"
                        data-sexo="${aluno.sexo}"
                        data-naturalidade="${aluno.naturalidade}"
                        data-telefone="${aluno.telefone}"
                        data-matricula="${aluno.matricula}"
                        data-responsavel="${aluno.responsavel}"
                        data-telresponsavel="${aluno.telResponsavel}"
                        data-teltrabalho="${aluno.telTrabalho}"
                        data-curso="${aluno.curso}"
                        data-turma="${aluno.turma}">

                        <td>${aluno.matricula}</td>
                        <td>${aluno.nome}</td>
                        <td>${aluno.curso}</td>
                        <td>${aluno.turma}</td>
                        <td>${aluno.responsavel}</td>
                        <td>
                            <div class="botoes-acoes">
                                <button class="botao-ver-mais"
                                    onclick="window.location.href='detalhes-aluno?id=${aluno.id}'">Detalhes</button>
                                <button class="botao-editar" onclick="window.location.href='/templates/aee/professores-aluno?matricula=${aluno.matricula}'">Professores</button>
                                <button class="botao-editar" onclick="abrirEdicao(this)">Editar</button>
                                <button class="botao-excluir" onclick="confirmarExclusao(${aluno.id})">Excluir</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- === Modal Editar Aluno === -->
        <div class="modal-overlay" id="modalEditar">
            <div class="modal-conteudo">
                <h3>Editar Aluno</h3>
                <form id="formEditarAluno" action="${pageContext.request.contextPath}/templates/aee/alunos?acao=atualizar" method="POST">
                    <input type="hidden" name="id" id="editId">

                    <!-- Seção: Informações do Aluno -->
                    <div class="section-group">
                        <h4>Informações do Aluno</h4>
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

                            <!-- Matrícula -->
                            <div class="input-group">
                                <label for="editMatricula">Matrícula:</label>
                                <input type="text" id="editMatricula" name="matricula" required>
                            </div>

                            <!-- Curso -->
                            <div class="input-group">
                                <label for="editCurso">Curso:</label>
                                <input type="text" id="editCurso" name="curso" required>
                            </div>

                            <!-- Turma -->
                            <div class="input-group">
                                <label for="editTurma">Turma:</label>
                                <input type="text" id="editTurma" name="turma" required>
                            </div>

                            <!-- E-mail  -->
                            <div class="input-group">
                                <label for="editEmail">Email:</label>
                                <input type="email" id="editEmail" name="email">
                            </div>

                            <!-- Telefone -->
                            <div class="input-group">
                                <label for="editTelefone">Telefone:</label>
                                <input type="text" id="editTelefone" name="telefone">
                            </div>
                        </div>
                    </div>

                    <!-- Seção: Informações do Responsável -->
                    <div class="section-group">
                        <h4>Informações do Responsável</h4>
                        <div class="form-grid">
                            <!-- Nome Responsável -->
                            <div class="input-group full-width">
                                <label for="editResponsavel">Nome do Responsável:</label>
                                <input type="text" id="editResponsavel" name="responsavel">
                            </div>
                            <!-- Tel. Responsável -->
                            <div class="input-group">
                                <label for="editTelResponsavel">Tel. Responsável:</label>
                                <input type="text" id="editTelResponsavel" name="telResponsavel">
                            </div>
                            <!-- Tel. Trabalho -->
                            <div class="input-group">
                                <label for="editTelTrabalho">Tel. Trabalho:</label>
                                <input type="text" id="editTelTrabalho" name="telTrabalho">
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

        <!-- Modal Confirmação Exclusão (sem alterações) -->
        <div class="modal-overlay" id="modalExcluir">
            <div class="modal-conteudo">
                <h3>Confirmar Exclusão</h3>
                <p>Tem certeza que deseja excluir este aluno?</p>
                <form id="formExcluirAluno" action="${pageContext.request.contextPath}/templates/aee/alunos?acao=excluir" method="POST">
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
            novo: document.getElementById('modalNovoAluno'),
            editar: document.getElementById('modalEditar'),
            excluir: document.getElementById('modalExcluir')
        };

        document.querySelector('.botao-novo-aluno').addEventListener('click', () => {
            modais.novo.style.display = 'flex';
        });

        function abrirEdicao(botaoEditar) {
            const linha = botaoEditar.closest('tr');

            // Preenche os campos do formulário
            document.getElementById('editId').value = linha.dataset.id;
            document.getElementById('editNome').value = linha.dataset.nome;
            document.getElementById('editDataNascimento').value = linha.dataset.datanascimento;
            document.getElementById('editEmail').value = linha.dataset.email;
            document.getElementById('editSexo').value = linha.dataset.sexo;
            document.getElementById('editNaturalidade').value = linha.dataset.naturalidade;
            document.getElementById('editTelefone').value = linha.dataset.telefone;
            document.getElementById('editMatricula').value = linha.dataset.matricula;
            document.getElementById('editResponsavel').value = linha.dataset.responsavel;
            document.getElementById('editTelResponsavel').value = linha.dataset.telresponsavel;
            document.getElementById('editTelTrabalho').value = linha.dataset.teltrabalho;
            document.getElementById('editCurso').value = linha.dataset.curso;
            document.getElementById('editTurma').value = linha.dataset.turma;

            // Abre o modal
            document.getElementById('modalEditar').style.display = 'flex';
        }

        function confirmarExclusao(id) {
            document.getElementById('idExcluir').value = id;
            modais.excluir.style.display = 'flex';
        }

        function fecharModal(modal) {
            modal.style.display = 'none';
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
