package cadastroee.servlets;

import cadastroee.controller.ProdutoFacadeLocal;
import cadastroee.model.Produto;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ServletProdutoFC extends HttpServlet {

    @EJB
    ProdutoFacadeLocal facade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String acao = request.getParameter("acao");
        String destino;

        if ("formIncluir".equals(acao) || "formAlterar".equals(acao)) {
            destino = "ProdutoDados.jsp";
        } else {
            destino = "ProdutoLista.jsp";
        }

        if ("listar".equals(acao)) {
            List<Produto> lista = facade.findAll();
            request.setAttribute("lista", lista);

        } else if ("formAlterar".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Produto produto = facade.find(id);
            request.setAttribute("produto", produto);

        } else if ("excluir".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Produto produto = facade.find(id);
            facade.remove(produto);
            List<Produto> lista = facade.findAll();
            request.setAttribute("lista", lista);

        } else if ("alterar".equals(acao)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Produto produto = facade.find(id);
            produto.setNome(request.getParameter("nome"));
            produto.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
            produto.setPrecoVenda(Float.parseFloat(request.getParameter("precoVenda")));
            facade.edit(produto);
            List<Produto> lista = facade.findAll();
            request.setAttribute("lista", lista);

        } else if ("incluir".equals(acao)) {
            Produto produto = new Produto();
            produto.setNome(request.getParameter("nome"));
            produto.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
            produto.setPrecoVenda(Float.parseFloat(request.getParameter("precoVenda")));
            facade.create(produto);
            List<Produto> lista = facade.findAll();
            request.setAttribute("lista", lista);
        }

        RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Front Controller de Produto";
    }
}
