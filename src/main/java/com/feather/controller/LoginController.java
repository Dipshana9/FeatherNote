package com.feather.controller;

import com.feather.config.dbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            dbConfig db = new dbConfig();
            Connection con = db.getConnection();

            // 1. First, check if the email exists in the 'users' table
            String emailCheckSql = "SELECT * FROM users WHERE email = ?";
            PreparedStatement ps = con.prepareStatement(emailCheckSql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Email exists, now check if the password matches
                String dbPassword = rs.getString("password");
                
                if (dbPassword.equals(password)) {
                    // SUCCESS: Login verified
                    HttpSession session = request.getSession();
                    session.setAttribute("userEmail", rs.getString("email"));
                    session.setAttribute("userName", rs.getString("name"));
                    session.setAttribute("userRole", rs.getString("role"));

                    con.close();

                    // 2. Routing Logic
                    // Check if email contains "FAdmin" (Case insensitive)
                    if (email.toLowerCase().contains("fadmin")) {
                        response.sendRedirect(request.getContextPath() + "/AdminDashboardController");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/HomeController");
                    }

                } else {
                    // Password does not match
                    request.setAttribute("error", "Wrong password! Please try again.");
                    request.setAttribute("showForgot", true); // Trigger forgot password link
                    doGet(request, response);
                }
            } else {
                // Email does not exist
                request.setAttribute("error", "This email is not registered. Please register instead.");
                request.setAttribute("showRegister", true); // Highlight register link
                doGet(request, response);
            }

            if (con != null) con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            doGet(request, response);
        }
    }
}