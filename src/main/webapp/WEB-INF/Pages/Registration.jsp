<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Join FeatherNote | Registration</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

    <div class="registration-container">
        <div class="registration-card">
            <div class="registration-header">
                <div class="logo-icon">
                    <i class="fa-solid fa-utensils"></i>
                </div>
                <h1>FeatherNote</h1>
                <p>Create your account to start the experience</p>
            </div>

           
            <form action="${pageContext.request.contextPath}/RegistrationController" method="POST">
                <div class="form-group">
                    <i class="fa-solid fa-user"></i>
                    <input type="text" name="username" placeholder="Full Name" required>
                </div>

                <div class="form-group">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" name="email" placeholder="Email Address" required>
                </div>

                <div class="form-group">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="password" placeholder="Password" required>
                </div>

                <div class="form-group">
                    <i class="fa-solid fa-lock-open"></i>
                    <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                </div>

                <button type="submit" class="btn-primary">Sign Up</button>
            </form>

            <div class="registration-footer">
                <p>Already have an account? <a href="LoginController">Login here</a></p>
            </div>
        </div>
    </div>

</body>
</html>