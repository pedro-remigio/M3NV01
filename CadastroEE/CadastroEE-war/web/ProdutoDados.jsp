<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cadastroee.model.Produto"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cadastro de Produto</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body class="container">
        <%
            Produto produto = (Produto) request.getAttribute("produto");
            String acao = (produto == null) ? "incluir" : "alterar";
            String titulo = (produto == null) ? "Incluir Produto" : "Alterar Produto";
            String btnTexto = (produto == null) ? "Incluir" : "Salvar Alterações";
        %>
        <h2 class="mt-4 mb-3"><%= titulo %></h2>
        <form action="ServletProdutoFC" method="post" class="form">
            <input type="hidden" name="acao" value="<%= acao %>">
            <% if ("alterar".equals(acao)) { %>
            <input type="hidden" name="id" value="<%= produto.getId() %>">
            <% } %>
            <div class="mb-3">
                <label class="form-label">Nome:</label>
                <input type="text" name="nome" class="form-control"
                       value="<%= (produto != null) ? produto.getNome() : "" %>">
            </div>
            <div class="mb-3">
                <label class="form-label">Quantidade:</label>
                <input type="number" name="quantidade" class="form-control"
                       value="<%= (produto != null) ? produto.getQuantidade() : "" %>">
            </div>
            <div class="mb-3">
                <label class="form-label">Preço de Venda:</label>
                <input type="text" name="precoVenda" class="form-control"
                       value="<%= (produto != null) ? String.format("%.2f", produto.getPrecoVenda()) : "" %>">
            </div>
            <button type="submit" class="btn btn-primary"><%= btnTexto %></button>
            <a href="ServletProdutoFC?acao=listar" class="btn btn-secondary ms-2">Cancelar</a>
        </form>
    </body>
</html>
