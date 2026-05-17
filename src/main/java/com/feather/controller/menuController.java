package com.feather.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MenuController")
public class MenuController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * GET request: Displays the menu page from WEB-INF
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Matches your folder: WEB-INF > Pages > User > Menu.jsp
        request.getRequestDispatcher("/WEB-INF/Pages/User/Menu.jsp").forward(request, response);
    }

    /**
     * POST request: Processes the order and delivery details
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Capture the total price from the hidden field
        String totalAmount = request.getParameter("totalAmount");

        // 2. Capture Delivery details from the form/modal
        String isDelivery = request.getParameter("isDelivery"); 
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // 3. Debugging output to console
        System.out.println("--- New Order Received ---");
        System.out.println("Total Amount: $" + totalAmount);
        
        if (address != null && !address.isEmpty()) {
            System.out.println("Order Type: Home Delivery");
            System.out.println("Address: " + address);
            System.out.println("Phone: " + phone);
        } else {
            System.out.println("Order Type: Dine-in / Pickup");
        }

        // 4. Send success status back to trigger the alert message
        request.setAttribute("status", "success");
        
        // Forward back to user-menu.jsp inside the User folder
        request.getRequestDispatcher("/WEB-INF/Pages/User/user-menu.jsp").forward(request, response);
    }
}