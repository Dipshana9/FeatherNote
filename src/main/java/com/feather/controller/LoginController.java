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

    // ✅ SHOW LOGIN PAGE
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/Pages/Login.jsp")
               .forward(request, response);
    }

    // ✅ HANDLE LOGIN
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // ✅ DB CONNECTION
            dbConfig db = new dbConfig();
            Connection con = db.getConnection();

            // ✅ CHECK EMAIL & PASSWORD
            String sql = "SELECT * FROM user WHERE Email = ? AND Password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ LOGIN SUCCESS
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", rs.getString("Email"));
                session.setAttribute("userName", rs.getString("UserName"));

                con.close();
                response.sendRedirect(
                        request.getContextPath() + "/DashboardController"
                );

            } else {
                // ❌ LOGIN FAILED
                request.setAttribute("error", "Invalid email or password");
                con.close();
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error");
            doGet(request, response);
        }
    }
}
