package com.feather.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/HomeController")
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get existing session without creating a new one
        HttpSession session = request.getSession(false);
        
        // 2. Role-Based Auto-Redirect
        if (session != null && session.getAttribute("userEmail") != null) {
            String email = (String) session.getAttribute("userEmail");
            
            // STRICT check for admin email
            if ("featheradmin@gmail.com".equalsIgnoreCase(email)) {
                response.sendRedirect(request.getContextPath() + "/AdminDashboardController");
                return; // Critical: Stop execution so it doesn't load Home.jsp
            } 
            // Optional: Redirect logged-in users to their dashboard
            /*
            else {
                response.sendRedirect(request.getContextPath() + "/DashboardController");
                return;
            }
            */
        }

        // 3. Show the Landing Page for Guests and Regular Users
        request.getRequestDispatcher("/WEB-INF/Pages/User/Home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}