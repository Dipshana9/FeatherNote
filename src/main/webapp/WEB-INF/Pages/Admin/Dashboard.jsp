<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | FeatherNote</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
       <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Admin/Dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header">
        <i class="fa-solid fa-circle-nodes"></i>
        <span>FeatherNote</span>
    </div>
    
    <ul>
        <li class="active">
            <a href="<%= request.getContextPath() %>/admin/dashboard.jsp">
                <i class="fa-solid fa-chart-pie"></i> Dashboard
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/menu.jsp">
                <i class="fa-solid fa-utensils"></i> Menu
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/bookings.jsp">
                <i class="fa-solid fa-calendar-days"></i> Bookings
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/orders.jsp">
                <i class="fa-solid fa-cart-shopping"></i> Orders
            </a>
        </li>
        <li>
            <a href="<%= request.getContextPath() %>/admin/customers.jsp">
                <i class="fa-solid fa-user-group"></i> Customers
            </a>
        </li>
    </ul>
</div>

<div class="main">
    <div class="topbar">
        <div>
            <h1>Overview</h1>
            <p>Welcome, Administrator</p>
        </div>
        <div class="user-profile">
            <i class="fa-solid fa-circle-user"></i>
        </div>
    </div>

    <div class="cards">
        <div class="card">
            <div class="card-info">
                <span>Total Revenue</span>
                <h3>Rs. 45,800</h3>
            </div>
            <i class="fa-solid fa-indian-rupee-sign icon-bg"></i>
        </div>
        <div class="card">
            <div class="card-info">
                <span>Active Bookings</span>
                <h3>23</h3>
            </div>
            <i class="fa-solid fa-check-to-slot icon-bg"></i>
        </div>
        <div class="card">
            <div class="card-info">
                <span>Orders Today</span>
                <h3>156</h3>
            </div>
            <i class="fa-solid fa-bag-shopping icon-bg"></i>
        </div>
    </div>

    <div class="table-container">
        <div class="table-header">
            <h3>Recent Reservations</h3>
            <button class="btn-view">View All</button>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Customer</th>
                    <th>Time</th>
                    <th>Guests</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Priya Sharma</td>
                    <td>07:00 PM</td>
                    <td>4 Guests</td>
                    <td><span class="status-pill success">Confirmed</span></td>
                </tr>
                <tr>
                    <td>Rahul Verma</td>
                    <td>07:30 PM</td>
                    <td>2 Guests</td>
                    <td><span class="status-pill warning">Pending</span></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>