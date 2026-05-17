<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>FeatherNote | Feedback Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin/AdminUserController.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .reply-box { background-color: #FAF4F0; border: 1px dashed #5D4037; padding: 10px; border-radius: 6px; margin-top: 8px; }
        .reply-form { display: flex; gap: 10px; margin-top: 8px; }
        .reply-input { flex-grow: 1; padding: 8px; border: 1px solid #FAD1D1; border-radius: 4px; }
        .btn-reply { background-color: #5D4037; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body class="admin-body">

    <header class="nav-header">
        <div class="nav-container">
            <div class="nav-logo">FeatherNote <span class="admin-label">Admin</span></div>
            <nav class="nav-menu">
                <ul class="nav-list">
                    <li><a href="AdminDashboardController"><i class="fa-solid fa-chart-line"></i> Dashboard</a></li>
                    <li><a href="AdminUserController"><i class="fa-solid fa-users"></i> Users</a></li>
                    <li><a href="AdminMenuController"><i class="fa-solid fa-utensils"></i> Menu</a></li>
                    
                    <li><a href="AdminFeedbackController" class="active"><i class="fa-solid fa-comments"></i> Feedback</a></li>
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
        <section class="table-section">
            <h2><i class="fa-solid fa-comments"></i> User Feedback Inbox</h2>
            <div class="table-wrapper">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th style="width: 5%">ID</th>
                            <th style="width: 20%">User Details</th>
                            <th style="width: 45%">Feedback Message and Admin Responses</th>
                            <th style="width: 15%">Submitted Date</th>
                            <th style="width: 15%">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            @SuppressWarnings("unchecked")
                            List<Map<String, Object>> feedbacks = (List<Map<String, Object>>) request.getAttribute("feedbackList");
                            if (feedbacks != null && !feedbacks.isEmpty()) {
                                for (Map<String, Object> item : feedbacks) {
                                    boolean isReplied = (item.get("reply_message") != null);
                        %>
                        <tr>
                            <td>#<%= item.get("id") %></td>
                            <td>
                                <strong><%= item.get("name") %></strong><br>
                                <small style="color: #888;"><%= item.get("email") %></small>
                            </td>
                            <td>
                                <p style="margin: 0; font-weight: 500;"><%= item.get("message") %></p>
                                
                                <% if (isReplied) { %>
                                    <!-- Display existing Reply -->
                                    <div class="reply-box">
                                        <small style="color: #5D4037; font-weight: bold;"><i class="fa-solid fa-reply"></i> Admin Reply:</small>
                                        <p style="margin: 3px 0 0 0; font-style: italic;"><%= item.get("reply_message") %></p>
                                        <small style="color: #888; font-size: 0.75rem;">Replied on: <%= item.get("replied_at") %></small>
                                    </div>
                                <% } else { %>
                                    <!-- Action form to add a Reply -->
                                    <form action="FeedbackController" method="POST" class="reply-form">
                                        <input type="hidden" name="action" value="adminReply">
                                        <input type="hidden" name="feedbackId" value="<%= item.get("id") %>">
                                        <input type="text" name="replyMessage" class="reply-input" required placeholder="Type your response to this user...">
                                        <button type="submit" class="btn-reply">Reply</button>
                                    </form>
                                <% } %>
                            </td>
                            <td><%= item.get("created_at") %></td>
                            <td>
                                <% if (isReplied) { %>
                                    <span class="status-tag active">Resolved</span>
                                <% } else { %>
                                    <span class="status-tag deleted" style="background-color: #FFF3E0; color: #E65100; border-color: #FFE0B2;">Pending</span>
                                <% } %>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 30px; color: #888;">No feedback records found.</td>
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