package com.feather.controller;

import com.feather.config.dbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/RegistrationController")
public class RegistrationController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/Registration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1. Check if passwords match
        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            doGet(request, response);
            return;
        }

        try {
            dbConfig db = new dbConfig();
            Connection con = db.getConnection();

            // 2. DUPLICATE CHECK: Look for existing email
            String checkSql = "SELECT email FROM users WHERE email = ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // If this runs, it means the email was found in the 'users' table
                request.setAttribute("error", "An account with this email already exists!");
                doGet(request, response);
                con.close();
                return;
            }

            // 3. INSERTION: If code reaches here, the email is unique
            // Using your table structure: name, email, password, role
            String insertSql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, 'USER')";
            PreparedStatement ps = con.prepareStatement(insertSql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password); 

            ps.executeUpdate();
            con.close();

            // 4. Redirect to login on success
            request.getSession().setAttribute("success", "Account created! You can now login.");
            response.sendRedirect(request.getContextPath() + "/LoginController");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            doGet(request, response);
        }
    }
}