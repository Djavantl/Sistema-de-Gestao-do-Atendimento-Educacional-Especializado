<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Plano AEE</title>
    <style>
        /* ======================== RESET E BASE ======================== */
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

        /* ======================== CONTAINERS DE CONTEÚDO ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 30px;
        }

        .info-section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .info-section:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .info-section h3 {
            color: #4D44B5;
            margin-bottom: 25px;
            font-size: 28px;
            font-weight: 700;
            position: relative;
            padding-bottom: 10px;
        }

        .info-section h3::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 70px;
            height: 4px;
            background: #4D44B5;
            border-radius: 2px;
        }

        /* ======================== TABELAS ======================== */
        .tabela-relatorios {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 16px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .tabela-relatorios th {
            background-color: #4D44B5;
            color: white;
            text-align: left;
            padding: 16px 20px;
            font-weight: 600;
        }

        .tabela-relatorios td {
            background-color: #fff;
            padding: 14px 20px;
            border-bottom: 1px solid #f0f0f0;
        }

        .tabela-relatorios tr:last-child td {
            border-bottom: none;
        }

        .tabela-relatorios tr:hover td {
            background-color: #f9f9ff;
        }

        /* ======================== GRID DE INFORMAÇÕES ======================== */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .info-item {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .info-item label {
            display: block;
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .info-item p {
            margin: 0;
            font-size: 16px;
            color: #2c3e50;
            font-weight: 600;
            line-height: 1.5;
        }

        .info-item.span-2 {
            grid-column: span 2;
        }

        /* ======================== BOTÕES ======================== */
        .botao-voltar {
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.2s ease;
            box-shadow: 0 4px 10px rgba(77, 68, 181, 0.25);
        }

        .botao-voltar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(77, 68, 181, 0.35);
        }

        .botao-detalhes {
            background-color: #17a2b8;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.2s ease;
            box-shadow: 0 4px 10px rgba(23, 162, 184, 0.25);
        }

        .botao-detalhes:hover {
            background-color: #138496;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(23, 162, 184, 0.35);
        }

        /* ======================== STATUS ======================== */
        .status-badge {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
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

        /* ======================== RECURSOS ======================== */
        .recursos-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .recurso-categoria {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .recurso-categoria h5 {
            color: #4D44B5;
            margin-bottom: 15px;
            font-size: 18px;
            font-weight: 600;
            padding-bottom: 10px;
            border-bottom: 2px solid #4D44B5;
        }

        .recurso-item {
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }

        .recurso-item input[type="checkbox"] {
            margin-right: 12px;
            width: 18px;
            height: 18px;
        }

        .recurso-item label {
            font-size: 15px;
            color: #444;
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

        .footer p {
            margin-bottom: 5px;
        }

        /* ======================== RESPONSIVIDADE ======================== */
        @media (max-width: 1200px) {
            .conteudo-principal {
                padding: 30px;
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

            .user-info {
                width: 100%;
                margin-top: 15px;
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

            .titulo h1 {
                font-size: 32px;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .info-item.span-2 {
                grid-column: span 1;
            }
        }
        .detalhes-header {
            display: flex;
            justify-content: flex-end; /* Alinha o botão à direita */
            margin-bottom: 20px; /* Espaço abaixo do botão */
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
                    onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/inicio.svg" alt="Início" />
                Início
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aluno/minhas-informacoes?matricula=${matricula}'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/alunos.svg" alt="Estudantes" />
                Informações
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/MinhaOrganizacao?matricula=${matricula}'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/sessoes.svg" alt="Sessões" />
                Organização
            </button>
            <button class="menu-btn ativo"
                    onclick="window.location.href='${pageContext.request.contextPath}/meu-plano?matricula=${matricula}'">
                <img src="${pageContext.request.contextPath}/static/images/meuplano.svg" alt="Planos AEE" />
                Plano AEE
            </button>
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/meus-relatorios?matricula=${matricula}'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/relatorios.svg" alt="Relatórios" />
                Relatórios
            </button>
        </div>
    </div>
    <input type="hidden" id="matriculaHidden" value="${matricula}"/>

    <!-- Conteúdo Principal -->
    <div class="conteudo-principal">
        <div class="header">
            <div class="titulo">
                <h1>Meu Plano AEE</h1>
            </div>

            <div class="user-info">
                <p>${aluno.nome}</p>
                <p class="funcao">${aluno.curso} - ${aluno.turma}</p>
            </div>
        </div>

        <c:if test="${semPlano}">
            <div class="conteudo-container">
                <div class="detalhes-header">
                    <button class="botao-voltar" onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">Voltar</button>
                </div>

                <div class="info-section">
                    <h3>Meu Plano AEE</h3>
                    <div class="info-item">
                        <p>Você ainda não possui um plano AEE cadastrado.</p>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${not semPlano}">
            <div class="conteudo-container">
                <div class="detalhes-header">
                        <button class="botao-voltar" onclick="window.location.href='${pageContext.request.contextPath}/telaInicialAluno'">
                            Voltar
                        </button>
                    </div>

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
                            <table class="tabela-relatorios">
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
                            <div class="info-item">
                                <p>Nenhuma meta definida para este plano.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Proposta Pedagógica -->
                <div class="info-section">
                    <h3>Proposta Pedagógica</h3>

                    <c:choose>
                        <c:when test="${not empty plano.proposta}">
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
                        </c:when>
                        <c:otherwise>
                            <div class="info-item">
                                <p>Nenhuma proposta pedagógica cadastrada para este plano.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:if>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>
</body>
</html>