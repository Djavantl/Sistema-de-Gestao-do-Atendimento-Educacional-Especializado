<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatórios</title>
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

.form-columns {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
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
.modal-conteudo select,
.modal-conteudo textarea {
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

.modal-conteudo textarea {
    min-height: 100px;
    resize: vertical;
}

.modal-conteudo input:focus,
.modal-conteudo select:focus,
.modal-conteudo textarea:focus {
    border-color: #4D44B5;
    box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
    outline: none;
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

.botao-detalhes {
    background-color: #17a2b8;
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

.botao-detalhes:hover {
    background-color: #138496;
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

@media (max-width: 768px) {
    #titulo h2 {
        margin-left: 20px;
        margin-top: 20px;
    }

    .conteudo-principal {
        margin: 60px 20px 20px;
        width: auto;
    }

    .form-columns {
        grid-template-columns: 1fr;
    }
}
</style>
<body>
<%-- Bloco de debug --%>
    <div style="background: #f0f0f0; padding: 10px; margin-bottom: 20px;">
        <h4>Informações de Debug:</h4>
        <p>Total de relatórios: ${not empty relatoriosLista ? relatoriosLista.size() : 0}</p>
        <c:if test="${not empty relatoriosLista && relatoriosLista.size() > 0}">
            <p>Primeiro relatório:
                ID: ${relatoriosLista[0].id},
                Título: ${relatoriosLista[0].titulo},
                Aluno: ${relatoriosLista[0].aluno.nome}
            </p>
        </c:if>
    </div>
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professores'">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>

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
                <h3>Criar Novo Relatório</h3>
                <form id="formNovoRelatorio" action="${pageContext.request.contextPath}/relatorios?acao=criar" method="POST">
                    <div class="form-columns">
                        <div class="form-column">
                            <label for="titulo">Título:</label>
                            <input type="text" id="titulo" name="titulo" required>

                            <label for="dataGeracao">Data de Geração:</label>
                            <input type="date" id="dataGeracao" name="dataGeracao" required>

                            <label for="alunoMatricula">Matrícula do Aluno:</label>
                            <input type="text" id="alunoMatricula" name="aluno" required
                                   placeholder="Digite a matrícula do aluno">

                            <label for="professorSiape">SIAPE do Professor:</label>
                            <input type="text" id="professorSiape" name="professorAEE"
                                   placeholder="Digite o SIAPE do professor (opcional)">
                        </div>

                        <div class="form-column">
                            <label for="resumo">Resumo:</label>
                            <textarea id="resumo" name="resumo" required></textarea>

                            <label for="observacoes">Observações:</label>
                            <textarea id="observacoes" name="observacoes"></textarea>
                        </div>
                    </div>

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
            </thead>
            <tbody>
                <c:forEach items="${relatoriosLista}" var="relatorio">
                    <tr data-id="${relatorio.id}">
                        <td>${relatorio.titulo}</td>
                        <td>${relatorio.aluno.nome}</td>
                        <td>${relatorio.dataGeracao}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty relatorio.professorAEE}">
                                    ${relatorio.professorAEE.nome} (${relatorio.professorAEE.siape})
                                </c:when>
                                <c:otherwise>
                                    Não atribuído
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <div class="botoes-acoes">
                                <button class="botao-editar" onclick="abrirEdicao(${relatorio.id})">Editar</button>
                                <button class="botao-detalhes"
                                    onclick="window.location.href='detalhes-relatorio?id=${relatorio.id}'">Detalhes</button>
                                <button class="botao-excluir" onclick="confirmarExclusao(${relatorio.id})">Excluir</button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Modal Edição -->
        <div class="modal-overlay" id="modalEditar">
            <div class="modal-conteudo">
                <h3>Editar Relatório</h3>
                <form id="formEditarRelatorio" action="${pageContext.request.contextPath}/relatorios?acao=atualizar" method="POST">
                    <input type="hidden" name="id" id="editId">

                    <div class="form-columns">
                        <div class="form-column">
                            <label for="editTitulo">Título:</label>
                            <input type="text" id="editTitulo" name="titulo" required>

                            <label for="editDataGeracao">Data de Geração:</label>
                            <input type="date" id="editDataGeracao" name="dataGeracao" required>

                            <label for="editAluno">Aluno:</label>
                            <input type="text" id="editAluno" readonly>

                            <label for="editProfessorAEE">Professor AEE:</label>
                            <input type="text" id="editProfessorAEE" readonly>
                        </div>

                        <div class="form-column">
                            <label for="editResumo">Resumo:</label>
                            <textarea id="editResumo" name="resumo" required></textarea>

                            <label for="editObservacoes">Observações:</label>
                            <textarea id="editObservacoes" name="observacoes"></textarea>
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

        document.querySelector('.botao-novo-relatorio').addEventListener('click', () => {
            modais.novo.style.display = 'flex';
        });

        function abrirEdicao(id) {
            // Aqui você precisará implementar a lógica para buscar os dados do relatório
            // e preencher o formulário de edição
            console.log("Editando relatório ID:", id);

            // Exemplo de como preencher os campos (substitua por sua lógica real)
            // document.getElementById('editId').value = id;
            // document.getElementById('editTitulo').value = "Título do Relatório";
            // etc...

            modais.editar.style.display = 'flex';
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