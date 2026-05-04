package com.feather.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ReservationController")
public class ReservationController extends HttpServlet {
    // This line removes the warning seen in your screenshot
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // This path must match your folder structure exactly
        request.getRequestDispatcher("/WEB-INF/Pages/User/Reservation.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String date = request.getParameter("resDate");
        String guests = request.getParameter("guests");

        // Once you use the variables, the warning disappears!
        System.out.println("Processing reservation for " + date + " for " + guests + " guests.");

        // Example: Your database logic
        // ReservationDAO dao = new ReservationDAO();
        // boolean isSaved = dao.saveReservation(date, guests);

        // After successful save, redirect
        response.sendRedirect("Cart.jsp?status=success");
    }
}