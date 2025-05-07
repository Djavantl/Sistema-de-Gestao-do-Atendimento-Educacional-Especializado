<%@ taglib uri="http://xmlns.jcp.org/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Pessoas</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #007acc;
            text-align: center;
            margin-top: 20px;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007acc;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e6f2ff;
        }

        a {
            color: #007acc;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #005f99;
        }

        .actions {
            text-align: center;
        }

        .add-person {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #007acc;
            color: white;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            border-radius: 5px;
        }

        .add-person:hover {
            background-color: #005f99;
        }
    </style>
</head>
<body>
    <h2>Lista de Pessoas</h2>

    <table>
        <tr>
            <th>Nome</th>
            <th>Data de Nascimento</th>
            <th>Email</th>
            <th>Sexo</th>
            <th>Naturalidade</th>
            <th>Telefone</th>
            <th>Ações</th>
        </tr>
        <!-- Exibe as pessoas a partir da lista obtida da Servlet -->
        <c:forEach var="pessoa" items="${pessoas}">
            <tr>
                <td>${pessoa.nome}</td>
                <td>${pessoa.dataNascimento}</td>
                <td>${pessoa.email}</td>
                <td>${pessoa.sexo}</td>
                <td>${pessoa.naturalidade}</td>
                <td>${pessoa.telefone}</td>
                <td class="actions">
                    <a href="pessoas?acao=excluir&id=${pessoa.id}">Excluir</a>
                </td>
            </tr>
        </c:forEach>
    </table>

    <a href="pessoas-form.html" class="add-person">Cadastrar nova Pessoa</a>
</body>
</html>
