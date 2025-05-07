<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro Completo de Aluno</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
        .form-section {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        h1, h2 {
            color: #2c3e50;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input, select, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button {
            margin-top: 15px;
            padding: 10px 15px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        button:hover {
            background: #2980b9;
        }
        .item-list {
            margin-top: 10px;
        }
        .item {
            display: flex;
            justify-content: space-between;
            background: #f0f0f0;
            padding: 8px;
            margin-bottom: 5px;
            border-radius: 4px;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
        }
        .modal-content {
            background: white;
            margin: 5% auto;
            padding: 20px;
            width: 80%;
            max-width: 800px;
            border-radius: 5px;
            max-height: 80vh;
            overflow-y: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .close-modal {
            float: right;
            cursor: pointer;
            font-size: 24px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Cadastro Completo de Aluno</h1>

        <form action="aluno" method="post">
            <!-- Seção 1: Dados Pessoais -->
            <div class="form-section">
                <h2>Dados Pessoais</h2>

                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required>

                <label for="dataNascimento">Data de Nascimento:</label>
                <input type="date" id="dataNascimento" name="dataNascimento" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email">

                <label for="sexo">Sexo:</label>
                <input type="text" id="sexo" name="sexo">

                <label for="naturalidade">Naturalidade:</label>
                <input type="text" id="naturalidade" name="naturalidade">

                <label for="telefone">Telefone:</label>
                <input type="tel" id="telefone" name="telefone">
            </div>

            <!-- Seção 2: Dados Escolares -->
            <div class="form-section">
                <h2>Dados Escolares</h2>

                <label for="matricula">Matrícula:</label>
                <input type="text" id="matricula" name="matricula" required>

                <label for="responsavel">Responsável:</label>
                <input type="text" id="responsavel" name="responsavel" required>

                <label for="telResponsavel">Telefone do Responsável:</label>
                <input type="tel" id="telResponsavel" name="telResponsavel" required>

                <label for="telTrabalho">Telefone do Trabalho:</label>
                <input type="tel" id="telTrabalho" name="telTrabalho">

                <label for="curso">Curso:</label>
                <input type="text" id="curso" name="curso" required>

                <label for="turma">Turma:</label>
                <input type="text" id="turma" name="turma" required>
            </div>

            <!-- Seção 3: Deficiências -->
            <div class="form-section">
                <h2>Deficiências</h2>
                <div id="deficienciesList" class="item-list"></div>
                <button type="button" onclick="openModal('deficiencyModal')">Adicionar Deficiências</button>
            </div>

            <!-- Seção 4: Plano AEE -->
            <div class="form-section">
                <h2>Plano AEE</h2>
                <div id="planoContainer">
                    <label for="planoDataInicio">Data de Início:</label>
                    <input type="date" id="planoDataInicio" name="planoDataInicio">

                    <label for="planoRecomendacoes">Recomendações:</label>
                    <textarea id="planoRecomendacoes" name="planoRecomendacoes" rows="3"></textarea>
                </div>
            </div>

            <!-- Seção 5: Relatórios -->
            <div class="form-section">
                <h2>Relatórios</h2>
                <div id="relatoriosList" class="item-list"></div>
                <button type="button" onclick="openModal('relatorioModal')">Adicionar Relatório</button>
            </div>

            <!-- Seção 6: Professores -->
            <div class="form-section">
                <h2>Professores</h2>
                <div id="professoresList" class="item-list"></div>
                <button type="button" onclick="openModal('professorModal')">Adicionar Professor</button>
            </div>

            <button type="submit">Salvar Aluno</button>
        </form>
    </div>

    <!-- Modal para Deficiências -->
    <div id="deficiencyModal" class="modal">
        <div class="modal-content">
            <span class="close-modal" onclick="closeModal('deficiencyModal')">&times;</span>
            <h2>Selecione as Deficiências</h2>

            <table>
                <thead>
                    <tr>
                        <th>Selecionar</th>
                        <th>Descrição</th>
                        <th>Tipo</th>
                    </tr>
                </thead>
                <tbody id="modalDeficienciesList"></tbody>
            </table>

            <button onclick="addSelectedItems('deficiency')">Adicionar Selecionadas</button>
            <button onclick="closeModal('deficiencyModal')">Cancelar</button>
        </div>
    </div>

    <!-- Modal para Relatórios -->
    <div id="relatorioModal" class="modal">
        <div class="modal-content">
            <span class="close-modal" onclick="closeModal('relatorioModal')">&times;</span>
            <h2>Adicionar Relatório</h2>

            <label for="relatorioTitulo">Título:</label>
            <input type="text" id="relatorioTitulo">

            <label for="relatorioData">Data:</label>
            <input type="date" id="relatorioData">

            <label for="relatorioResumo">Resumo:</label>
            <textarea id="relatorioResumo" rows="4"></textarea>

            <button onclick="addRelatorio()">Adicionar Relatório</button>
            <button onclick="closeModal('relatorioModal')">Cancelar</button>
        </div>
    </div>

    <!-- Modal para Professores -->
    <div id="professorModal" class="modal">
        <div class="modal-content">
            <span class="close-modal" onclick="closeModal('professorModal')">&times;</span>
            <h2>Selecione os Professores</h2>

            <table>
                <thead>
                    <tr>
                        <th>Selecionar</th>
                        <th>Nome</th>
                        <th>SIAPE</th>
                        <th>Especialidade</th>
                    </tr>
                </thead>
                <tbody id="modalProfessoresList"></tbody>
            </table>

            <button onclick="addSelectedItems('professor')">Adicionar Selecionados</button>
            <button onclick="closeModal('professorModal')">Cancelar</button>
        </div>
    </div>
</body>
</html>