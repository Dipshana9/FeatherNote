<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>FeatherNote | Feedback</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        /* Theme Styling to match FeatherNote */
        body { margin: 0; font-family: 'Segoe UI', sans-serif; background-color: #FAF4F0; color: #5D4037; }
        
        /* Header Styling from your screenshot */
        .nav-header { background-color: #5D4037; padding: 15px 40px; display: flex; justify-content: space-between; align-items: center; color: white; }
        .nav-logo { font-size: 24px; font-weight: bold; }
        .nav-links a { color: white; text-decoration: none; margin-left: 20px; font-size: 16px; }
        .nav-links a:hover { text-decoration: underline; }

        .container { max-width: 800px; margin: 40px auto; padding: 0 20px; }
        
        /* Card Styling */
        .feedback-card { background: white; border: 1px solid #FAD1D1; border-radius: 8px; padding: 20px; margin-bottom: 20px; position: relative; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .post-form textarea { width: 100%; border: 1px solid #FAD1D1; border-radius: 5px; padding: 12px; margin-top: 10px; box-sizing: border-box; resize: vertical; }
        .btn-submit { background: #5D4037; color: white; border: none; padding: 10px 25px; border-radius: 5px; cursor: pointer; margin-top: 10px; font-weight: bold; }
        
        .user-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
        .admin-reply { background: #FFF9F9; border-left: 4px solid #5D4037; padding: 12px; margin-top: 15px; font-style: italic; font-size: 0.95em; }
        
        .delete-link { color: #C62828; text-decoration: none; font-size: 0.85em; }
        .delete-link:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <header class="nav-header">
        <div class="nav-logo">FeatherNote</div>
        <nav class="nav-links">
            <a href="HomeController">Home</a>
            <a href="MenuController">Menu</a>
             <a href="${pageContext.request.contextPath}/ReservationController">Reservations</a>
            <a href="FeedbackController" style="font-weight: bold;">Feedback</a>
            <a href="LoginController">Logout</a>
        </nav>
    </header>

    <div class="container">
        <h2><i class="fa-solid fa-comments"></i> User Feedback</h2>

        <div class="feedback-card">
            <strong>Leave a message for us:</strong>
            <form action="FeedbackController" method="POST">
                <textarea name="message" rows="3" placeholder="How was your experience today?" required></textarea>
                <button type="submit" class="btn-submit">Post Message</button>
            </form>
        </div>

        <hr style="border: 0; border-top: 1px solid #FAD1D1; margin: 30px 0;">

        <% 
            String currentUserEmail = (String) session.getAttribute("userEmail");
            @SuppressWarnings("unchecked")
            List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("feedbackList");
            
            if (list != null && !list.isEmpty()) {
                for (Map<String, Object> feedback : list) {
                    // Logic: User can only see delete button for their OWN email
                    boolean isOwner = feedback.get("email") != null && feedback.get("email").equals(currentUserEmail);
        %>
            <div class="feedback-card">
                <div class="user-meta">
                    <span><strong><i class="fa-solid fa-user-circle"></i> <%= feedback.get("name") %></strong></span>
                    <% if (isOwner) { %>
                        <a href="FeedbackController?action=deleteOwn&id=<%= feedback.get("id") %>" class="delete-link" onclick="return confirm('Delete your post?')">
                            <i class="fa-solid fa-trash-can"></i> Delete
                        </a>
                    <% } %>
                </div>
                <p style="margin: 5px 0;"><%= feedback.get("message") %></p>
                <small style="color: #999;"><%= feedback.get("created_at") %></small>

                <% if (feedback.get("reply_message") != null) { %>
                    <div class="admin-reply">
                        <strong><i class="fa-solid fa-reply"></i> Admin Reply:</strong><br>
                        <%= feedback.get("reply_message") %>
                    </div>
                <% } %>
            </div>
        <% 
                } 
            } else { 
        %>
            <p style="text-align: center; color: #888;">No feedback yet. Be the first to post!</p>
        <% } %>
    </div>

</body>
</html>