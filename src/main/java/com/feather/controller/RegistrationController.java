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

        request.getRequestDispatcher("/WEB-INF/Pages/Registration.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // ✅ 1. Validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            doGet(request, response);
            return;
        }

        try {
            // ✅ 2. CREATE DbConfig OBJECT HERE
            dbConfig db = new dbConfig();
            Connection con = db.getConnection();

            // ✅ 3. Check if email already exists
            String checkSql = "SELECT Email FROM user WHERE Email = ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                request.setAttribute("error", "Email already registered");
                doGet(request, response);
                con.close();
                return;
            }

            // ✅ 4. Insert new user
            String insertSql =
                "INSERT INTO user (UserName, Email, Password) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertSql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password); // hash later

            ps.executeUpdate();

            con.close();

            // ✅ 5. Success message
            request.getSession().setAttribute(
                "success",
                "Registration successful. Please login."
            );

            response.sendRedirect(request.getContextPath() + "/LoginController");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error");
            doGet(request, response);
        }
    }
}