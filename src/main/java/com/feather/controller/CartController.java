package com.feather.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

// Swapping javax to jakarta to match modern Tomcat versions
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.feather.dao.MenuDAO;
import com.feather.model.CartItem;
import com.feather.model.Menu;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        int qty = Integer.parseInt(request.getParameter("qty"));

        MenuDAO dao = new MenuDAO();
        Menu menu = null;

        for (Menu m : dao.getAllMenuItems()) {
            if (m.getId() == id) {
                menu = m;
                break;
            }
        }

        if (menu != null) {
            HttpSession session = request.getSession();
            
            @SuppressWarnings("unchecked")
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
            }

            CartItem item = new CartItem();
            item.setMenuId(menu.getId());
            item.setName(menu.getName());
            item.setPrice(menu.getPrice());
            item.setQuantity(qty);

            cart.add(item);
            session.setAttribute("cart", cart);
        }

        response.sendRedirect("Cart.jsp");
    }
}