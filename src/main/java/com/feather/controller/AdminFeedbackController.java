package com.feather.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/AdminFeedbackController")
public class AdminFeedbackController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String dbUrl = "jdbc:mysql://localhost:3306/feather";
    private final String dbUser = "root";
    private final String dbPassword = ""; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, String>> feedbackList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            
            // Get all feedback
            String sql = "SELECT * FROM feedback ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> fb = new HashMap<>();
                fb.put("id", rs.getString("id"));
                fb.put("user_email", rs.getString("user_email"));
                fb.put("comment", rs.getString("comment"));
                fb.put("reply", rs.getString("admin_reply"));
                feedbackList.add(fb);
            }
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }

        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("/WEB-INF/Pages/Admin/feedback-management.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String feedbackId = request.getParameter("feedbackId");
        String replyText = request.getParameter("replyText");

        try {
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            String sql = "UPDATE feedback SET admin_reply = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, replyText);
            ps.setString(2, feedbackId);
            ps.executeUpdate();
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }

        response.sendRedirect(request.getContextPath() + "/AdminFeedbackController");
    }
}