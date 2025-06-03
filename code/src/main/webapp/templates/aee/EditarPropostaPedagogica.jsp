<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Proposta Pedagógica</title>
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

        /* ======================== FORMULÁRIO ======================== */
        .conteudo-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            margin-bottom: 40px;
        }

        .form-proposta {
            display: grid;
            gap: 25px;
        }

        .section-group {
            margin-bottom: 30px;
        }

        .section-group h4 {
            font-size: 22px;
            margin-bottom: 25px;
            padding-bottom: 8px;
            border-bottom: 2px solid #f0f0f0;
            color: #4D44B5;
            font-weight: 700;
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
        .input-group select,
        .input-group textarea {
            padding: 12px 16px;
            font-size: 15px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #fafafa;
            transition: all 0.3s ease;
        }

        .input-group textarea {
            min-height: 120px;
            resize: vertical;
        }

        .input-group input:focus,
        .input-group select:focus,
        .input-group textarea:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        /* Seções de Recursos */
        .secao-recursos {
            margin-top: 20px;
            padding: 25px;
            border-radius: 16px;
            background-color: #f8f9fa;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .secao-titulo {
            color: #4D44B5;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .grupo-checkbox {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px;
            border-radius: 8px;
            transition: background-color 0.2s;
        }

        .checkbox-item:hover {
            background-color: rgba(77, 68, 181, 0.08);
        }

        .checkbox-item input[type="checkbox"] {
            width: 20px;
            height: 20px;
            accent-color: #4D44B5;
            cursor: pointer;
        }

        .checkbox-item label {
            font-size: 15px;
            color: #333;
            cursor: pointer;
        }

        /* ======================== BOTÕES ======================== */
        .botoes-acoes {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .botao-salvar {
            background-color: #4D44B5;
            color: white;
            padding: 12px 28px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 68, 181, 0.3);
        }

        .botao-salvar:hover {
            background-color: #372e9c;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 68, 181, 0.4);
        }

        .botao-cancelar {
            background-color: #e0e0e0;
            color: #333;
            padding: 12px 28px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .botao-cancelar:hover {
            background-color: #cfcfcf;
            transform: translateY(-2px);
        }

        /* ======================== ALERTAS ======================== */
        .alert-sucesso {
            background-color: #d4edda;
            color: #155724;
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 1px solid #c3e6cb;
            font-size: 15px;
        }

        .alert-erro {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 1px solid #f5c6cb;
            font-size: 15px;
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
            margin-top: auto;
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
                    onclick="window.location.href='${pageContext.request.contextPath}/templates/aee/propostas'">
                <img src="${pageContext.request.contextPath}/static/images/sidebar/sessoes.svg" alt="Propostas" />
                Propostas
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
                <h1>Editar Proposta Pedagógica</h1>
            </div>
        </div>

        <div class="conteudo-container">
            <!-- Mensagens de Sucesso/Erro -->
            <c:if test="${not empty success}">
                <div class="alert-sucesso">${success}</div>
            </c:if>
            <c:if test="${not empty erro}">
                <div class="alert-erro">${erro}</div>
            </c:if>

            <form class="form-proposta" action="${pageContext.request.contextPath}/atualizarProposta" method="POST">
                <input type="hidden" name="propostaId" value="${proposta.id}">
                <input type="hidden" name="planoId" value="${planoId}">

                <!-- Seção: Objetivos e Metodologias -->
                <div class="section-group">
                    <h4>Informações da Proposta</h4>
                    <div class="form-grid">
                        <div class="input-group">
                            <label for="objetivos">Objetivos:</label>
                            <textarea id="objetivos" name="objetivos" required>${proposta.objetivos}</textarea>
                        </div>

                        <div class="input-group">
                            <label for="metodologias">Metodologias:</label>
                            <textarea id="metodologias" name="metodologias" required>${proposta.metodologias}</textarea>
                        </div>
                    </div>
                </div>

                <!-- Seção: Recursos Pedagógicos -->
                <div class="section-group">
                    <h4>Recursos Pedagógicos</h4>
                    <div class="secao-recursos">
                        <div class="grupo-checkbox">
                            <div class="checkbox-item">
                                <input type="checkbox" id="adaptacaoDidaticaAulasAvaliacoes"
                                    name="recursoP_adaptacaoDidaticaAulasAvaliacoes"
                                    ${proposta.recursoP != null && proposta.recursoP.adaptacaoDidaticaAulasAvaliacoes ? 'checked' : ''}>
                                <label for="adaptacaoDidaticaAulasAvaliacoes">Adaptação didática nas aulas e avaliações</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="materialDidaticoAdaptado"
                                    name="recursoP_materialDidaticoAdaptado"
                                    ${proposta.recursoP != null && proposta.recursoP.materialDidaticoAdaptado ? 'checked' : ''}>
                                <label for="materialDidaticoAdaptado">Material didático adaptado</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="usoTecnologiaAssistiva"
                                    name="recursoP_usoTecnologiaAssistiva"
                                    ${proposta.recursoP != null && proposta.recursoP.usoTecnologiaAssistiva ? 'checked' : ''}>
                                <label for="usoTecnologiaAssistiva">Uso de tecnologia assistiva</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="tempoEmpregadoAtividadesAvaliacoes"
                                    name="recursoP_tempoEmpregadoAtividadesAvaliacoes"
                                    ${proposta.recursoP != null && proposta.recursoP.tempoEmpregadoAtividadesAvaliacoes ? 'checked' : ''}>
                                <label for="tempoEmpregadoAtividadesAvaliacoes">Tempo adicional para atividades/avaliações</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Seção: Recursos Físicos/Arquitetônicos -->
                <div class="section-group">
                    <h4>Recursos Físicos/Arquitetônicos</h4>
                    <div class="secao-recursos">
                        <div class="grupo-checkbox">
                            <div class="checkbox-item">
                                <input type="checkbox" id="usoCadeiraDeRodas"
                                    name="recursoFA_usoCadeiraDeRodas"
                                    ${proposta.recursoFA != null && proposta.recursoFA.usoCadeiraDeRodas ? 'checked' : ''}>
                                <label for="usoCadeiraDeRodas">Uso de cadeira de rodas</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="auxilioTranscricaoEscrita"
                                    name="recursoFA_auxilioTranscricaoEscrita"
                                    ${proposta.recursoFA != null && proposta.recursoFA.auxilioTranscricaoEscrita ? 'checked' : ''}>
                                <label for="auxilioTranscricaoEscrita">Auxílio para transcrição escrita</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="mesaAdaptadaCadeiraDeRodas"
                                    name="recursoFA_mesaAdaptadaCadeiraDeRodas"
                                    ${proposta.recursoFA != null && proposta.recursoFA.mesaAdaptadaCadeiraDeRodas ? 'checked' : ''}>
                                <label for="mesaAdaptadaCadeiraDeRodas">Mesa adaptada para cadeira de rodas</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="usoDeMuleta"
                                    name="recursoFA_usoDeMuleta"
                                    ${proposta.recursoFA != null && proposta.recursoFA.usoDeMuleta ? 'checked' : ''}>
                                <label for="usoDeMuleta">Uso de muleta</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="outrosFisicoArquitetonico"
                                    name="recursoFA_outrosFisicoArquitetonico"
                                    onchange="toggleOutrosEspecificado(this)"
                                    ${proposta.recursoFA != null && proposta.recursoFA.outrosFisicoArquitetonico ? 'checked' : ''}>
                                <label for="outrosFisicoArquitetonico">Outros recursos</label>
                            </div>
                            <div class="input-group" id="outrosEspecificadoContainer" style="display: ${proposta.recursoFA != null && proposta.recursoFA.outrosFisicoArquitetonico ? 'block' : 'none'};">
                                <label for="outrosEspecificado">Especificar outros recursos:</label>
                                <input type="text" id="outrosEspecificado"
                                    name="recursoFA_outrosEspecificado"
                                    placeholder="Digite os recursos adicionais"
                                    value="${proposta.recursoFA != null ? proposta.recursoFA.outrosEspecificado : ''}">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Seção: Recursos de Comunicação e Informação -->
                <div class="section-group">
                    <h4>Recursos de Comunicação e Informação</h4>
                    <div class="secao-recursos">
                        <div class="grupo-checkbox">
                            <div class="checkbox-item">
                                <input type="checkbox" id="comunicacaoAlternativa"
                                    name="recursoCI_comunicacaoAlternativa"
                                    ${proposta.recursoCI != null && proposta.recursoCI.comunicacaoAlternativa ? 'checked' : ''}>
                                <label for="comunicacaoAlternativa">Comunicação alternativa</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="tradutorInterprete"
                                    name="recursoCI_tradutorInterprete"
                                    ${proposta.recursoCI != null && proposta.recursoCI.tradutorInterprete ? 'checked' : ''}>
                                <label for="tradutorInterprete">Tradutor/intérprete</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="leitorTranscritor"
                                    name="recursoCI_leitorTranscritor"
                                    ${proposta.recursoCI != null && proposta.recursoCI.leitorTranscritor ? 'checked' : ''}>
                                <label for="leitorTranscritor">Leitor/transcritor</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="interpreteOralizador"
                                    name="recursoCI_interpreteOralizador"
                                    ${proposta.recursoCI != null && proposta.recursoCI.interpreteOralizador ? 'checked' : ''}>
                                <label for="interpreteOralizador">Intérprete oralizador</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="guiaInterprete"
                                    name="recursoCI_guiaInterprete"
                                    ${proposta.recursoCI != null && proposta.recursoCI.guiaInterprete ? 'checked' : ''}>
                                <label for="guiaInterprete">Guia-intérprete</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="materialDidaticoBraille"
                                    name="recursoCI_materialDidaticoBraille"
                                    ${proposta.recursoCI != null && proposta.recursoCI.materialDidaticoBraille ? 'checked' : ''}>
                                <label for="materialDidaticoBraille">Material em Braille</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="materialDidaticoTextoAmpliado"
                                    name="recursoCI_materialDidaticoTextoAmpliado"
                                    ${proposta.recursoCI != null && proposta.recursoCI.materialDidaticoTextoAmpliado ? 'checked' : ''}>
                                <label for="materialDidaticoTextoAmpliado">Texto ampliado</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="materialDidaticoRelevo"
                                    name="recursoCI_materialDidaticoRelevo"
                                    ${proposta.recursoCI != null && proposta.recursoCI.materialDidaticoRelevo ? 'checked' : ''}>
                                <label for="materialDidaticoRelevo">Material em relevo</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="leitorDeTela"
                                    name="recursoCI_leitorDeTela"
                                    ${proposta.recursoCI != null && proposta.recursoCI.leitorDeTela ? 'checked' : ''}>
                                <label for="leitorDeTela">Leitor de tela</label>
                            </div>
                            <div class="checkbox-item">
                                <input type="checkbox" id="fonteTamanhoEspecifico"
                                    name="recursoCI_fonteTamanhoEspecifico"
                                    ${proposta.recursoCI != null && proposta.recursoCI.fonteTamanhoEspecifico ? 'checked' : ''}>
                                <label for="fonteTamanhoEspecifico">Fonte com tamanho específico</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Observações -->
                <div class="section-group">
                    <h4>Observações Adicionais</h4>
                    <div class="input-group">
                        <label for="observacoes">Informações complementares:</label>
                        <textarea id="observacoes" name="observacoes">${proposta.observacoes}</textarea>
                    </div>
                </div>

                <div class="botoes-acoes">
                    <button type="submit" class="botao-salvar">Atualizar Proposta</button>
                    <button type="button" class="botao-cancelar" onclick="window.history.back()">Cancelar</button>
                </div>
            </form>
        </div>

        <!-- Rodapé -->
        <div class="footer">
            <p>© 2025 AEE+ - Atendimento Educacional Especializado | Todos os direitos reservados</p>
            <p>Desenvolvido com ❤️ para promover uma educação inclusiva e transformadora</p>
        </div>
    </div>

    <script>
        function toggleOutrosEspecificado(checkbox) {
            const container = document.getElementById('outrosEspecificadoContainer');
            container.style.display = checkbox.checked ? 'block' : 'none';
        }
    </script>
</body>
</html>