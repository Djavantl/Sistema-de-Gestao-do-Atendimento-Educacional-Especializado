<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Deficiência</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .form-section {
            margin-bottom: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        h1 {
            color: #333;
        }
        label {
            display: block;
            margin-top: 10px;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            box-sizing: border-box;
        }
        button {
            margin-top: 15px;
            padding: 8px 15px;
            background: #0066cc;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Cadastro de Deficiência</h1>

        <form action="deficiencia" method="post">
            <div class="form-section">
                <label for="descricao">Descrição:</label>
                <input type="text" id="descricao" name="descricao" required>

                <label for="tipoDeficiencia">Tipo de Deficiência:</label>
                <input type="text" id="tipoDeficiencia" name="tipoDeficiencia" required>

                <label for="adaptacoes">Adaptações (separadas por vírgula):</label>
                <textarea id="adaptacoes" name="adaptacoes" rows="3"></textarea>
            </div>

            <button type="submit">Salvar</button>
        </form>
    </div>
</body>
</html>