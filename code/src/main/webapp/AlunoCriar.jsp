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

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
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

.botao-novo-aluno {
    background-color: #4D44B5;
    color: #ffffff;
    border: none;
    padding: 10px 22px;
    border-radius: 10px;
    cursor: pointer;
    font-size: 15px;
    transition: background-color 0.3s;
}

.botao-novo-aluno:hover {
    background-color: #372e9c;
}

.form-columns {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 20px;
    margin-bottom: 20px;
}

.form-column {
    display: flex;
    flex-direction: column;
}

.modal-conteudo label {
    font-weight: 600;
    color: #2c3e50;
    font-size: 14px;
    margin-top: 8px;
}

.modal-conteudo input,
.modal-conteudo select {
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

.modal-conteudo input:focus,
.modal-conteudo select:focus {
    border-color: #4D44B5;
    box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
    outline: none;
}

.tabela-alunos {
    width: 100%;
    border-collapse: collapse;
    font-size: 14px;
    border-radius: 8px;
    overflow: hidden;
}

.tabela-alunos th {
    background-color: #ecf0f1;
    color: #2c3e50;
    text-align: left;
    padding: 14px;
}

.tabela-alunos td {
    background-color: #ffffff;
    padding: 14px;
    border-bottom: 1px solid #e0e0e0;
}

.linha-filtro input {
    width: 100%;
    padding: 8px;
    font-size: 13px;
    border: 1px solid #ccc;
    border-radius: 6px;
    background-color: #fefefe;
}

.botoes-acoes {
    display: flex;
    gap: 8px;
}

.botao-editar {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
}

.botao-excluir {
    background-color: #dc3545;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
}

.botao-editar:hover {
    background-color: #0056b3;
}

.botao-excluir:hover {
    background-color: #c82333;
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
    width: 700px;
    max-height: 90vh;
    overflow-y: auto;
}

.modal-conteudo h3 {
    margin-bottom: 20px;
    color: #2c3e50;
    text-align: center;
}

.botoes-modal {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
}

.botoes-modal button[type="submit"] {
    background-color: #4D44B5;
    color: #ffffff;
    border: none;
    padding: 10px 18px;
    border-radius: 8px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.botoes-modal button[type="submit"]:hover {
    background-color: #372e9c;
}

.botoes-modal button[type="button"] {
    background-color: #e0e0e0;
    color: #333;
    border: none;
    padding: 10px 18px;
    border-radius: 8px;
    font-size: 14px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.botoes-modal button[type="button"]:hover {
    background-color: #cfcfcf;
}

/* Botão Ver Mais */
.botao-ver-mais {
    background-color: #17a2b8;
    color: white;
    border: none;
    padding: 6px 12px;
    border-radius: 6px;
    cursor: pointer;
    font-size: 13px;
    transition: background-color 0.3s;
}

.botao-ver-mais:hover {
    background-color: #138496;
}

/* Ajustes de layout */
.detalhes-header h2 {
    color: #2c3e50;
    margin: 0;
}

.linha-superior {
    gap: 15px;
    margin-top: 20px;
}
</style>
<body>
    <div class="sidebar">
        <div class="logo">
            <img src="Group 167.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn ativo">Estudantes</button>
            <button class="menu-btn">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/sessoes?sucesso=Sessão+criada+com+sucesso'">Sessões</button>
            <button class="menu-btn">Usuários</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Gestão de Alunos</h2>
    </div>

    <div class="conteudo-principal">
        <div class="linha-superior">
            <button class="botao-novo-aluno">+ Novo Aluno</button>
        </div>

        <!-- Modal Novo Aluno -->
        <div class="modal-overlay" id="modalNovoAluno">
            <div class="modal-conteudo">
                <h3>Cadastrar Novo Aluno</h3>
                <form id="formNovoAluno" action="${pageContext.request.contextPath}/alunos?acao=criar" method="POST">
                    <div class="form-columns">
                        <div class="form-column">
                            <label for="nome">Nome Completo:</label>
                            <input type="text" id="nome" name="nome" required>

                            <label for="dataNascimento">Data de Nascimento:</label>
                            <input type="date" id="dataNascimento" name="dataNascimento" required>

                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email">

                            <label for="sexo">Sexo:</label>
                            <select id="sexo" name="sexo">
                                <option value="Masculino">Masculino</option>
                                <option value="Feminino">Feminino</option>
                                <option value="Outro">Outro</option>
                            </select>
                        </div>

                        <div class="form-column">
                            <label for="matricula">Matrícula:</label>
                            <input type="text" id="matricula" name="matricula" required>

                            <label for="curso">Curso:</label>
                            <input type="text" id="curso" name="curso" required>

                            <label for="turma">Turma:</label>
                            <input type="text" id="turma" name="turma" required>

                            <label for="telefone">Telefone:</label>
                            <input type="text" id="telefone" name="telefone">
                        </div>

                        <div class="form-column">
                            <label for="responsavel">Responsável:</label>
                            <input type="text" id="responsavel" name="responsavel">

                            <label for="telResponsavel">Tel. Responsável:</label>
                            <input type="text" id="telResponsavel" name="telResponsavel">

                            <label for="telTrabalho">Tel. Trabalho:</label>
                            <input type="text" id="telTrabalho" name="telTrabalho">

                            <label for="naturalidade">Naturalidade:</label>
                            <input type="text" id="naturalidade" name="naturalidade">
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
                                <button class="botao-editar" onclick="abrirEdicao(this)">Editar</button>
                                <button class="botao-ver-mais"
                                    onclick="window.location.href='detalhes-aluno?id=${aluno.id}'">Detalhes</button>
                                <button class="botao-excluir" onclick="confirmarExclusao(${aluno.id})">Excluir</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Modal Editar Aluno -->
        <div class="modal-overlay" id="modalEditar">
            <div class="modal-conteudo">
                <h3>Editar Aluno</h3>
                <form id="formEditarAluno" action="${pageContext.request.contextPath}/alunos?acao=atualizar" method="POST">
                    <input type="hidden" name="id" id="editId">
                    <div class="form-columns">
                        <div class="form-column">
                            <label for="editNome">Nome Completo:</label>
                            <input type="text" id="editNome" name="nome" required>

                            <label for="editDataNascimento">Data de Nascimento:</label>
                            <input type="date" id="editDataNascimento" name="dataNascimento" required>

                            <label for="editEmail">Email:</label>
                            <input type="email" id="editEmail" name="email">

                            <label for="editSexo">Sexo:</label>
                            <select id="editSexo" name="sexo">
                                <option value="Masculino">Masculino</option>
                                <option value="Feminino">Feminino</option>
                                <option value="Outro">Outro</option>
                            </select>
                        </div>

                        <div class="form-column">
                            <label for="editMatricula">Matrícula:</label>
                            <input type="text" id="editMatricula" name="matricula" required>

                            <label for="editCurso">Curso:</label>
                            <input type="text" id="editCurso" name="curso" required>

                            <label for="editTurma">Turma:</label>
                            <input type="text" id="editTurma" name="turma" required>

                            <label for="editTelefone">Telefone:</label>
                            <input type="text" id="editTelefone" name="telefone">
                        </div>

                        <div class="form-column">
                            <label for="editResponsavel">Responsável:</label>
                            <input type="text" id="editResponsavel" name="responsavel">

                            <label for="editTelResponsavel">Tel. Responsável:</label>
                            <input type="text" id="editTelResponsavel" name="telResponsavel">

                            <label for="editTelTrabalho">Tel. Trabalho:</label>
                            <input type="text" id="editTelTrabalho" name="telTrabalho">

                            <label for="editNaturalidade">Naturalidade:</label>
                            <input type="text" id="editNaturalidade" name="naturalidade">
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
                <p>Tem certeza que deseja excluir este aluno?</p>
                <form id="formExcluirAluno" action="${pageContext.request.contextPath}/alunos?acao=excluir" method="POST">
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
            Object.values(modais).forEach(modal => {
                if (event.target === modal) {
                    modal.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>