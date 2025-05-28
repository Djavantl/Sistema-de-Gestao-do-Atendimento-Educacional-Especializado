<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Professores do Aluno</title>
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
            color: #0c0c61;
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

        .header-aluno {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 8px;
        }

        .info-aluno {
            font-size: 16px;
            color: #4D44B5;
        }

        .info-aluno span {
            font-weight: 600;
            color: #2c3e50;
        }

        .linha-superior {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 30px;
        }

        .botao-novo-professor {
            background-color: #4D44B5;
            color: #ffffff;
            border: none;
            padding: 10px 22px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 15px;
            transition: background-color 0.3s;
        }

        .botao-novo-professor:hover {
            background-color: #372e9c;
        }

        .tabela-professores {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            border-radius: 8px;
            overflow: hidden;
        }

        .tabela-professores th {
            background-color: #ecf0f1;
            color: #2c3e50;
            text-align: left;
            padding: 14px;
        }

        .tabela-professores td {
            background-color: #ffffff;
            padding: 14px;
            border-bottom: 1px solid #e0e0e0;
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
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            margin: 20px;
        }

        .botoes-modal {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
            gap: 10px;
        }

        .container-acoes {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
        }

        .botao-acao {
            padding: 6px 12px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 13px;
        }

        .botao-acao i {
            font-size: 12px;
        }

        .botao-excluir {
            background-color: #dc3545;
            color: white;
        }

        .botao-excluir:hover {
            background-color: #bb2d3b;
        }

        select {
            width: 100%;
            padding: 10px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-top: 4px;
            margin-bottom: 16px;
            background-color: #fefefe;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        select:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
        }

        .erro {
            position: fixed;
            top: 20px;
            right: 20px;
            background: #dc3545;
            color: white;
            padding: 15px;
            border-radius: 5px;
            z-index: 10000;
        }

        @media (max-width: 768px) {
            #titulo h2 {
                margin-left: 20px;
                font-size: 1.5rem;
            }

            .conteudo-principal {
                margin: 100px 20px 40px;
                width: auto;
            }

            .header-aluno {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .modal-conteudo {
                padding: 15px;
                width: 95%;
            }

            .container-acoes {
                flex-wrap: wrap;
                justify-content: flex-start;
            }

            .botao-acao {
                flex: 1 1 45%;
            }
        }

        @media (max-width: 480px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
            }

            #titulo h2 {
                margin-left: 0;
                text-align: center;
            }

            .conteudo-principal {
                margin: 20px;
                width: auto;
            }
        }

        /* Adicionais específicos para esta página */
        .header-aluno {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 8px;
        }

        .info-aluno {
            font-size: 16px;
            color: #4D44B5;
        }

        .info-aluno span {
            font-weight: 600;
        }

        /* Modal Overlay - Base */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            animation: fadeIn 0.3s ease-out;
        }

        /* Conteúdo do Modal */
        .modal-conteudo {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 450px;
            transform: scale(0.95);
            animation: modalAppear 0.3s ease-out forwards;
            overflow: hidden;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes modalAppear {
            from { transform: scale(0.95); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        /* Cabeçalho do Modal */
        .modal-conteudo h2,
        .modal-conteudo h3 {
            color: #4D44B5;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            font-size: 1.5rem;
        }

        /* Formulários dentro do Modal */
        .modal-conteudo form {
            padding: 25px;
        }

        .modal-conteudo label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .modal-conteudo select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234D44B5' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
        }

        .modal-conteudo select:focus {
            border-color: #4D44B5;
            box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
            outline: none;
            background-color: #fff;
        }

        /* Botões do Modal */
        .botoes-modal {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            margin-top: 25px;
        }

        .botoes-modal button {
            padding: 10px 24px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .botoes-modal button[type="submit"] {
            background-color: #4D44B5;
            color: white;
            border: 2px solid #4D44B5;
        }

        .botoes-modal button[type="submit"]:hover {
            background-color: #3b32a0;
            border-color: #3b32a0;
        }

        .botoes-modal button[type="button"] {
            background-color: transparent;
            color: #6c757d;
            border: 2px solid #e0e0e0;
        }

        .botoes-modal button[type="button"]:hover {
            background-color: #f8f9fa;
            color: #4D44B5;
            border-color: #4D44B5;
        }

        /* Modal de Confirmação Específico */
        #modalDesvincular .modal-conteudo {
            text-align: center;
        }

        #modalDesvincular p {
            color: #666;
            margin: 15px 0 25px;
            line-height: 1.5;
        }

        /* Responsividade */
        @media (max-width: 480px) {
            .modal-conteudo {
                width: 95%;
                padding: 20px;
            }

            .botoes-modal {
                flex-direction: column;
            }

            .botoes-modal button {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <!-- Mantemos a mesma sidebar -->
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo" />
            <h2>Inclui+</h2>
        </div>
        <div class="menu">
            <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn ativo" onclick="window.location.href='/templates/aee/professores'">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>

        </div>
    </div>

    <div id="titulo">
        <h2>Professores do Aluno</h2>
    </div>
    <div class="conteudo-principal">
        <div class="header-aluno">
            <div class="info-aluno">
                Aluno: <span>${aluno.nome}</span> | Matrícula: <span>${aluno.matricula}</span>
            </div>
            <button class="botao-novo-professor" onclick="abrirModal(modais.vincular)">+ Adicionar Professor</button>
        </div>

        <!-- Modal Vincular Professor -->
        <div class="modal-overlay" id="modalVincularProfessor">
            <div class="modal-conteudo">
                <h2>Vincular Professor</h2>
                <form id="formVincularProfessor"
                      action="${pageContext.request.contextPath}/templates/aee/professores-aluno?acao=vincular&matricula=${aluno.matricula}"
                      method="POST">
                    <label for="professorSelect">Selecione o Professor:</label>
                    <select id="professorSelect" name="siape" required>
                        <option value="">Selecione um professor</option>
                        <c:forEach items="${todosProfessores}" var="prof">
                            <option value="${prof.siape}">${prof.nome} (${prof.especialidade})</option>
                        </c:forEach>
                    </select>

                    <div class="botoes-modal">
                        <button type="submit">Vincular</button>
                        <button type="button" onclick="fecharModal(modalVincularProfessor)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tabela de Professores Vinculados -->
        <table class="tabela-professores">
            <thead>
                <tr>
                    <th>Nome</th>
                    <th>SIAPE</th>
                    <th>Cursos</th>
                    <th style="width: 150px">Ações</th>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${empty professoresAluno}">
                        <tr>
                            <td colspan="4">Nenhum professor vinculado</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${professoresAluno}" var="prof">
                            <tr class="linha-principal" data-id="${prof.siape}">
                                <td>${prof.nome}</td>
                                <td>${prof.siape}</td>
                                <td>${prof.especialidade}</td>
                                <td>
                                    <div class="container-acoes">
                                        <button class="botao-acao botao-excluir"
                                                onclick="confirmarDesvinculacao('${prof.siape}')">
                                            <i class="fas fa-unlink"></i> Remover
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <!-- Modal Confirmação Desvinculação -->
        <div class="modal-overlay" id="modalDesvincular">
            <div class="modal-conteudo">
                <h3>Confirmar Desvinculação</h3>
                <p>Tem certeza que deseja remover este professor?</p>
                <form id="formDesvincularProfessor"
                      action="${pageContext.request.contextPath}/templates/aee/professores-aluno?acao=desvincular&matricula=${aluno.matricula}"
                      method="POST">
                    <input type="hidden" name="siape" id="siapeDesvincular">
                    <div class="botoes-modal">
                        <button type="submit">Confirmar</button>
                        <button type="button" onclick="fecharModal(modalDesvincular)">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <<script>
         const modais = {
             vincular: document.getElementById('modalVincularProfessor'),
             desvincular: document.getElementById('modalDesvincular')
         };

         function abrirModal(modal) {
             modal.style.display = 'flex';
         }

         function fecharModal(modal) {
             modal.style.display = 'none';
         }

         function confirmarDesvinculacao(siape) {
             document.getElementById('siapeDesvincular').value = siape;
             abrirModal(modais.desvincular);
         }

         // Fechar modais clicando fora do conteúdo
         window.addEventListener('click', function(event) {
             for (const key in modais) {
                 if (event.target === modais[key]) {
                     fecharModal(modais[key]);
                 }
             }
         });
     </script>

</body>
</html>