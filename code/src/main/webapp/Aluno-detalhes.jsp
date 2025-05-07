<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalhes do Aluno</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { color: #2c3e50; }
        p { margin: 8px 0; }
        .btn { padding: 10px 15px; background: #3498db; color: white; border: none; border-radius: 4px; text-decoration: none; }
        .btn:hover { background: #2980b9; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Detalhes do Aluno</h1>

        <c:if test="${aluno != null}">
            <p><strong>Nome:</strong> ${aluno.nome}</p>
            <p><strong>Data de Nascimento:</strong> ${aluno.dataNascimento}</p>
            <p><strong>Email:</strong> ${aluno.email}</p>
            <p><strong>Sexo:</strong> ${aluno.sexo}</p>
            <p><strong>Naturalidade:</strong> ${aluno.naturalidade}</p>
            <p><strong>Telefone:</strong> ${aluno.telefone}</p>
            <p><strong>Matrícula:</strong> ${aluno.matricula}</p>
            <p><strong>Responsável:</strong> ${aluno.responsavel}</p>
            <p><strong>Telefone do Responsável:</strong> ${aluno.telResponsavel}</p>
            <p><strong>Telefone do Trabalho:</strong> ${aluno.telTrabalho}</p>
            <p><strong>Curso:</strong> ${aluno.curso}</p>
            <p><strong>Turma:</strong> ${aluno.turma}</p>
        </c:if>

        <c:if test="${aluno == null}">
            <p>Aluno não encontrado.</p>
        </c:if>

        <a href="aluno?acao=listar" class="btn">Voltar à Lista de Alunos</a>
    </div>
</body>
</html>