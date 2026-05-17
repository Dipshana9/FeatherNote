<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>FeatherNote | Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin/AdminUserController.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .stat-card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #FAD1D1;
            text-align: center;
            box-shadow: 0 4px 15px rgba(93, 64, 55, 0.05);
        }
        .stat-card i { font-size: 2.5rem; color: #5D4037; margin-bottom: 15px; }
        .stat-card h3 { font-size: 1rem; color: #888; text-transform: uppercase; margin: 0; }
        .stat-card .value { font-size: 2rem; font-weight: bold; color: #5D4037; margin: 10px 0; }
        .stat-card .sub-text { font-size: 0.85rem; color: #2E7D32; font-weight: bold; }
    </style>
</head>
<body class="admin-body">

    <header class="nav-header">
        <div class="nav-container">
            <div class="nav-logo">FeatherNote <span class="admin-label">Admin</span></div>
            <nav class="nav-menu">
                <ul class="nav-list">
                    <li><a href="AdminDashboardController" class="active"><i class="fa-solid fa-chart-line"></i> Dashboard</a></li>
                    <li><a href="AdminUserController"><i class="fa-solid fa-users"></i> Users</a></li>
                    <li><a href="AdminMenuController"><i class="fa-solid fa-utensils"></i> Menu</a></li>
                    <li><a href="AdminFeedbackController"><i class="fa-solid fa-comments"></i> Feedback</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main class="admin-container">
        <h2><i class="fa-solid fa-gauge-high"></i> Management Overview</h2>
        
        <% 
            // This suppresses the warning you saw in image_0e1d2e.png
            @SuppressWarnings("unchecked")
            Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats"); 
            
            // Ensure stats isn't null so the getOrDefault methods work
            if (stats == null) {
                stats = new java.util.HashMap<>();
            }
        %>

        <div class="stats-grid">
            <div class="stat-card">
                <i class="fa-solid fa-receipt"></i>
                <h3>Daily Orders</h3>
                <div class="value"><%= stats.getOrDefault("dailyOrders", 0) %></div>
                <div class="sub-text">Fresh transactions today</div>
            </div>

            <div class="stat-card">
                <i class="fa-solid fa-sack-dollar"></i>
                <h3>Daily Revenue</h3>
                <div class="value">Rs. <%= stats.getOrDefault("dailyProfit", 0.0) %></div>
                <div class="sub-text">Total earnings today</div>
            </div>

            <div class="stat-card">
                <i class="fa-solid fa-star"></i>
                <h3>Top Selling Dish</h3>
                <div class="value" style="font-size: 1.5rem;"><%= stats.getOrDefault("topDish", "None") %></div>
                <div class="sub-text"><%= stats.getOrDefault("topDishCount", 0) %> units sold total</div>
            </div>
        </div>
    </main>

</body>
</html>