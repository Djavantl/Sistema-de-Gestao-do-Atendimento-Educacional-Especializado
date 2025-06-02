<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Plano AEE</title>
    <style>
    /* Estilos específicos para detalhes mantendo consistência */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        background-color: #f9f9ff;
        overflow-x: hidden;
    }

    /* Correção do título */
    #titulo h2 {
        color: rgb(12, 12, 97);
        font-size: 28px;
        margin-left: 350px;
        margin-top: 40px;
    }

    .detalhes-header {
        display: flex;
        justify-content: space-between;
        align-items: ;
        margin-bottom: 30px;
        padding: 0 20px;
    }

    .conteudo-principal {
        margin: 80px 0 40px 350px;
        width: 70%;
        padding: 40px;
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

    .info-section {
        margin-bottom: 30px;
        background-color: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    .info-section h3 {
        color: #4D44B5;
        margin-bottom: 15px;
        border-bottom: 2px solid #4D44B5;
        padding-bottom: 5px;
    }

    .info-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        align-items: start;
    }

    .botao-voltar {
        background-color: #4D44B5;
        color: #ffffff;
        border: none;
        padding: 10px 22px;
        border-radius: 10px;
        cursor: pointer;
        font-size: 15px;
        transition: background-color 0.3s;
    }

    .botao-voltar:hover {
        background-color: #372e9c;
    }

    .info-item {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
    }

    .info-item label {
        display: block;
        color: #6c757d;
        font-size: 0.9em;
        margin-bottom: 5px;
    }

    .info-item p {
        margin: 0;
        font-size: 1em;
        color: #2c3e50;
    }

    .linha-superior {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 30px;
        gap: 15px;
        margin-top: 20px;
    }

    .alert {
        padding: 15px;
        margin: 20px 0;
        border-radius: 8px;
        border: 1px solid transparent;
    }

    .success {
        background-color: #d4edda;
        border-color: #c3e6cb;
        color: #155724;
    }

    .error {
        background-color: #f8d7da;
        border-color: #f5c6cb;
        color: #721c24;
    }

    .botoes-acoes {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 20px;
    }

    .metas-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }

    .metas-table th, .metas-table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #e0e0e0;
    }

    .metas-table th {
        background-color: #f0f0f0;
        color: #4D44B5;
    }

    .metas-table tr:hover {
        background-color: #f8f9fa;
    }

    .btn-icone {
        background: none;
        border: none;
        cursor: pointer;
        font-size: 16px;
        padding: 5px;
    }

    .btn-editar {
        color: #4D44B5;
    }

    .btn-excluir {
        color: #dc3545;
    }

    .proposta-section,
    .meta-section {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        margin-top: 15px;
    }

    .proposta-acoes {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 15px;
    }

    .btn-adicionar {
        background-color: #4D44B5;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }

    .btn-adicionar:hover {
        background-color: #372e9c;
    }

    .btn-editar-proposta {
        background-color: #4D44B5;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }

    .btn-excluir-proposta {
        background-color: #dc3545;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }

    .btn-editar-proposta:hover {
        background-color: #372e9c;
    }

    .btn-excluir-proposta:hover {
        background-color: #bd2130;
    }

    .btn-adicionar,
    .btn-editar-proposta,
    .btn-excluir-proposta {
        text-decoration: none;
        display: inline-flex;
        align-items: center;
    }

    form button {
        text-decoration: none;
    }

    .btn-adicionar:hover,
    .btn-editar-proposta:hover,
    .btn-excluir-proposta:hover {
        text-decoration: none;
    }

    .recursos-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 15px;
        margin-top: 15px;
    }

    .recurso-categoria {
        background-color: white;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }

    .recurso-categoria h5 {
        color: #4D44B5;
        margin-bottom: 10px;
        border-bottom: 1px solid #e0e0e0;
        padding-bottom: 5px;
    }

    .recurso-item {
        margin-bottom: 8px;
    }

    .recurso-item input[type="checkbox"] {
        margin-right: 8px;
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
                <button class="menu-btn ativo" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/alunos'">Estudantes</button>
                            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/professores'">Professores</button>
                            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/planosAEE'">Planos AEE</button>
                            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">Sessões</button>
                            <button class="menu-btn" onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/relatorios'">Relatórios</button>
            </div>
        </div>

        <div id="titulo">
            <h2>Detalhes do Plano AEE</h2>
        </div>

        <div class="conteudo-principal">
            <!-- Mensagens de feedback -->
            <c:if test="${not empty success}">
                <div class="alert success">${success}</div>
            </c:if>
            <c:if test="${not empty erro}">
                <div class="alert error">${erro}</div>
            </c:if>

            <div class="detalhes-header">
                <div></div>
                <button class="botao-voltar" onclick="window.location.href='/templates/aee/planosAEE'">Voltar</button>
            </div>

            <!-- Informações do Plano -->
            <div class="info-section">
                <h3>Informações do Plano</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <label>Aluno</label>
                        <p>${aluno.nome} (${plano.alunoMatricula})</p>
                    </div>
                    <div class="info-item">
                        <label>Professor Responsável</label>
                        <p>
                            <c:choose>
                                <c:when test="${not empty professor}">
                                    ${professor.nome} (${plano.professorSiape})
                                </c:when>
                                <c:otherwise>
                                    Não atribuído
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="info-item">
                        <label>Data de Início</label>
                        <p>${plano.dataInicio}</p>
                    </div>
                    <div class="info-item">
                        <label>Curso/Turma</label>
                        <p>${aluno.curso} - ${aluno.turma}</p>
                    </div>
                    <div class="info-item">
                        <label>Recomendações</label>
                        <p>${empty plano.recomendacoes ? 'Nenhuma recomendação' : plano.recomendacoes}</p>
                    </div>
                    <div class="info-item">
                        <label>Observações</label>
                        <p>${empty plano.observacoes ? 'Nenhuma observação' : plano.observacoes}</p>
                    </div>
                </div>
            </div>

            <!-- Metas do Plano -->
            <div class="info-section">
                <div class="detalhes-header">
                    <h3>Metas do Plano</h3>
                    <button class="btn-adicionar">
                        <i class="bi bi-plus-circle me-1"></i> Adicionar Meta
                    </button>
                </div>

                <c:choose>
                    <c:when test="${not empty plano.metas && !plano.metas.isEmpty()}">
                        <table class="metas-table">
                            <thead>
                                <tr>
                                    <th>Descrição</th>
                                    <th>Status</th>
                                    <th>Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${plano.metas}" var="meta">
                                    <tr>
                                        <td>${meta.descricao}</td>
                                        <td>
                                                ${meta.status == 'Pendente' ? '#dc3545' :
                                                  meta.status == 'Em Andamento' ? '#ffc107' :
                                                  '#28a745'}">
                                                ${meta.status}
                                            </span>
                                        </td>
                                        <td>
                                            <button class="btn-icone btn-editar">
                                                <i class="bi bi-pencil"></i>
                                            </button>
                                            <button class="btn-icone btn-excluir">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div class="meta-section">
                            <i class="bi bi-info-circle"></i> Nenhuma meta definida para este plano.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Proposta Pedagógica -->
            <div class="info-section">
                <div class="detalhes-header">
                    <h3>Proposta Pedagógica</h3>

                    <c:choose>
                        <c:when test="${empty plano.proposta}">
                            <a href="${pageContext.request.contextPath}/propostas?planoAEEId=${plano.id}"
                               class="btn-adicionar">
                                <i class="bi bi-plus-circle me-1"></i> Adicionar Proposta
                            </a>
                            </c:when>
                        <c:otherwise>
                            <div class="proposta-acoes">
                                <c:if test="${not empty plano.proposta}">
                                    <a href="${pageContext.request.contextPath}/editarProposta?id=${plano.proposta.id}"
                                       class="btn-editar-proposta">
                                        <i class="bi bi-pencil me-1"></i> Editar
                                    </a>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/excluirProposta" method="post"
                                      onsubmit="return confirm('Tem certeza que deseja excluir esta proposta pedagógica?');">
                                    <input type="hidden" name="propostaId" value="${plano.proposta.id}">
                                    <input type="hidden" name="planoId" value="${plano.id}">
                                    <button type="submit" class="btn-excluir-proposta">
                                        <i class="bi bi-trash me-1"></i> Excluir
                                    </button>
                                </form>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:choose>
                    <c:when test="${not empty plano.proposta}">
                        <div class="proposta-section">
                            <div class="info-grid">
                                <div class="info-item">
                                    <label>Objetivos</label>
                                    <p>${plano.proposta.objetivos}</p>
                                </div>
                                <div class="info-item">
                                    <label>Metodologias</label>
                                    <p>${plano.proposta.metodologias}</p>
                                </div>
                            </div>

                            <!-- Recursos Pedagógicos -->
                            <c:if test="${not empty plano.proposta.recursoP}">
                                <div class="recursos-grid">
                                    <div class="recurso-categoria">
                                        <h5><i class="bi bi-journal-bookmark me-2"></i> Recursos Pedagógicos</h5>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoP.adaptacaoDidaticaAulasAvaliacoes ? 'checked' : ''} disabled>
                                            <label>Adaptação didática para aulas e avaliações</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoP.materialDidaticoAdaptado ? 'checked' : ''} disabled>
                                            <label>Material didático adaptado</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoP.usoTecnologiaAssistiva ? 'checked' : ''} disabled>
                                            <label>Uso de tecnologia assistiva</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoP.tempoEmpregadoAtividadesAvaliacoes ? 'checked' : ''} disabled>
                                            <label>Tempo adicional para atividades/avaliações</label>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Recursos Físicos/Arquitetônicos -->
                            <c:if test="${not empty plano.proposta.recursoFA}">
                                <div class="recursos-grid">
                                    <div class="recurso-categoria">
                                        <h5><i class="bi bi-building me-2"></i> Recursos Físicos/Arquitetônicos</h5>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoFA.usoCadeiraDeRodas ? 'checked' : ''} disabled>
                                            <label>Uso de cadeira de rodas</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoFA.auxilioTranscricaoEscrita ? 'checked' : ''} disabled>
                                            <label>Auxílio para transcrição escrita</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoFA.mesaAdaptadaCadeiraDeRodas ? 'checked' : ''} disabled>
                                            <label>Mesa adaptada para cadeira de rodas</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoFA.usoDeMuleta ? 'checked' : ''} disabled>
                                            <label>Uso de muleta</label>
                                        </div>
                                        <c:if test="${plano.proposta.recursoFA.outrosFisicoArquitetonico}">
                                            <div class="recurso-item">
                                                <label>Outros recursos:</label>
                                                <p>${plano.proposta.recursoFA.outrosEspecificado}</p>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:if>

                            <!-- Recursos de Comunicação -->
                            <c:if test="${not empty plano.proposta.recursoCI}">
                                <div class="recursos-grid">
                                    <div class="recurso-categoria">
                                        <h5><i class="bi bi-chat-left-text me-2"></i> Recursos de Comunicação e Informação</h5>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.comunicacaoAlternativa ? 'checked' : ''} disabled>
                                            <label>Comunicação alternativa</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.tradutorInterprete ? 'checked' : ''} disabled>
                                            <label>Tradutor/intérprete</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.leitorTranscritor ? 'checked' : ''} disabled>
                                            <label>Leitor/transcritor</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.interpreteOralizador ? 'checked' : ''} disabled>
                                            <label>Intérprete/oralizador</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.guiaInterprete ? 'checked' : ''} disabled>
                                            <label>Guia-intérprete</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.materialDidaticoBraille ? 'checked' : ''} disabled>
                                            <label>Material em Braille</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.materialDidaticoTextoAmpliado ? 'checked' : ''} disabled>
                                            <label>Texto ampliado</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.materialDidaticoRelevo ? 'checked' : ''} disabled>
                                            <label>Material em relevo</label>
                                        </div>
                                        <div class="recurso-item">
                                            <input type="checkbox" ${plano.proposta.recursoCI.leitorDeTela ? 'checked' : ''} disabled>
                                            <label>Leitor de tela</label>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${not empty plano.proposta.observacoes}">
                                <div class="info-item">
                                    <label>Observações Recursos</label>
                                    <p>${plano.proposta.observacoes}</p>
                                </div>
                            </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="proposta-section">
                            <i class="bi bi-info-circle"></i> Nenhuma proposta pedagógica cadastrada para este plano.
                       </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Botões de ação para o plano -->
            <div class="botoes-acoes">
                <a href="${pageContext.request.contextPath}/templates/aee/editarPlanoAEE?id=${plano.id}"
                   class="btn-editar-proposta">
                    <i class="bi bi-pencil me-1"></i> Editar Plano
                </a>
                <form action="${pageContext.request.contextPath}/templates/aee/detalhes-plano" method="post"
                      onsubmit="return confirm('Tem certeza que deseja excluir este plano? Esta ação não pode ser desfeita.');">
                    <input type="hidden" name="action" value="excluirPlano">
                    <input type="hidden" name="planoId" value="${plano.id}">
                    <button type="submit" class="btn-excluir-proposta">
                        <i class="bi bi-trash me-1"></i> Excluir Plano
                    </button>
                </form>
            </div>
        </div>
    </body>
    </html>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>