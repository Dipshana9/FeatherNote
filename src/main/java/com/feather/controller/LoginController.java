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

    /**
     * SHOW LOGIN PAGE
     * Serves the Login.jsp file located in protected WEB-INF folder.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp").forward(request, response);
    }

    /**
     * PROCESS LOGIN DATA
     * Handles authentication and role-based routing.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Establish Database Connection
            dbConfig db = new dbConfig();
            Connection con = db.getConnection();

            // SQL to check credentials
            String sql = "SELECT * FROM user WHERE Email = ? AND Password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // LOGIN SUCCESS: Create Session
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", rs.getString("Email"));
                session.setAttribute("userName", rs.getString("UserName"));

                con.close();

                // --- ROLE-BASED REDIRECTION ---
                // Specifically check for your admin email
                if ("featheradmin@gmail.com".equalsIgnoreCase(email)) {
                    // Set admin role for security checks on other pages
                    session.setAttribute("userRole", "admin");
                    
                    // Redirect to Admin Dashboard Controller
                    response.sendRedirect(request.getContextPath() + "/AdminDashboardController");
                } else {
                    // Standard user role
                    session.setAttribute("userRole", "user");
                    
                    // Redirect to User Dashboard Controller
                    response.sendRedirect(request.getContextPath() + "/HomeController");
                }

            } else {
                // LOGIN FAILED: Return to login with error
                request.setAttribute("error", "Invalid email or password");
                if (con != null) con.close();
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            doGet(request, response);
        }
    }
}