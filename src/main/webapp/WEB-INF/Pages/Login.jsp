<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>

    <!-- ✅ correct css path -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/Login.css">
</head>
<body>

<div class="container">

    <!-- LOGIN CARD -->
    <div class="login-box">
        <h2>Login Now</h2>

        <!-- ✅ ERROR MESSAGE (NO JSTL) -->
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <p style="color:red;"><%= error %></p>
        <%
            }
        %>

        <!-- ✅ FORM -->
        <form action="<%= request.getContextPath() %>/LoginController"
              method="post">

            <input type="email" name="email"
                   placeholder="Email" required>

            <input type="password" name="password"
                   placeholder="Password" required>

            <button class="login-btn" type="submit">
                LOGIN
            </button>
        </form>

        <p class="signup">
            Not a member?
            <a href="<%= request.getContextPath() %>/RegistrationController">
                Sign up
            </a>
        </p>
    </div>

    <!-- IMAGE SIDE -->
    <div class="illustration">
        <img src="<%= request.getContextPath() %>/images/Login.png"
             alt="Login Image">
    </div>

</div>

</body>
</html>
