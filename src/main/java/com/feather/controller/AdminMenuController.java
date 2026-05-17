package com.feather.controller;

import com.feather.config.dbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminMenuController")
public class AdminMenuController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private dbConfig db = new dbConfig();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteMenuItem(request.getParameter("id"));
        }

        List<Map<String, Object>> menuList = new ArrayList<>();
        try (Connection conn = db.getConnection()) {
            // Updated to fetch all columns from your schema
            String sql = "SELECT * FROM menu ORDER BY category, item_name";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", rs.getInt("id"));
                item.put("name", rs.getString("item_name"));
                item.put("description", rs.getString("description"));
                item.put("category", rs.getString("category"));
                item.put("price", rs.getDouble("price"));
                item.put("discount", rs.getDouble("discount"));
                menuList.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("menuList", menuList);
        request.getRequestDispatcher("/WEB-INF/Pages/Admin/menu-management.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("formAction");
        
        if ("add".equals(action)) {
            addMenuItem(request);
        } else if ("update".equals(action)) {
            updateMenuItem(request);
        }
        
        response.sendRedirect("AdminMenuController");
    }

    private void addMenuItem(HttpServletRequest request) {
        try (Connection conn = db.getConnection()) {
            // SQL includes description and image_url to match your DB screenshot
            String sql = "INSERT INTO menu (item_name, description, price, category, image_url, discount) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement st = conn.prepareStatement(sql);
            
            st.setString(1, request.getParameter("name"));
            st.setString(2, request.getParameter("description"));
            st.setDouble(3, Double.parseDouble(request.getParameter("price")));
            st.setString(4, request.getParameter("category"));
            st.setString(5, "default.jpg"); // Placeholder
            st.setDouble(6, Double.parseDouble(request.getParameter("discount")));
            
            st.executeUpdate();
        } catch (Exception e) { 
            System.err.println("Insert Failed: " + e.getMessage());
            e.printStackTrace(); 
        }
    }

    private void updateMenuItem(HttpServletRequest request) {
        try (Connection conn = db.getConnection()) {
            String sql = "UPDATE menu SET price = ?, discount = ? WHERE id = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setDouble(1, Double.parseDouble(request.getParameter("price")));
            st.setDouble(2, Double.parseDouble(request.getParameter("discount")));
            st.setInt(3, Integer.parseInt(request.getParameter("id")));
            st.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    private void deleteMenuItem(String id) {
        try (Connection conn = db.getConnection()) {
            String sql = "DELETE FROM menu WHERE id = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, Integer.parseInt(id));
            st.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}