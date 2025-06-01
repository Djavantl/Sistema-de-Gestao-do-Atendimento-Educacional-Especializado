<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro - AEE+</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }

                body {
                    background-color: #4D44B5;
                    min-height: 100vh;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    justify-content: center;
                    padding: 20px;
                }

                .cabecalho {
                    width: 100%;
                    position: fixed;
                    top: 0;
                    left: 0;
                    padding: 20px 40px;
                    background-color: rgba(255, 255, 255, 0.1);
                    backdrop-filter: blur(10px);
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                    z-index: 100;
                }

                .logo {
                    display: flex;
                    align-items: center;
                    gap: 15px;
                }

                .logo img {
                    width: 40px;
                    height: 40px;
                    object-fit: contain;
                }

                .logo h1 {
                    color: white;
                    font-size: 24px;
                    font-weight: 600;
                }

                .cadastro-container {
                    background-color: white;
                    width: 100%;
                    max-width: 500px;
                    border-radius: 20px;
                    padding: 40px;
                    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
                    margin-top: 80px;
                    margin-bottom: 40px;
                }

                .cadastro-header {
                    text-align: center;
                    margin-bottom: 30px;
                }

                .cadastro-header h2 {
                    color: #2c3e50;
                    font-size: 28px;
                    margin-bottom: 10px;
                }

                .cadastro-header p {
                    color: #7f8c8d;
                    font-size: 16px;
                }

                .tipo-usuario {
                    display: flex;
                    justify-content: space-between;
                    margin-bottom: 25px;
                    border-bottom: 1px solid #ecf0f1;
                }

                .tipo-btn {
                    flex: 1;
                    text-align: center;
                    padding: 15px;
                    cursor: pointer;
                    color: #7f8c8d;
                    font-weight: 600;
                    transition: all 0.3s ease;
                    border-bottom: 3px solid transparent;
                }

                .tipo-btn:hover {
                    color: #4D44B5;
                }

                .tipo-btn.ativo {
                    color: #4D44B5;
                    border-bottom: 3px solid #4D44B5;
                }

                .form-group {
                    margin-bottom: 20px;
                }

                .form-group label {
                    display: block;
                    margin-bottom: 8px;
                    color: #2c3e50;
                    font-weight: 600;
                    font-size: 14px;
                }

                .form-group input {
                    width: 100%;
                    padding: 14px;
                    font-size: 16px;
                    border: 1px solid #e0e0e0;
                    border-radius: 10px;
                    background-color: #f9f9ff;
                    transition: border-color 0.3s, box-shadow 0.3s;
                }

                .form-group input:focus {
                    border-color: #4D44B5;
                    box-shadow: 0 0 0 3px rgba(77, 68, 181, 0.15);
                    outline: none;
                }

                .campo-obrigatorio {
                    color: #e74c3c;
                    margin-left: 4px;
                }

                .botao-cadastrar {
                    width: 100%;
                    padding: 16px;
                    background-color: #4D44B5;
                    color: white;
                    border: none;
                    border-radius: 10px;
                    font-size: 16px;
                    font-weight: 600;
                    cursor: pointer;
                    transition: background-color 0.3s;
                    margin-top: 10px;
                }

                .botao-cadastrar:hover {
                    background-color: #372e9c;
                }

                .ja-tem-conta {
                    text-align: center;
                    color: #7f8c8d;
                    font-size: 15px;
                    margin-top: 20px;
                }

                .ja-tem-conta a {
                    color: #4D44B5;
                    text-decoration: none;
                    font-weight: 600;
                    transition: color 0.3s;
                }

                .ja-tem-conta a:hover {
                    color: #372e9c;
                    text-decoration: underline;
                }

                .rodape {
                    width: 100%;
                    text-align: center;
                    padding: 20px;
                    color: rgba(255, 255, 255, 0.7);
                    font-size: 14px;
                }

                .info-box {
                    background-color: #f8f9ff;
                    border-radius: 10px;
                    padding: 15px;
                    margin-bottom: 20px;
                    border-left: 4px solid #4D44B5;
                }

                .info-box p {
                    color: #5d6d7e;
                    font-size: 14px;
                    line-height: 1.5;
                }

                @media (max-width: 550px) {
                    .cadastro-container {
                        padding: 30px 20px;
                        margin-top: 70px;
                    }

                    .cabecalho {
                        padding: 15px 20px;
                    }

                    .logo h1 {
                        font-size: 20px;
                    }

                    .tipo-usuario {
                        flex-direction: column;
                    }
                }

        /* Adicionar novos estilos para mensagens */
        .mensagens-container {
            position: fixed;
            top: 100px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            width: 80%;
            max-width: 500px;
        }

        .mensagem-sucesso {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .mensagem-erro {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <!-- Cabeçalho com logo e nome do sistema -->
    <header class="cabecalho">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo AEE+">
            <h1>AEE+</h1>
        </div>
    </header>

    <!-- Container para mensagens -->
    <div class="mensagens-container">
        <c:if test="${not empty mensagemSucesso}">
            <div class="mensagem-sucesso">
                ${mensagemSucesso}
            </div>
        </c:if>
        <c:if test="${not empty mensagemErro}">
            <div class="mensagem-erro">
                ${mensagemErro}
            </div>
        </c:if>
    </div>

    <!-- Container principal de cadastro -->
    <div class="cadastro-container">
        <div class="cadastro-header">
            <h2>Crie sua conta no AEE+</h2>
            <p>Selecione o tipo de conta e crie suas credenciais</p>
        </div>

        <!-- Informação sobre o cadastro -->
        <div class="info-box">
            <p><strong>Atenção:</strong> Para criar sua conta, você deve estar previamente cadastrado no sistema como aluno ou professor. Seu acesso será liberado após a verificação de sua matrícula ou SIAPE.</p>
        </div>

        <!-- Seletor de tipo de usuário -->
        <div class="tipo-usuario">
            <div class="tipo-btn ativo" data-tipo="aluno">Aluno</div>
            <div class="tipo-btn" data-tipo="professor">Professor</div>
            <div class="tipo-btn" data-tipo="professorAEE">Professor AEE</div>
        </div>

        <!-- Formulário de cadastro -->
        <form id="formCadastro" action="${pageContext.request.contextPath}/cadastro" method="POST">
            <input type="hidden" id="tipo" name="tipo" value="aluno">
            <!-- Campo de identificação dinâmico -->
            <div class="form-group">
                <label for="identificacao" id="labelIdentificacao">Matrícula <span class="campo-obrigatorio">*</span></label>
                <input type="text" id="identificacao" name="identificacao" placeholder="Digite sua matrícula" required>
            </div>

            <!-- Campos de senha -->
            <div class="form-group">
                <label for="senha">Senha <span class="campo-obrigatorio">*</span></label>
                <input type="password" id="senha" name="senha" placeholder="Crie uma senha segura" required>
            </div>

            <div class="form-group">
                <label for="confirmarSenha">Confirmar Senha <span class="campo-obrigatorio">*</span></label>
                <input type="password" id="confirmarSenha" name="confirmarSenha" placeholder="Confirme sua senha" required>
            </div>

            <button type="submit" class="botao-cadastrar">Criar Conta</button>
        </form>

        <div class="ja-tem-conta">
            Já tem uma conta? <a href="/templates/usuarios/login.jsp">Faça login</a>
        </div>
    </div>

    <!-- Rodapé -->
    <footer class="rodape">
        <p>Sistema de Atendimento Educacional Especializado &copy; 2025 AEE+</p>
    </footer>

    <script>
        // Controle do tipo de usuário selecionado
        const tipoBtns = document.querySelectorAll('.tipo-btn');
        const labelIdentificacao = document.getElementById('labelIdentificacao');
        const inputIdentificacao = document.getElementById('identificacao');

        tipoBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                // Remove classe ativa de todos os botões
                tipoBtns.forEach(b => b.classList.remove('ativo'));

                // Adiciona classe ativa ao botão clicado
                btn.classList.add('ativo');

                // Atualiza o placeholder conforme o tipo selecionado
                const tipo = btn.getAttribute('data-tipo');

                switch(tipo) {
                    case 'aluno':
                        labelIdentificacao.textContent = 'Matrícula';
                        inputIdentificacao.placeholder = 'Digite sua matrícula';
                        break;
                    case 'professor':
                    case 'professorAEE':
                        labelIdentificacao.textContent = 'SIAPE';
                        inputIdentificacao.placeholder = 'Digite seu SIAPE';
                        break;
                }

                // Atualiza o campo tipo oculto
                document.getElementById('tipo').value = tipo;
            });
        });

        // Controle do envio do formulário
        document.getElementById('formCadastro').addEventListener('submit', function(e) {
            const identificacao = document.getElementById('identificacao').value;
            const senha = document.getElementById('senha').value;
            const confirmarSenha = document.getElementById('confirmarSenha').value;

            // Verificação básica de senha
            if (senha !== confirmarSenha) {
                e.preventDefault();
                alert('As senhas não coincidem!');
                return;
            }

            if (senha.length < 6) {
                e.preventDefault();
                alert('A senha deve ter pelo menos 6 caracteres!');
                return;
            }
        });
    </script>
</body>
</html>