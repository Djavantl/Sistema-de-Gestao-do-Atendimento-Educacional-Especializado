<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Plano AEE</title>
    <style>
    /* Reset e estilos globais */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    /* Body com gradiente roxo (igual à primeira página) */
    body {
        background: #E6E6FA;
        color: #333;
        min-height: 100vh;
        position: relative;
        overflow-x: hidden;
    }

    /* Sidebar (estilo da primeira página) */
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

    /* Conteúdo Principal */
    .conteudo-principal {
        margin: 80px 0 40px 350px;
        width: 70%;
        padding: 40px;
        background: white;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        position: relative;
        z-index: 10;
    }

    #titulo {
        margin-bottom: 30px;
    }

    #titulo h2 {
        color: #4D44B5;
        font-size: 28px;
        margin-bottom: 10px;
    }

    .detalhes-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
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
        grid-template-columns: repeat(4, minmax(250px, 1fr));
        gap: 20px;
        align-items: start;
        margin-bottom: 20px;
    }

    .info-item.span-2 {
        grid-column: span 2;
    }

    .info-item {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        margin-bottom: 15px;
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

    .proposta-section,
    .meta-section {
        background-color: #f8f9fa;
        padding: 15px;
        border-radius: 8px;
        margin-top: 15px;
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

    .status-badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 15px;
        font-size: 0.85em;
        font-weight: bold;
    }

    .status-pendente {
        background-color: #f8d7da;
        color: #721c24;
    }

    .status-andamento {
        background-color: #fff3cd;
        color: #856404;
    }

    .status-concluido {
        background-color: #d4edda;
        color: #155724;
    }

    /* Elementos Decorativos */
    .decorative-circle {
        position: absolute;
        border-radius: 50%;
        z-index: 0;
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

    /* Responsividade */
    @media (max-width: 992px) {
        .sidebar {
            width: 220px;
        }

        .conteudo-principal {
            margin-left: 240px;
            width: calc(100% - 260px);
            padding: 30px;
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
            margin: 30px auto;
            width: 90%;
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
    }
    </style>
</head>
<body>
    <!-- Elementos decorativos -->
    <div class="decorative-circle circle-1"></div>
    <div class="decorative-circle circle-2"></div>
    <div class="decorative-circle circle-3"></div>

    <!-- Sidebar (igual à primeira página) -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logoAEE.png" alt="Logo AEE+" />
            <h2>AEE +</h2>
        </div>

        <div class="menu">
            <button class="menu-btn"
                onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">
                 Início
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aluno/minhas-informacoes?matricula=${matricula}'">
                Minhas Informações
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/MinhaOrganizacao?matricula=${matricula}'">
                Minha Organização
            </button>
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/meu-plano?matricula=${matricula}'">
                 Meu Plano AEE
            </button>
            <button class="menu-btn"
                     onclick="window.location.href='${pageContext.request.contextPath}/meus-relatorios?matricula=${matricula}'">
                Meus Relatórios
            </button>
        </div>
    </div>
    <input type="hidden" id="matriculaHidden" value="${matricula}"/>

    <c:if test="${semPlano}">
        <div class="conteudo-principal">
            <div class="detalhes-header">
                <div></div>
                <button class="botao-voltar" onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">Voltar</button>
            </div>

            <div class="info-section">
                <h3>Meu Plano AEE</h3>
                <p>Você ainda não possui um plano AEE cadastrado.</p>
            </div>
        </div>
    </c:if>

    <c:if test="${not semPlano}">
        <div class="conteudo-principal">
            <div class="detalhes-header">
                <div id="titulo">
                    <h2>Meu Plano de Acompanhamento Educacional Especializado</h2>
                </div>
                <button class="botao-voltar" onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">Voltar</button>
            </div>

            <div class="plano-detalhes">
                <!-- Informações do Plano -->
                <div class="info-section">
                    <h3>Informações do Plano</h3>
                    <div class="info-grid">
                        <div class="info-item span-2">
                            <label>Aluno</label>
                            <p>${aluno.nome}</p>
                        </div>
                        <div class="info-item span-2">
                            <label>Professor Responsável</label>
                            <p>
                                <c:choose>
                                    <c:when test="${not empty professor}">
                                        ${professor.nome}
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

                <!-- Metas do Plano -->
                <div class="info-section">
                    <h3>Metas do Plano</h3>

                    <c:choose>
                        <c:when test="${not empty plano.metas && !plano.metas.isEmpty()}">
                            <table class="metas-table">
                                <thead>
                                    <tr>
                                        <th>Descrição</th>
                                        <th>Status</th>
                                        <th>Progresso</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${plano.metas}" var="meta">
                                        <tr>
                                            <td>${meta.descricao}</td>
                                            <td>
                                                <span class="status-badge
                                                    ${meta.status == 'Pendente' ? 'status-pendente' :
                                                      meta.status == 'Em Andamento' ? 'status-andamento' :
                                                      'status-concluido'}">
                                                    ${meta.status}
                                                </span>
                                            </td>
                                            <td>
                                                <c:if test="${not empty meta.progresso}">
                                                    ${meta.progresso}%
                                                </c:if>
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
                    <h3>Proposta Pedagógica</h3>

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
                                            <h5>Recursos Pedagógicos</h5>
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
                                            <h5>Recursos Físicos/Arquitetônicos</h5>
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
                                            <h5>Recursos de Comunicação e Informação</h5>
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
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="proposta-section">
                                <i class="bi bi-info-circle"></i> Nenhuma proposta pedagógica cadastrada para este plano.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:if>
    <script>
        // Função para o botão Voltar
        document.querySelectorAll('.botao-voltar').forEach(button => {
            button.onclick = function() {
                window.location.href = '${pageContext.request.contextPath}/telaInicialAluno';
            };
        });
    </script>
</body>
</html>