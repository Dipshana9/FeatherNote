package com.feather.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ReservationController")
public class ReservationController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database configurations (Update these with your own DB credentials)
    private final String dbUrl = "jdbc:mysql://localhost:3306/feather_db";
    private final String dbUser = "root";
    private final String dbPassword = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // FIX: If user is not logged in, redirect them safely via the LoginController URL
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
            return;
        }

        // If logged in, show the reservation form
        request.getRequestDispatcher("/WEB-INF/Pages/User/Reservation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/LoginController");
            return;
        }

        String email = (String) session.getAttribute("userEmail");
        int tableNumber = Integer.parseInt(request.getParameter("tableNumber"));
        String resDate = request.getParameter("resDate");
        String resTime = request.getParameter("resTime");
        int partySize = Integer.parseInt(request.getParameter("partySize"));

        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // 1. CRITICAL CHECK: Does this table booking already exist?
            String checkSQL = "SELECT COUNT(*) FROM reservations WHERE table_number = ? AND res_date = ? AND res_time = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSQL);
            checkStmt.setInt(1, tableNumber);
            checkStmt.setString(2, resDate);
            checkStmt.setString(3, resTime);
            
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                // Double booking prevented
                request.setAttribute("errorMessage", "Table " + tableNumber + " is already booked for " + resTime + " on " + resDate + ". Please choose another table or time!");
                request.getRequestDispatcher("/WEB-INF/Pages/User/Reservation.jsp").forward(request, response);
                return;
            }

            // 2. Insert the booking if slot is free
            String insertSQL = "INSERT INTO reservations (user_email, table_number, res_date, res_time, party_size) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertSQL);
            insertStmt.setString(1, email);
            insertStmt.setInt(2, tableNumber);
            insertStmt.setString(3, resDate);
            insertStmt.setString(4, resTime);
            insertStmt.setInt(5, partySize);

            int rowsAffected = insertStmt.executeUpdate();
            if (rowsAffected > 0) {
                request.setAttribute("successMessage", "Success! Table " + tableNumber + " has been reserved for you.");
            } else {
                request.setAttribute("errorMessage", "Something went wrong. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database Error: " + e.getMessage());
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }

        request.getRequestDispatcher("/WEB-INF/Pages/User/Reservation.jsp").forward(request, response);
    }
}