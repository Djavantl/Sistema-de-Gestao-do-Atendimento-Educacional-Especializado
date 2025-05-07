<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Pessoa</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f8ff;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #007acc;
            text-align: center;
            margin-top: 30px;
        }

        .form-container {
            width: 50%;
            margin: 30px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .form-container input[type="text"],
        .form-container input[type="date"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .form-container input[type="submit"] {
            background-color: #007acc;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            box-sizing: border-box;
        }

        .form-container input[type="submit"]:hover {
            background-color: #005f99;
        }

        .form-container label {
            font-size: 16px;
            color: #333;
        }

        .form-container .form-footer {
            text-align: center;
            margin-top: 20px;
        }

        .form-container .form-footer a {
            color: #007acc;
            text-decoration: none;
            font-size: 14px;
        }

        .form-container .form-footer a:hover {
            color: #005f99;
        }
    </style>
</head>
<body>
    <h2>Cadastrar Nova Pessoa</h2>

    <div class="form-container">
        <form action="pessoas" method="post">
            <label for="nome">Nome</label>
            <input type="text" id="nome" name="nome" required>

            <label for="dataNascimento">Data de Nascimento</label>
            <input type="date" id="dataNascimento" name="dataNascimento" required>

            <label for="email">Email</label>
            <input type="text" id="email" name="email" required>

            <label for="sexo">Sexo</label>
            <input type="text" id="sexo" name="sexo" required>

            <label for="naturalidade">Naturalidade</label>
            <input type="text" id="naturalidade" name="naturalidade" required>

            <label for="telefone">Telefone</label>
            <input type="text" id="telefone" name="telefone" required>

            <input type="submit" value="Salvar">
        </form>

        <div class="form-footer">
            <a href="pessoas.html">Voltar para a lista de pessoas</a>
        </div>
    </div>
</body>
</html>
