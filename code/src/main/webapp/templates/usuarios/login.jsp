<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - AEE+</title>
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
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #4D44B5 0%, #6A62C9 100%);
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
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .login-container {
            background: linear-gradient(145deg, #ffffff, #f8f9ff);
            width: 100%;
            max-width: 480px;
            border-radius: 24px;
            padding: 45px;
            box-shadow:
                0 15px 50px rgba(77, 68, 181, 0.3),
                0 5px 20px rgba(0, 0, 0, 0.15);
            margin-top: 30px;
            border: 1px solid rgba(77, 68, 181, 0.1);
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
            animation: fadeIn 0.8s ease-out;
        }

        .login-container:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #4D44B5, #6A62C9);
            border-radius: 24px 24px 0 0;
        }

        .login-header {
            text-align: center;
            margin-bottom: 35px;
            position: relative;
            z-index: 2;
        }

        .login-header h2 {
            color: #2c3e50;
            font-size: 32px;
            margin-bottom: 12px;
            font-weight: 700;
            background: linear-gradient(90deg, #4D44B5, #6A62C9);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 4px rgba(77, 68, 181, 0.1);
        }

        .login-header p {
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
            background: #f8f9ff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: inset 0 2px 5px rgba(0,0,0,0.05);
            border: 1px solid #eef2f7;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
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
            padding: 16px 18px 16px 48px;
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

        .form-group:before {
            content: '';
            position: absolute;
            left: 18px;
            top: 40px;
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            color: #a0a4c0;
            font-size: 16px;
            z-index: 2;
        }

        #identificacao-container:before {
            content: '\f2c2';
        }

        #senha-container:before {
            content: '\f023';
        }

        .lembrar-senha {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 25px;
        }

        .checkbox-container {
            display: flex;
            align-items: center;
        }

        .checkbox-container input {
            margin-right: 8px;
            width: 18px;
            height: 18px;
            accent-color: #4D44B5;
            cursor: pointer;
        }

        .checkbox-container label {
            color: #5d6d7e;
            font-size: 14px;
            cursor: pointer;
        }

        .esqueci-senha {
            color: #4D44B5;
            text-decoration: none;
            font-size: 14px;
            transition: all 0.3s;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .esqueci-senha:hover {
            color: #372e9c;
            text-decoration: underline;
        }

        .esqueci-senha i {
            font-size: 12px;
        }

        .botao-login {
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
            margin-bottom: 20px;
            box-shadow:
                0 5px 15px rgba(77, 68, 181, 0.3),
                0 2px 5px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .botao-login:hover {
            background: linear-gradient(90deg, #3f37a0, #5a52b5);
            box-shadow:
                0 7px 20px rgba(77, 68, 181, 0.4),
                0 3px 8px rgba(0,0,0,0.15);
            transform: translateY(-2px);
        }

        .botao-login:active {
            transform: translateY(1px);
        }

        .cadastre-se {
            text-align: center;
            color: #6c757d;
            font-size: 16px;
        }

        .cadastre-se a {
            color: #4D44B5;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
            margin-left: 5px;
        }

        .cadastre-se a:hover {
            color: #372e9c;
            text-decoration: underline;
        }

        .rodape {
            position: fixed;
            bottom: 0;
            width: 100%;
            text-align: center;
            padding: 20px;
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
            text-shadow: 0 1px 2px rgba(0,0,0,0.2);
        }

        /* Animações */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-group {
            animation: fadeIn 0.4s ease-out;
            animation-fill-mode: both;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .lembrar-senha { animation-delay: 0.3s; }
        .botao-login { animation-delay: 0.4s; }
        .cadastre-se { animation-delay: 0.5s; }

        /* Responsividade */
        @media (max-width: 500px) {
            .login-container {
                margin: 20px;
                padding: 35px 25px;
                border-radius: 20px;
            }

            .cabecalho {
                padding: 15px 20px;
            }

            .logo h1 {
                font-size: 20px;
            }

            .login-header h2 {
                font-size: 28px;
            }

            .tipo-btn {
                padding: 14px 5px;
                font-size: 14px;
            }

            .form-group input {
                padding: 14px 14px 14px 40px;
            }

            .form-group:before {
                left: 14px;
                top: 38px;
            }
        }
    </style>
</head>
<body>
    <c:if test="${not empty mensagemErro}">
        <div class="mensagem-erro">
            ${mensagemErro}
        </div>
    </c:if>

    <!-- Cabeçalho com logo e nome do sistema -->
    <header class="cabecalho">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/static/images/logoAEE.png" alt="Logo AEE+">
            <h1>AEE+</h1>
        </div>
    </header>

    <!-- Container principal de login melhorado -->
    <div class="login-container">
        <div class="login-header">
            <h2>Bem-vindo ao AEE+</h2>
            <p>Selecione o tipo de acesso e faça seu login</p>
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

        <!-- Formulário de login -->
        <form id="formLogin" action="${pageContext.request.contextPath}/login" method="POST">
            <input type="hidden" id="tipo" name="tipo" value="aluno">

            <div class="form-group" id="identificacao-container">
                <label for="identificacao" id="labelIdentificacao">
                    <i class="fas fa-id-card"></i> Matrícula
                </label>
                <input type="text" id="identificacao" name="identificacao" placeholder="Digite sua matrícula" required>
            </div>

            <div class="form-group" id="senha-container">
                <label for="senha">
                    <i class="fas fa-lock"></i> Senha
                </label>
                <input type="password" id="senha" name="senha" placeholder="Digite sua senha" required>
            </div>

            <div class="lembrar-senha">
                <div class="checkbox-container">
                    <input type="checkbox" id="lembrar">
                    <label for="lembrar">Lembrar-me</label>
                </div>
                <a href="#" class="esqueci-senha">
                    <i class="fas fa-key"></i> Esqueci minha senha
                </a>
            </div>

            <button type="submit" class="botao-login">
                <i class="fas fa-sign-in-alt"></i> Entrar
            </button>
        </form>

        <div class="cadastre-se">
            Não tem uma conta? <a href="/templates/usuarios/cadastro.jsp">Cadastre-se</a>
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
                        labelIdentificacao.innerHTML = '<i class="fas fa-id-card"></i> Matrícula';
                        inputIdentificacao.placeholder = 'Digite sua matrícula';
                        break;
                    case 'professor':
                    case 'professorAEE':
                        labelIdentificacao.innerHTML = '<i class="fas fa-id-badge"></i> SIAPE';
                        inputIdentificacao.placeholder = 'Digite seu SIAPE';
                        break;
                }

                // Atualiza o campo tipo oculto
                document.getElementById('tipo').value = tipo;
            });
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

            // Adiciona efeito ao focar
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.01)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        // Efeito de loading no botão de login
        document.getElementById('formLogin').addEventListener('submit', function(e) {
            const botao = document.querySelector('.botao-login');
            botao.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Entrando...';
            botao.disabled = true;
        });
    </script>
</body>
</html>