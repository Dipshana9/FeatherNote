package com.feather.controller;

import com.feather.config.dbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminDashboardController")
public class AdminDashboardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private dbConfig db = new dbConfig();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Map<String, Object> stats = new HashMap<>();

        try (Connection conn = db.getConnection()) {
            // 1. Total Orders Today
            String sqlOrders = "SELECT COUNT(*) FROM orders WHERE DATE(created_at) = CURDATE()";
            PreparedStatement ps1 = conn.prepareStatement(sqlOrders);
            ResultSet rs1 = ps1.executeQuery();
            if (rs1.next()) stats.put("dailyOrders", rs1.getInt(1));

            // 2. Total Revenue (Profit) Today from Bills
            String sqlRevenue = "SELECT SUM(total_amount) FROM bills WHERE DATE(created_at) = CURDATE()";
            PreparedStatement ps2 = conn.prepareStatement(sqlRevenue);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) stats.put("dailyProfit", rs2.getDouble(1));

            // 3. Most Sold Dish (Top Seller)
            String sqlTopDish = "SELECT m.name, SUM(oi.quantity) as total_sold " +
                                "FROM orderitems oi JOIN menu m ON oi.menu_id = m.id " +
                                "GROUP BY m.id ORDER BY total_sold DESC LIMIT 1";
            PreparedStatement ps3 = conn.prepareStatement(sqlTopDish);
            ResultSet rs3 = ps3.executeQuery();
            if (rs3.next()) {
                stats.put("topDish", rs3.getString("name"));
                stats.put("topDishCount", rs3.getInt("total_sold"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("stats", stats);
        request.getRequestDispatcher("/WEB-INF/Pages/Admin/admin-dashboard.jsp").forward(request, response);
    }
}