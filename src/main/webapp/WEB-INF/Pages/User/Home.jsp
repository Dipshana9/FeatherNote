<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>FeatherNote Thai | Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

    <!-- HEADER: Solid Brown with Pink Logout -->
    <header class="nav-header">
        <div class="nav-logo">FeatherNote</div>
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/HomeController">Home</a>
            <a href="${pageContext.request.contextPath}/MenuController">Menu</a>
            <a href="${pageContext.request.contextPath}/ReservationController">Reservations</a>
            <a href="${pageContext.request.contextPath}/FeedbackController">Feedback</a>
            <% if (session.getAttribute("userEmail") != null) { %>
                <a href="${pageContext.request.contextPath}/LoginController" class="logout-link">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/LoginController">Logout</a>
            <% } %>
        </nav>
    </header>

    <!-- HERO SECTION -->
    <main class="hero-container">
        <div class="hero-content">
            <h1>A Symphony of Thai Flavors</h1>
            <div class="hero-btns">
                <a href="${pageContext.request.contextPath}/UserMenuController" class="btn-solid">Order Now</a>
                <a href="${pageContext.request.contextPath}/ReservationController" class="btn-outline">Book a Table</a>
            </div>
        </div>
    </main>

    <!-- CHEF'S RECOMMENDATIONS SECTION -->
    <section class="recommendations">
        <h2>Chef's Recommendations</h2>
        <div class="card-container">
            <!-- Pad Thai -->
            <div class="dish-card">
                <div class="img-wrapper">
                    <img src="https://i1-c.pinimg.com/1200x/86/36/0d/86360d6aa83b4570417451bcb4d03350.jpg" alt="Pad Thai">
                </div>
                <h3>Classic Pad Thai</h3>
                <p class="dish-price">Rs. 1200</p>
            </div>
            <!-- Green Curry -->
            <div class="dish-card">
                <div class="img-wrapper">
                    <img src="https://i1-c.pinimg.com/webp/1200x/33/10/82/331082ea71ec4572013572316482f4ea.webp" alt="Green Curry">
                </div>
                <h3>Green Curry</h3>
                <p class="dish-price">Rs. 1500</p>
            </div>
            <!-- Tom Yum -->
            <div class="dish-card">
                <div class="img-wrapper">
                    <img src="https://i1-c.pinimg.com/webp/1200x/c9/28/5f/c9285f6cea90c7d15589744e4785342b.webp" alt="Tom Yum">
                </div>
                <h3>Tom Yum Goong</h3>
                <p class="dish-price">Rs. 1100</p>
            </div>
        </div>
    </section>

    <!-- ABOUT US SECTION -->
    <section class="about-us">
        <div class="about-content">
            <h2>Our Story</h2>
            <p>
                Welcome to <strong>FeatherNote Thai</strong>, where culinary tradition meets elegant modern dining. 
                Our journey began with a simple passion: to serve authentic, vibrant Thai heritage flavors 
                crafted from the finest locally sourced ingredients and traditional spices.
            </p>
            <p>
                From our kitchen to your table, every dish represents a careful balance of sweet, sour, salty, and spicy elements. 
                Whether you are joining us for an intimate dinner or ordering a cozy meal home, we promise an exceptional experience wrapped in elegance.
            </p>
        </div>
    </section>

    <!-- FOOTER: Solid Brown Bar -->
    <footer class="main-footer">
        <p>FeatherNote — Authenticity Wrapped in Elegance.</p>
    </footer>

</body>
</html>