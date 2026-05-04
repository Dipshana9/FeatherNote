package com.feather.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserMenuController")
public class UserMenuController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Forwarding to the menu page
        request.getRequestDispatcher("/WEB-INF/Pages/User/Menu.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Retrieve arrays from the menu form
        String[] itemNames = request.getParameterValues("itemNames");
        String[] quantities = request.getParameterValues("itemQuantities");
        String[] prices = request.getParameterValues("itemPrices");
        String totalAmount = request.getParameter("totalAmount");
        String serviceType = request.getParameter("serviceType");

        // 2. Pass them to the OrderSummary.jsp
        request.setAttribute("items", itemNames);
        request.setAttribute("qty", quantities);
        request.setAttribute("price", prices);
        request.setAttribute("total", totalAmount);
        request.setAttribute("service", serviceType);

        // 3. Forward to the correct folder
        request.getRequestDispatcher("/WEB-INF/Pages/User/OrderSummary.jsp").forward(request, response);
    }
  
  
    }
    
    
