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

        .login-container {
            background-color: white;
            width: 100%;
            max-width: 450px;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            margin-top: 30px;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h2 {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .login-header p {
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
        }

        .esqueci-senha {
            color: #4D44B5;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .esqueci-senha:hover {
            color: #372e9c;
            text-decoration: underline;
        }

        .botao-login {
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
            margin-bottom: 20px;
        }

        .botao-login:hover {
            background-color: #372e9c;
        }

        .cadastre-se {
            text-align: center;
            color: #7f8c8d;
            font-size: 15px;
        }

        .cadastre-se a {
            color: #4D44B5;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
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
        }

        @media (max-width: 500px) {
            .login-container {
                margin: 20px;
                padding: 30px;
            }

            .cabecalho {
                padding: 15px 20px;
            }

            .logo h1 {
                font-size: 20px;
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
            <img src="${pageContext.request.contextPath}/static/images/logo.svg" alt="Logo Inclui+">
            <h1>AEE+</h1>
        </div>
    </header>

    <!-- Container principal de login -->
    <div class="login-container">
        <div class="login-header">
            <h2>Bem-vindo ao AEE+</h2>
            <p>Selecione o tipo de acesso e faça seu login</p>
        </div>

        <!-- Seletor de tipo de usuário -->
        <div class="tipo-usuario">
            <div class="tipo-btn ativo" data-tipo="aluno">Aluno</div>
            <div class="tipo-btn" data-tipo="professor">Professor</div>
            <div class="tipo-btn" data-tipo="professorAEE">Professor AEE</div>
        </div>

        <!-- Formulário de login -->
        <form id="formLogin" action="${pageContext.request.contextPath}/login" method="POST">
            <input type="hidden" id="tipo" name="tipo" value="aluno">
            <div class="form-group">
                <label for="identificacao" id="labelIdentificacao" >Matrícula</label>
                <input type="text" id="identificacao" name="identificacao" placeholder="Digite sua matrícula" required>
            </div>

            <div class="form-group">
                <label for="senha">Senha</label>
                <input type="password" id="senha" name="senha"placeholder="Digite sua senha" required>
            </div>

            <div class="lembrar-senha">
                <div class="checkbox-container">
                    <input type="checkbox" id="lembrar">
                    <label for="lembrar">Lembrar-me</label>
                </div>
                <a href="#" class="esqueci-senha">Esqueci minha senha</a>
            </div>

            <button type="submit" class="botao-login">Entrar</button>
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
        </script>
</body>
</html>