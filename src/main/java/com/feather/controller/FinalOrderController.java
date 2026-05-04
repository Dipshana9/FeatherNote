package com.feather.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/FinalOrderController")
public class FinalOrderController extends HttpServlet {
    private static final long serialVersionUID = 1L; 

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Capture Form Data
        String name = request.getParameter("custName");
        String phone = request.getParameter("custPhone");
        String address = request.getParameter("custAddress"); 
        String payment = request.getParameter("payMethod");
        String total = request.getParameter("totalAmount");
        
        // IMPORTANT: Capture the array of selected items from the menu
        String[] selectedItems = request.getParameterValues("itemNames");

        // 2. Data Validation
        if (name == null || name.isEmpty() || phone == null || phone.isEmpty()) {
            response.sendRedirect("UserMenuController"); 
            return;
        }

        // 3. Set Attributes for the Success Page
        // Passing these variables "uses" them, which removes the warning in image_b82614.png
        request.setAttribute("customerName", name);
        request.setAttribute("customerAddress", address);
        request.setAttribute("finalBill", total); 
        request.setAttribute("selectedDishes", selectedItems);
        request.setAttribute("PaymentMethod", payment);
        
        // Use the correct path based on your folder structure
        request.getRequestDispatcher("/WEB-INF/Pages/User/Success.jsp").forward(request, response);
        
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("UserMenuController");
    }
}