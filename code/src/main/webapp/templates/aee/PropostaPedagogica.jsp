<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Propostas Pedagógicas</title>
    <style>
        @import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css');

        /* Estilos gerais mantidos da página de alunos */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f9f9ff;
            overflow-x: hidden;
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

        .menu-btn.ativo {
            background-color: #f9f9ff;
            color: #4D44B5;
        }

        .menu-btn:hover {
            background-color: rgba(255, 255, 255, 0.15);
        }

        /* Estilos específicos para Propostas Pedagógicas */
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

        .form-proposta {
            display: grid;
            gap: 25px;
        }

        .grupo-campos {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
        }

        .campo {
            display: flex;
            flex-direction: column;
        }

        .campo label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .campo input,
        .campo select,
        .campo textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            background-color: #fefefe;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .campo textarea {
            height: 120px;
            resize: vertical;
        }

        .secao-recursos {
            margin-top: 20px;
            padding: 20px;
            border-radius: 12px;
            background-color: #f8f9fa;
        }

        .secao-titulo {
            color: #4D44B5;
            font-size: 18px;
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
        }

        .checkbox-item input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #4D44B5;
        }

        .botoes-acoes {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
        }

        .botao-salvar {
            background-color: #4D44B5;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .botao-cancelar {
            background-color: #e0e0e0;
            color: #333;
            padding: 12px 25px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
    </style>
</head>
    <!-- Sidebar idêntica à página de alunos -->
    <div class="sidebar">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>
            <button class="menu-btn">Usuários</button>
        </div>
    </div>
    <div id="titulo">
        <h2>Propostas Pedagógicas</h2>
    </div>
    <div class="conteudo-principal">
        <form class="form-proposta" action="${pageContext.request.contextPath}/propostas" method="POST">
            <!-- Campos principais -->
            <div class="grupo-campos">
                <div class="campo">
                    <label for="objetivos">Objetivos:</label>
                    <textarea id="objetivos" name="objetivos" required></textarea>
                </div>

                <div class="campo">
                    <label for="metodologias">Metodologias:</label>
                    <textarea id="metodologias" name="metodologias" required></textarea>
                </div>
            </div>

            <!-- Recursos Pedagógicos -->
            <div class="secao-recursos">
                <h3 class="secao-titulo">Recursos Pedagógicos</h3>
                <div class="grupo-checkbox">
                    <div class="checkbox-item">
                        <input type="checkbox" id="adaptacaoDidaticaAulasAvaliacoes"
                            name="recursoP_adaptacaoDidaticaAulasAvaliacoes">
                        <label for="adaptacaoDidaticaAulasAvaliacoes">Adaptação didática nas aulas e avaliações</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="materialDidaticoAdaptado"
                            name="recursoP_materialDidaticoAdaptado">
                        <label for="materialDidaticoAdaptado">Material didático adaptado</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="usoTecnologiaAssistiva"
                            name="recursoP_usoTecnologiaAssistiva">
                        <label for="usoTecnologiaAssistiva">Uso de tecnologia assistiva</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="tempoEmpregadoAtividadesAvaliacoes"
                            name="recursoP_tempoEmpregadoAtividadesAvaliacoes">
                        <label for="tempoEmpregadoAtividadesAvaliacoes">Tempo adicional para atividades/avaliações</label>
                    </div>
                </div>
            </div>

            <!-- Recursos Físicos/Arquitetônicos -->
            <div class="secao-recursos">
                <h3 class="secao-titulo">Recursos Físicos/Arquitetônicos</h3>
                <div class="grupo-checkbox">
                    <div class="checkbox-item">
                        <input type="checkbox" id="usoCadeiraDeRodas"
                            name="recursoFA_usoCadeiraDeRodas">
                        <label for="usoCadeiraDeRodas">Uso de cadeira de rodas</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="auxilioTranscricaoEscrita"
                            name="recursoFA_auxilioTranscricaoEscrita">
                        <label for="auxilioTranscricaoEscrita">Auxílio para transcrição escrita</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="mesaAdaptadaCadeiraDeRodas"
                            name="recursoFA_mesaAdaptadaCadeiraDeRodas">
                        <label for="mesaAdaptadaCadeiraDeRodas">Mesa adaptada para cadeira de rodas</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="usoDeMuleta"
                            name="recursoFA_usoDeMuleta">
                        <label for="usoDeMuleta">Uso de muleta</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="outrosFisicoArquitetonico"
                            name="recursoFA_outrosFisicoArquitetonico"
                            onchange="toggleOutrosEspecificado(this)">
                        <label for="outrosFisicoArquitetonico">Outros recursos</label>
                    </div>
                    <div class="campo" id="outrosEspecificadoContainer" style="display: none;">
                        <input type="text" id="outrosEspecificado"
                            name="recursoFA_outrosEspecificado"
                            placeholder="Especificar outros recursos">
                    </div>
                </div>
            </div>

            <!-- Recursos de Comunicação e Informação -->
            <div class="secao-recursos">
                <h3 class="secao-titulo">Recursos de Comunicação e Informação</h3>
                <div class="grupo-checkbox">
                    <div class="checkbox-item">
                        <input type="checkbox" id="comunicacaoAlternativa"
                            name="recursoCI_comunicacaoAlternativa">
                        <label for="comunicacaoAlternativa">Comunicação alternativa</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="tradutorInterprete"
                            name="recursoCI_tradutorInterprete">
                        <label for="tradutorInterprete">Tradutor/intérprete</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="leitorTranscritor"
                            name="recursoCI_leitorTranscritor">
                        <label for="leitorTranscritor">Leitor/transcritor</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="interpreteOralizador"
                            name="recursoCI_interpreteOralizador">
                        <label for="interpreteOralizador">Intérprete oralizador</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="guiaInterprete"
                            name="recursoCI_guiaInterprete">
                        <label for="guiaInterprete">Guia-intérprete</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="materialDidaticoBraille"
                            name="recursoCI_materialDidaticoBraille">
                        <label for="materialDidaticoBraille">Material em Braille</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="materialDidaticoTextoAmpliado"
                            name="recursoCI_materialDidaticoTextoAmpliado">
                        <label for="materialDidaticoTextoAmpliado">Texto ampliado</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="materialDidaticoRelevo"
                            name="recursoCI_materialDidaticoRelevo">
                        <label for="materialDidaticoRelevo">Material em relevo</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="leitorDeTela"
                            name="recursoCI_leitorDeTela">
                        <label for="leitorDeTela">Leitor de tela</label>
                    </div>
                    <div class="checkbox-item">
                        <input type="checkbox" id="fonteTamanhoEspecifico"
                            name="recursoCI_fonteTamanhoEspecifico">
                        <label for="fonteTamanhoEspecifico">Fonte com tamanho específico</label>
                    </div>
                </div>
            </div>

            <div class="botoes-acoes">
                <button type="submit" class="botao-salvar">Salvar Proposta</button>
                <button type="button" class="botao-cancelar" onclick="window.history.back()">Cancelar</button>
            </div>
        </form>
    </div>

    <script>
        function toggleOutrosEspecificado(checkbox) {
            const container = document.getElementById('outrosEspecificadoContainer');
            container.style.display = checkbox.checked ? 'block' : 'none';
        }
    </script>
</html>