
package com.feather.controller;

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.feather.model.menu;
import com.feather.config.dbConfig;
import java.util.*;


/**
 * Servlet implementation class LoginController
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/menuController" })
public class menuController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public menuController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<menu> menuList = new ArrayList<>();
        
        // Use try-with-resources to ensure connection closes even if an error occurs
        try {
            dbConfig db = new dbConfig();
            Connection con = db.getConnection();
            String sql = "SELECT * FROM menu ORDER BY category DESC";
           // String sql = "SELECT * FROM menu";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Ensure field names match your database columns exactly
                menuList.add(new menu(
                    rs.getInt("id"),
                    rs.getString("item_name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("image_url")
                ));
            }
            con.close(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        request.setAttribute("menuItems", menuList);
        request.getRequestDispatcher("/WEB-INF/Pages/Admin/menu.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
