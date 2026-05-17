<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | FeatherNote</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>
    <div class="login-container">
        <div class="login-card">
            
            <div class="login-header">
                <div class="logo-icon">
                    <i class="fa-solid fa-utensils"></i>
                </div>
                <h1>FeatherNote</h1>
                <p>Enter your details to continue</p>
            </div>

            <c:if test="${not empty error}">
                <div style="color: #B71C1C; background: #FFEBEE; padding: 12px; border-radius: 8px; font-size: 14px; margin-bottom: 15px; border: 1px solid #EF9A9A;">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                    
                    <c:if test="${showForgot}">
                        <div style="margin-top: 5px;">
                            <a href="ForgotPasswordController" style="color: #5D4037; font-weight: bold; text-decoration: underline;">Forgot Password?</a>
                        </div>
                    </c:if>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/LoginController" method="post" class="login-form">
                <div class="form-group">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" name="email" placeholder="Email Address" required>
                </div>

                <div class="form-group">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" placeholder="Password" required>
                </div>

                <button type="submit" class="btn-primary">Login</button>
            </form>

            <div class="login-footer">
                <c:choose>
                    <c:when test="${showRegister}">
                         <p style="background: #FFF9C4; padding: 5px;">New here? <a href="RegistrationController" style="color: #D32F2F; text-decoration: underline;">Create an account now</a></p>
                    </c:when>
                    <c:otherwise>
                        <p>Don't have an account? <a href="RegistrationController">Register here</a></p>
                    </c:otherwise>
                </c:choose>
            </div>
            
        </div>
    </div>
</body>
</html>