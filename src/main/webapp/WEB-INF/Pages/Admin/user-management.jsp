<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>FeatherNote | User Management</title>
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
                    <li><a href="AdminUserController" class="active"><i class="fa-solid fa-users"></i> Users</a></li>
                    <li><a href="AdminMenuController"><i class="fa-solid fa-utensils"></i> Menu</a></li>

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
            <h2><i class="fa-solid fa-user-plus"></i> Add New User Account</h2>
            <form action="${pageContext.request.contextPath}/AdminUserController" method="POST" class="admin-form">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" required placeholder="John Doe">
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" required placeholder="email@example.com">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required placeholder="••••••••">
                </div>
                <div class="form-group">
                    <label>System Role</label>
                    <select name="role">
                        <option value="USER">User</option>
                        <option value="ADMIN">Admin</option>
                    </select>
                </div>
                <button type="submit" class="btn-solid admin-submit-btn" style="background-color: #5D4037; color: white; border-radius: 6px;">Save Account</button>
            </form>
        </section>

        <section class="table-section">
            <h2><i class="fa-solid fa-users"></i> System Users Registry</h2>
            <div class="table-wrapper">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Joined Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            @SuppressWarnings("unchecked")
                            List<Map<String, Object>> usersList = (List<Map<String, Object>>) request.getAttribute("usersList");
                            if (usersList != null && !usersList.isEmpty()) {
                                for (Map<String, Object> user : usersList) {
                                    boolean isDeleted = (user.get("is_deleted") != null && (Integer)user.get("is_deleted") == 1);
                        %>
                        <tr class="<%= isDeleted ? "row-deleted" : "" %>">
                            <td>#<%= user.get("id") %></td>
                            <td><strong><%= user.get("name") %></strong></td>
                            <td><%= user.get("email") %></td>
                            <td>
                                <span class="badge <%= "ADMIN".equals(user.get("role")) ? "badge-admin" : "badge-user" %>">
                                    <%= user.get("role") %>
                                </span>
                            </td>
                            <td><%= user.get("created_at") %></td>
                            <td>
                                <% if (isDeleted) { %>
                                    <span class="status-tag deleted">Deleted on:<br><small><%= user.get("deleted_at") %></small></span>
                                <% } else { %>
                                    <span class="status-tag active">Active</span>
                                <% } %>
                            </td>
                            <td>
                                <% if (!isDeleted) { %>
                                    <a href="?action=delete&id=<%= user.get("id") %>" class="btn-delete" onclick="return confirm('Are you sure?');">
                                        <i class="fa-solid fa-trash-can"></i> Delete
                                    </a>
                                <% } else { %>
                                    <span class="text-muted"><i class="fa-solid fa-lock"></i></span>
                                <% } %>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="7" style="text-align: center; padding: 30px; color: #888;">No users found.</td>
                        </tr>
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