package com.feather.controller;

import com.feather.config.dbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/FeedbackController")
public class FeedbackController extends HttpServlet {
    private static final long serialVersionUID = 1L; 
    private dbConfig db = new dbConfig();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("userEmail");

        // 1. Handle Delete Logic (Only if it's the user's own post)
        if ("deleteOwn".equals(action) && userEmail != null) {
            String id = request.getParameter("id");
            try (Connection conn = db.getConnection()) {
                String sql = "DELETE FROM feedback WHERE id = ? AND email = ?";
                PreparedStatement st = conn.prepareStatement(sql);
                st.setInt(1, Integer.parseInt(id));
                st.setString(2, userEmail);
                st.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("FeedbackController");
            return;
        }

        // 2. Fetch All Feedback for Display
        List<Map<String, Object>> feedbackList = new ArrayList<>();
        try (Connection conn = db.getConnection()) {
            String sql = "SELECT * FROM feedback ORDER BY created_at DESC";
            ResultSet rs = conn.prepareStatement(sql).executeQuery();
            while (rs.next()) {
                Map<String, Object> f = new HashMap<>();
                f.put("id", rs.getInt("id"));
                f.put("name", rs.getString("name"));
                f.put("email", rs.getString("email"));
                f.put("message", rs.getString("message"));
                f.put("reply_message", rs.getString("reply_message"));
                f.put("created_at", rs.getTimestamp("created_at"));
                feedbackList.add(f);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("feedbackList", feedbackList);
        request.getRequestDispatcher("/WEB-INF/Pages/User/feedback.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("userName");
        String email = (String) session.getAttribute("userEmail");
        String message = request.getParameter("message");

        // Use 'Guest' if the user isn't logged in
        if (name == null) name = "Guest";
        if (email == null) email = "anonymous@feathernote.com";

        try (Connection conn = db.getConnection()) {
            String sql = "INSERT INTO feedback (name, email, message) VALUES (?, ?, ?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, email);
            st.setString(3, message);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("FeedbackController");
    }
}