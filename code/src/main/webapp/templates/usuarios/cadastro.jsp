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
                    width: 80px;
                    height: 80px;
                    object-fit: contain;
                }

                .logo h1 {
                    color: white;
                    font-size: 24px;
                    font-weight: 600;
                }

                .cadastro-container {
                            background: linear-gradient(145deg, #ffffff, #f8f9ff);
                            width: 100%;
                            max-width: 520px;
                            border-radius: 24px;
                            padding: 45px;
                            box-shadow:
                                0 12px 45px rgba(77, 68, 181, 0.25),
                                0 4px 15px rgba(0, 0, 0, 0.1);
                            margin-top: 80px;
                            margin-bottom: 40px;
                            border: 1px solid rgba(77, 68, 181, 0.1);
                            position: relative;
                            overflow: hidden;
                            transition: all 0.4s ease;
                        }

                        .cadastro-container:before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            right: 0;
                            height: 5px;
                            background: linear-gradient(90deg, #4D44B5, #6A62C9);
                            border-radius: 24px 24px 0 0;
                        }

                        .cadastro-header {
                            text-align: center;
                            margin-bottom: 35px;
                            position: relative;
                            z-index: 2;
                        }

                        .cadastro-header h2 {
                            color: #2c3e50;
                            font-size: 32px;
                            margin-bottom: 12px;
                            font-weight: 700;
                            background: linear-gradient(90deg, #4D44B5, #6A62C9);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            text-shadow: 0 2px 4px rgba(77, 68, 181, 0.1);
                        }

                        .cadastro-header p {
                            color: #5d6d7e;
                            font-size: 17px;
                            max-width: 90%;
                            margin: 0 auto;
                            line-height: 1.5;
                        }

                        .tipo-usuario {
                            display: flex;
                            justify-content: space-between;
                            margin-bottom: 30px;
                            border-bottom: 1px solid #eef2f7;
                            background: #f8f9ff;
                            border-radius: 12px;
                            overflow: hidden;
                            box-shadow: inset 0 2px 5px rgba(0,0,0,0.05);
                        }

                        .tipo-btn {
                            flex: 1;
                            text-align: center;
                            padding: 16px 5px;
                            cursor: pointer;
                            color: #6c757d;
                            font-weight: 600;
                            transition: all 0.3s ease;
                            position: relative;
                            font-size: 15px;
                            z-index: 1;
                        }

                        .tipo-btn:hover {
                            color: #4D44B5;
                            background: rgba(77, 68, 181, 0.05);
                        }

                        .tipo-btn.ativo {
                            color: #4D44B5;
                            font-weight: 700;
                        }

                        .tipo-btn.ativo:after {
                            content: '';
                            position: absolute;
                            bottom: 0;
                            left: 50%;
                            transform: translateX(-50%);
                            width: 80%;
                            height: 3px;
                            background: #4D44B5;
                            border-radius: 3px 3px 0 0;
                        }

                        .form-group {
                            margin-bottom: 24px;
                            position: relative;
                        }

                        .form-group label {
                            display: flex;
                            align-items: center;
                            margin-bottom: 9px;
                            color: #2c3e50;
                            font-weight: 600;
                            font-size: 15px;
                        }

                        .form-group i {
                            margin-right: 8px;
                            color: #6A62C9;
                            font-size: 15px;
                        }

                        .form-group input {
                            width: 100%;
                            padding: 16px 18px;
                            font-size: 16px;
                            border: 1px solid #e0e0e0;
                            border-radius: 12px;
                            background-color: #f9f9ff;
                            transition: all 0.3s ease;
                            box-shadow: inset 0 2px 5px rgba(0,0,0,0.03);
                        }

                        .form-group input:focus {
                            border-color: #6A62C9;
                            box-shadow:
                                0 0 0 3px rgba(106, 98, 201, 0.2),
                                inset 0 2px 5px rgba(0,0,0,0.03);
                            outline: none;
                        }

                        .campo-obrigatorio {
                            color: #e74c3c;
                            margin-left: 4px;
                        }

                        .botao-cadastrar {
                            width: 100%;
                            padding: 17px;
                            background: linear-gradient(90deg, #4D44B5, #6A62C9);
                            color: white;
                            border: none;
                            border-radius: 12px;
                            font-size: 17px;
                            font-weight: 600;
                            cursor: pointer;
                            transition: all 0.3s;
                            margin-top: 15px;
                            box-shadow:
                                0 5px 15px rgba(77, 68, 181, 0.3),
                                0 2px 5px rgba(0,0,0,0.1);
                            position: relative;
                            overflow: hidden;
                        }

                        .botao-cadastrar:hover {
                            background: linear-gradient(90deg, #3f37a0, #5a52b5);
                            box-shadow:
                                0 7px 20px rgba(77, 68, 181, 0.4),
                                0 3px 8px rgba(0,0,0,0.15);
                            transform: translateY(-2px);
                        }

                        .botao-cadastrar:active {
                            transform: translateY(1px);
                        }

                        .ja-tem-conta {
                            text-align: center;
                            color: #6c757d;
                            font-size: 16px;
                            margin-top: 25px;
                        }

                        .info-box {
                            background: linear-gradient(to right, #f8f9ff, #f0f4ff);
                            border-radius: 14px;
                            padding: 20px;
                            margin-bottom: 25px;
                            border-left: 4px solid #6A62C9;
                            position: relative;
                            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
                        }

                        .info-box:before {
                            content: '\f05a';
                            font-family: 'Font Awesome 5 Free';
                            font-weight: 900;
                            position: absolute;
                            top: 18px;
                            left: -10px;
                            background: #6A62C9;
                            color: white;
                            width: 28px;
                            height: 28px;
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 14px;
                        }

                        .info-box p {
                            color: #5d6d7e;
                            font-size: 14px;
                            line-height: 1.6;
                            padding-left: 10px;
                        }

                        .info-box strong {
                            color: #4D44B5;
                        }

                        /* Adicionar ícones aos campos de formulário */
                        .form-group:after {
                            content: '';
                            position: absolute;
                            right: 18px;
                            top: 40px;
                            font-family: 'Font Awesome 5 Free';
                            font-weight: 900;
                            color: #a0a4c0;
                            font-size: 16px;
                        }

                        #identificacao-container:after {
                            content: '\f2c2';
                        }

                        #senha-container:after {
                            content: '\f023';
                        }

                        #confirmarSenha-container:after {
                            content: '\f023';
                        }

                        /* Efeito de loading no botão */
                        .botao-cadastrar.loading:after {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(255, 255, 255, 0.3);
                            animation: loading 1.5s infinite;
                        }

                        @keyframes loading {
                            0% { transform: translateX(-100%); }
                            100% { transform: translateX(100%); }
                        }

                        /* Animações */
                        @keyframes fadeIn {
                            from { opacity: 0; transform: translateY(10px); }
                            to { opacity: 1; transform: translateY(0); }
                        }

                        .cadastro-container {
                            animation: fadeIn 0.6s ease-out;
                        }

                        .form-group {
                            animation: fadeIn 0.4s ease-out;
                            animation-fill-mode: both;
                        }

                        .form-group:nth-child(1) { animation-delay: 0.1s; }
                        .form-group:nth-child(2) { animation-delay: 0.2s; }
                        .form-group:nth-child(3) { animation-delay: 0.3s; }
                        .botao-cadastrar { animation-delay: 0.4s; }
                        .ja-tem-conta { animation-delay: 0.5s; }

                        /* Responsividade ajustada */
                        @media (max-width: 550px) {
                            .cadastro-container {
                                padding: 35px 25px;
                                border-radius: 20px;
                            }

                            .cadastro-header h2 {
                                font-size: 28px;
                            }

                            .tipo-btn {
                                padding: 14px 5px;
                                font-size: 14px;
                            }
                        }
                    </style>
                </head>
                <body>
                    <!-- Cabeçalho com logo e nome do sistema -->
                    <header class="cabecalho">
                        <div class="logo">
                            <img src="${pageContext.request.contextPath}/static/images/logoAEE.png" alt="Logo AEE+">
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

                    <!-- Container principal de cadastro melhorado -->
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
                            <div class="tipo-btn ativo" data-tipo="aluno">
                                <i class="fas fa-user-graduate"></i> Aluno
                            </div>
                            <div class="tipo-btn" data-tipo="professor">
                                <i class="fas fa-chalkboard-teacher"></i> Professor
                            </div>
                            <div class="tipo-btn" data-tipo="professorAEE">
                                <i class="fas fa-hands-helping"></i> Professor AEE
                            </div>
                        </div>

                        <!-- Formulário de cadastro -->
                        <form id="formCadastro" action="${pageContext.request.contextPath}/cadastro" method="POST">
                            <input type="hidden" id="tipo" name="tipo" value="aluno">

                            <!-- Campo de identificação dinâmico -->
                            <div class="form-group" id="identificacao-container">
                                <label for="identificacao" id="labelIdentificacao">
                                    <i class="fas fa-id-card"></i> Matrícula <span class="campo-obrigatorio">*</span>
                                </label>
                                <input type="text" id="identificacao" name="identificacao" placeholder="Digite sua matrícula" required>
                            </div>

                            <!-- Campos de senha -->
                            <div class="form-group" id="senha-container">
                                <label for="senha">
                                    <i class="fas fa-lock"></i> Senha <span class="campo-obrigatorio">*</span>
                                </label>
                                <input type="password" id="senha" name="senha" placeholder="Crie uma senha segura" required>
                            </div>

                            <div class="form-group" id="confirmarSenha-container">
                                <label for="confirmarSenha">
                                    <i class="fas fa-lock"></i> Confirmar Senha <span class="campo-obrigatorio">*</span>
                                </label>
                                <input type="password" id="confirmarSenha" name="confirmarSenha" placeholder="Confirme sua senha" required>
                            </div>

                            <button type="submit" class="botao-cadastrar">
                                <i class="fas fa-user-plus"></i> Criar Conta
                            </button>
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
                                        labelIdentificacao.innerHTML = '<i class="fas fa-id-card"></i> Matrícula <span class="campo-obrigatorio">*</span>';
                                        inputIdentificacao.placeholder = 'Digite sua matrícula';
                                        break;
                                    case 'professor':
                                    case 'professorAEE':
                                        labelIdentificacao.innerHTML = '<i class="fas fa-id-badge"></i> SIAPE <span class="campo-obrigatorio">*</span>';
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
                            const botao = document.querySelector('.botao-cadastrar');

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

                            // Feedback visual de carregamento
                            botao.classList.add('loading');
                            botao.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processando...';
                        });

                        // Feedback visual para campos ao digitar
                        const inputs = document.querySelectorAll('input');
                        inputs.forEach(input => {
                            input.addEventListener('input', function() {
                                if (this.value) {
                                    this.style.backgroundColor = '#f0f4ff';
                                } else {
                                    this.style.backgroundColor = '#f9f9ff';
                                }
                            });
                        });
                    </script>
                </body>
                </html>