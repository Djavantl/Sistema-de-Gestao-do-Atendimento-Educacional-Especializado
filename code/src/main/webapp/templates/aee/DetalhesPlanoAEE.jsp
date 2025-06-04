<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Plano AEE</title>
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

        /* ======================== CONTEÚDO DETALHES ======================== */
        .detalhes-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .info-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .info-section h3 {
            color: #4D44B5;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .info-item {
            background-color: #f9f9ff;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .info-item label {
            display: block;
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 5px;
            font-weight: 600;
        }

        .info-item p {
            color: #333;
            font-size: 16px;
            margin: 0;
        }

        /* ======================== BOTÕES ======================== */
        .botao-voltar {
            background-color: #4D44B5;
            color: #fff;
            border: none;
            padding: 12px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        }

        .botao-voltar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .btn-adicionar {
            background-color: #4D44B5;
            color: #fff;
            border: none;
            padding: 12px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        }

        .btn-adicionar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .btn-editar {
            background-color: #6a5fcc;
            color: #fff;
            border: none;
            padding: 12px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        }

        .btn-editar:hover {
            background-color: #554bbd;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .btn-excluir {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 12px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }

        .btn-excluir:hover {
            background-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }

        .botoes-acoes {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
        }

        /* ======================== TABELAS ======================== */
        .metas-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .metas-table th, .metas-table td {
            padding: 16px 20px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        .metas-table th {
            background-color: #4D44B5;
            color: white;
            font-weight: 600;
        }

        .metas-table td {
            background-color: #fff;
        }

        .metas-table tr:hover td {
            background-color: #f9f9ff;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        .status-pendente {
            background-color: #ffebee;
            color: #dc3545;
        }

        .status-andamento {
            background-color: #fff8e1;
            color: #ffc107;
        }

        .status-concluido {
            background-color: #e8f5e9;
            color: #28a745;
        }

        /* ======================== RECURSOS ======================== */
        .recursos-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .recurso-categoria {
            background-color: #f9f9ff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .recurso-categoria h5 {
            color: #4D44B5;
            font-size: 18px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .recurso-item {
            margin-bottom: 12px;
            display: flex;
            align-items: center;
        }

        .recurso-item input[type="checkbox"] {
            margin-right: 10px;
            width: 18px;
            height: 18px;
            accent-color: #4D44B5;
        }

        .recurso-item label {
            color: #333;
            font-size: 15px;
        }

        /* ======================== ALERTAS ======================== */
        .alert {
            padding: 16px 20px;
            margin-bottom: 30px;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 500;
        }

        .success {
            background-color: #e8f5e9;
            color: #28a745;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #ffebee;
            color: #dc3545;
            border: 1px solid #f5c6cb;
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

            .info-grid, .recursos-grid {
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
                justify-content: center;
            }
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.6);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            display: none;
        }

        .modal-conteudo {
            background: white;
            padding: 40px;
            border-radius: 20px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            position: relative;
            text-align: center;
        }

        .modal-conteudo h3 {
            font-size: 24px;
            color: #4D44B5;
            margin-bottom: 20px;
        }

        .modal-conteudo p {
            margin-bottom: 30px;
            font-size: 18px;
            line-height: 1.6;
            color: #555;
        }

        .botoes-modal {
            display: flex;
            justify-content: center;
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
            <button class="menu-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/sessoes'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/sessoes.svg" alt="Sessões" />
                Sessões
            </button>
            <button class="menu-btn ativo"
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
                <h1>Detalhes do Plano AEE</h1>
            </div>
        </div>

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
                    + Adicionar Meta
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
                                        <span class="status-badge ${meta.status == 'Pendente' ? 'status-pendente' :
                                          meta.status == 'Em Andamento' ? 'status-andamento' : 'status-concluido'}">
                                            ${meta.status}
                                        </span>
                                    </td>
                                    <td>
                                        <button class="btn-editar" style="padding: 8px 16px; margin-right: 8px;">
                                            Editar
                                        </button>
                                        <button class="btn-excluir" style="padding: 8px 16px;">
                                            Excluir
                                        </button>
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
            <div class="detalhes-header">
                <h3>Proposta Pedagógica</h3>

                <c:choose>
                    <c:when test="${empty plano.proposta}">
                        <button class="btn-adicionar"
                                onclick="window.location.href='${pageContext.request.contextPath}/propostas?planoAEEId=${plano.id}'">
                            + Adicionar Proposta
                        </button>
                    </c:when>
                    <c:otherwise>
                        <div style="display: flex; gap: 15px;">
                            <button class="btn-editar" onclick="window.location.href='${pageContext.request.contextPath}/editarProposta?id=${plano.proposta.id}'">
                                Editar
                            </button>
                            <button class="btn-excluir" onclick="abrirModalExcluirProposta(${plano.proposta.id}, ${plano.id})">
                                Excluir
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

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
        <div class="modal-overlay" id="modalExcluirProposta">
            <div class="modal-conteudo">
                <h3>Confirmar Exclusão</h3>
                <p>Tem certeza que deseja excluir esta proposta pedagógica? Esta ação não pode ser desfeita.</p>
                <form id="formExcluirProposta" action="${pageContext.request.contextPath}/excluirProposta" method="POST">
                    <input type="hidden" name="propostaId" id="propostaIdExcluir">
                    <input type="hidden" name="planoId" id="planoIdExcluir">
                    <div class="botoes-modal">
                        <button type="submit">Confirmar Exclusão</button>
                        <button type="button" onclick="fecharModal('modalExcluirProposta')">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>
    <script>
        // Funções para o modal de exclusão da proposta
        function abrirModalExcluirProposta(propostaId, planoId) {
            document.getElementById('propostaIdExcluir').value = propostaId;
            document.getElementById('planoIdExcluir').value = planoId;
            document.getElementById('modalExcluirProposta').style.display = 'flex';
        }

        function fecharModal(modalId) {
            document.getElementById(modalId).style.display = 'none';
        }

        // Fechar modal ao clicar fora do conteúdo
        window.addEventListener('click', function(event) {
            const modal = document.getElementById('modalExcluirProposta');
            if (event.target === modal) {
                fecharModal('modalExcluirProposta');
            }
        });
    </script>
</body>
</html>