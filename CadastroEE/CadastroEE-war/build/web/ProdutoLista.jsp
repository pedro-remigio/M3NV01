<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cadastroee.model.Produto"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lista de Produtos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body class="container">
        <h2 class="mt-4 mb-3">Lista de Produtos</h2>
        <a href="ServletProdutoFC?acao=formIncluir" class="btn btn-primary m-2">Novo Produto</a>
        <table class="table table-striped mt-3">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Quantidade</th>
                    <th>Preço de Venda</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Produto> lista = (List<Produto>) request.getAttribute("lista");
                    if (lista != null) {
                        for (Produto p : lista) {
                %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getNome() %></td>
                    <td><%= p.getQuantidade() %></td>
                    <td>R$ <%= String.format("%.2f", p.getPrecoVenda()) %></td>
                    <td>
                        <a href="ServletProdutoFC?acao=formAlterar&id=<%= p.getId() %>" class="btn btn-primary btn-sm">Alterar</a>
                        <a href="ServletProdutoFC?acao=excluir&id=<%= p.getId() %>" class="btn btn-danger btn-sm">Excluir</a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </body>
</html>
