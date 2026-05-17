package com.feather.controller;

import com.feather.config.dbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminUserController")
public class AdminUserController extends HttpServlet {
    // Standard version ID to remove that yellow warning in Eclipse/VS Code
    private static final long serialVersionUID = 1L; 
    private dbConfig db = new dbConfig();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        // Handle Soft Delete
        if ("delete".equals(action)) {
            String userId = request.getParameter("id");
            if (userId != null && !userId.isEmpty()) {
                softDeleteUser(userId);
            }
        }

        // Fetch all users from the 'feather' database
        List<Map<String, Object>> usersList = new ArrayList<>();
        try (Connection conn = db.getConnection()) {
            // ORDER BY created_at DESC puts the newest users at the top
            String sql = "SELECT id, name, email, role, created_at, is_deleted, deleted_at FROM users ORDER BY created_at DESC";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Map<String, Object> user = new HashMap<>();
                user.put("id", rs.getInt("id"));
                user.put("name", rs.getString("name"));
                user.put("email", rs.getString("email"));
                user.put("role", rs.getString("role"));
                user.put("created_at", rs.getTimestamp("created_at"));
                user.put("is_deleted", rs.getInt("is_deleted"));
                user.put("deleted_at", rs.getTimestamp("deleted_at"));
                usersList.add(user);
            }
        } catch (SQLException e) {
            // This will show errors in your Console if the DB connection fails
            System.err.println("Database Error: " + e.getMessage());
            e.printStackTrace();
        }

        // Send the list to your user-management.jsp
        request.setAttribute("usersList", usersList);
        request.getRequestDispatcher("/WEB-INF/Pages/Admin/user-management.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Collect data from your 'Add New User' form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try (Connection conn = db.getConnection()) {
            // SQL Insert into 'feather' DB
            String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, email);
            st.setString(3, password); 
            st.setString(4, role);
            st.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Save Error: " + e.getMessage());
            e.printStackTrace();
        }
        
        // Reload the page to show the new user in the table
        response.sendRedirect("AdminUserController");
    }

    private void softDeleteUser(String id) {
        try (Connection conn = db.getConnection()) {
            // This deactivates the user instead of deleting the row
            String sql = "UPDATE users SET is_deleted = 1, deleted_at = NOW() WHERE id = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(id));
            st.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Delete Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}