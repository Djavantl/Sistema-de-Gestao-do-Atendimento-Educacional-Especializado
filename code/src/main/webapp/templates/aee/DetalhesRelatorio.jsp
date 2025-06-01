<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Relatório</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f9f9ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
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

        .logo h2 {
            color: white;
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

        #titulo {
            margin-left: 350px;
            padding-top: 40px;
        }

        #titulo h2 {
            color: rgb(12, 12, 97);
            font-size: 28px;
        }

        .conteudo-principal {
            background-color: #ffffff;
            border-radius: 20px;
            padding: 40px;
            margin: 30px 0 40px 350px;
            width: 70%;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }

        .detalhes-relatorio {
            display: grid;
            gap: 25px;
        }

        .info-box {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            border-left: 4px solid #4D44B5;
        }

        .info-box h3 {
            color: #4D44B5;
            margin-bottom: 15px;
        }

        .campo {
            margin-bottom: 15px;
        }

        .campo label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 14px;
            display: block;
            margin-bottom: 5px;
        }

        .campo .valor {
            padding: 10px;
            background-color: #fefefe;
            border-radius: 8px;
            border: 1px solid #eaeaea;
            min-height: 40px;
        }

        .botoes-acoes {
            margin-top: 30px;
            display: flex;
            gap: 15px;
            justify-content: flex-end;
            width: 100%;
        }

        .botao-voltar {
            background-color: #e0e0e0;
            color: #333;
            padding: 12px 25px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .botao-voltar:hover {
            background-color: #d0d0d0;
        }

        /* Novos estilos para avaliações */
                .avaliacoes-container {
                    margin-top: 20px;
                    border-radius: 8px;
                    overflow: hidden;
                }

                .avaliacao-item {
                    padding: 15px;
                    background-color: #fff;
                }

                .avaliacao-item.separador {
                    border-bottom: 2px solid #bfbfbf;
                }

                .acoes-avaliacao {
                    grid-column: 1 / -1;
                    display: flex;
                    justify-content: flex-end;
                    gap: 10px;
                    padding: 10px 0;
                    margin-top: 10px;
                }

                .botao-adicionar {
                    background-color: #4D44B5;
                    color: white;
                    border: none;
                    padding: 10px 15px;
                    border-radius: 8px;
                    cursor: pointer;
                    margin-bottom: 15px;
                }

                .botao-editar-avaliacao {
                    background-color: #007bff;
                    color: white;
                    border: none;
                    padding: 6px 12px;
                    border-radius: 6px;
                    cursor: pointer;
                    font-size: 13px;
                }

                .botao-excluir-avaliacao {
                    background-color: #dc3545;
                    color: white;
                    border: none;
                    padding: 6px 12px;
                    border-radius: 6px;
                    cursor: pointer;
                    font-size: 13px;
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
            <button class="menu-btn" onclick="window.location.href='/templates/aee/alunos'">Estudantes</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/professor'">Professores</button>
            <button class="menu-btn" onclick="window.location.href='/templates/aee/sessoes'">Sessões</button>
            <button class="menu-btn ativo">Relatórios</button>
        </div>
    </div>

    <div id="titulo">
        <h2>Detalhes do Relatório</h2>
    </div>

    <div class="conteudo-principal">

            <!-- Resumo -->
            <div class="info-box">
                <h3>Resumo</h3>
                <div class="campo">
                    <div class="valor" style="min-height: 150px;">${relatorio.resumo}</div>
                </div>
            </div>

            <!-- Observações -->
            <div class="info-box">
                <h3>Observações</h3>
                <div class="campo">
                    <div class="valor" style="min-height: 100px;">
                        <c:choose>
                            <c:when test="${not empty relatorio.observacoes}">
                                ${relatorio.observacoes}
                            </c:when>
                            <c:otherwise>
                                Nenhuma observação registrada
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Seção de Avaliações -->
                        <div class="info-box">
                            <h3>Avaliações</h3>

                            <button class="botao-adicionar"
                                onclick="window.location.href='${pageContext.request.contextPath}/avaliacao?acao=criar&relatorioId=${relatorio.id}'">
                                Adicionar Avaliação
                            </button>

                            <c:if test="${not empty relatorio.avaliacoes}">
                                <div class="avaliacoes-container">
                                    <c:forEach items="${relatorio.avaliacoes}" var="avaliacao" varStatus="loop">
                                        <div class="avaliacao-item ${not loop.last ? 'separador' : ''}">
                                            <div class="info-grid">
                                                <div class="info-item">
                                                    <label>Área</label>
                                                    <div class="valor">${avaliacao.area}</div>
                                                </div>
                                                <div class="info-item">
                                                    <label>Desempenho Verificado</label>
                                                    <div class="valor">${avaliacao.desempenhoVerificado}</div>
                                                </div>
                                                <div class="info-item">
                                                    <label>Observações</label>
                                                    <div class="valor">${avaliacao.observacoes}</div>
                                                </div>
                                                <div class="acoes-avaliacao">
                                                    <button class="botao-editar-avaliacao"
                                                        onclick="window.location.href='${pageContext.request.contextPath}/avaliacao?acao=editar&id=${avaliacao.id}&relatorioId=${relatorio.id}'">
                                                        Editar
                                                    </button>
                                                    <form action="${pageContext.request.contextPath}/avaliacao" method="POST" style="display:inline;">
                                                        <input type="hidden" name="acao" value="excluir">
                                                        <input type="hidden" name="id" value="${avaliacao.id}">
                                                        <input type="hidden" name="relatorioId" value="${relatorio.id}">
                                                        <button type="submit" class="botao-excluir-avaliacao"
                                                            onclick="return confirm('Tem certeza que deseja excluir esta avaliação?')">
                                                            Excluir
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>

            <!-- Botão Voltar -->
            <div class="botoes-acoes">
                <button class="botao-voltar"
                        onclick="window.location.href='${pageContext.request.contextPath}/relatorios'">
                    Voltar
                </button>
            </div>
        </div>
    </div>
</body>
</html>