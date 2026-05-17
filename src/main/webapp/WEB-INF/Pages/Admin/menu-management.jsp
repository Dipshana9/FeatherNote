<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>FeatherNote | Menu Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin/AdminUserController.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body class="admin-body">

    <header class="nav-header">
        <div class="nav-container">
            <div class="nav-logo">FeatherNote <span class="admin-label">Admin</span></div>
            <nav class="nav-menu">
                <ul class="nav-list">
                    <li><a href="AdminDashboardController"><i class="fa-solid fa-chart-line"></i> Dashboard</a></li>
                    <li><a href="AdminUserController"><i class="fa-solid fa-users"></i> Users</a></li>
                    <li><a href="AdminMenuController" class="active"><i class="fa-solid fa-utensils"></i> Menu</a></li>
                    
                    <li><a href="AdminFeedbackController"><i class="fa-solid fa-comments"></i> Feedback</a></li>
                </ul>
            </nav>
            <div class="nav-auth">
                <% if (session.getAttribute("userEmail") != null) { %>
                    <span class="user-welcome">Hello, Admin</span>
                    <a href="LogoutController" class="logout-btn-styled">Logout</a>
                <% } %>
            </div>
        </div>
    </header>

    <main class="admin-container">
        <section class="form-section">
            <h2><i class="fa-solid fa-plus-circle"></i> Add New Dish</h2>
            <form action="AdminMenuController" method="POST" class="admin-form">
                <input type="hidden" name="formAction" value="add">
                <div class="form-group">
                    <label>Dish Name</label>
                    <input type="text" name="name" required placeholder="e.g. Garlic Naan">
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <input type="text" name="description" required placeholder="Brief description">
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category">
                        <option value="Main">Main Course</option>
                        <option value="Starters">Starters</option>
                        <option value="Beverage">Beverage</option>
                        <option value="Soup">Soup</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Price (Rs.)</label>
                    <input type="number" name="price" required step="0.01">
                </div>
                <div class="form-group">
                    <label>Discount (%)</label>
                    <input type="number" name="discount" value="0" step="0.01">
                </div>
                <button type="submit" class="btn-solid admin-submit-btn" style="background-color: #5D4037; color: white; border-radius: 6px;">Add to Menu</button>
            </form>
        </section>

        <section class="table-section">
            <h2><i class="fa-solid fa-list"></i> Current Menu Items</h2>
            <div class="table-wrapper">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Item Name</th>
                            <th>Description</th>
                            <th>Update Price and Discount</th>
                            <th>Final Price</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            @SuppressWarnings("unchecked")
                            List<Map<String, Object>> menuList = (List<Map<String, Object>>) request.getAttribute("menuList");
                            if (menuList != null && !menuList.isEmpty()) {
                                for (Map<String, Object> item : menuList) {
                                    double price = (Double)item.get("price");
                                    double disc = (Double)item.get("discount");
                                    double finalPrice = price - (price * (disc/100));
                        %>
                        <tr>
                            <td><strong><%= item.get("name") %></strong><br><small class="text-muted"><%= item.get("category") %></small></td>
                            <td><small><%= item.get("description") %></small></td>
                            <td>
                                <form action="AdminMenuController" method="POST" style="display: flex; gap: 5px; align-items: center;">
                                    <input type="hidden" name="formAction" value="update">
                                    <input type="hidden" name="id" value="<%= item.get("id") %>">
                                    <input type="number" name="price" value="<%= price %>" style="width:70px;">
                                    <input type="number" name="discount" value="<%= disc %>" style="width:45px;">%
                                    <button type="submit" class="status-tag active" style="border:none; cursor:pointer;">
                                        <i class="fa-solid fa-check"></i>
                                    </button>
                                </form>
                            </td>
                            <td class="price-highlight">Rs. <%= String.format("%.2f", finalPrice) %></td>
                            <td>
                                <a href="?action=delete&id=<%= item.get("id") %>" class="btn-delete" onclick="return confirm('Remove this dish?');">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr><td colspan="5" style="text-align:center;">No dishes found in database.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>

    <footer style="text-align: center; padding: 20px; color: #5D4037;">
        <p>FeatherNote — Admin Management Dashboard Interface.</p>
    </footer>

</body>
</html>