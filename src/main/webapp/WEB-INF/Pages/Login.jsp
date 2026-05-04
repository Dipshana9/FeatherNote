<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login | FeatherNote</title>
    <!-- Link to the new specific CSS file -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>

<body>
    <!-- This container is what keeps the card in the middle of the screen -->
    <div class="login-container">
        <div class="login-card">
            
            <div class="login-header">
                <div class="logo-icon">
                    <i class="fa-solid fa-utensils"></i>
                </div>
                <h1>FeatherNote</h1>
                <p>Enter your details to continue</p>
            </div>

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
                <p>Don't have an account? <a href="RegistrationController">Register here</a></p>
            </div>
            
        </div>
    </div>
</body>
</html>