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
            <a href="${pageContext.request.contextPath}/UserMenuController">Menu</a>
            <a href="${pageContext.request.contextPath}/ReservationController">Reservations</a>
            <% if (session.getAttribute("userEmail") != null) { %>
                <a href="${pageContext.request.contextPath}/LoginController" class="logout-link">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/LoginController">Login</a>
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
                <img src="https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=400" alt="Pad Thai">
                <h3>Classic Pad Thai</h3>
                <p class="dish-price">Rs. 1200</p>
            </div>
            <!-- Green Curry -->
            <div class="dish-card">
                <img src="https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?q=80&w=400" alt="Green Curry">
                <h3>Green Curry</h3>
                <p class="dish-price">Rs. 1500</p>
            </div>
            <!-- Tom Yum -->
            <div class="dish-card">
                <img src="https://images.unsplash.com/photo-1562607394-5abc0c346ad2?q=80&w=400" alt="Tom Yum">
                <h3>Tom Yum Goong</h3>
                <p class="dish-price">Rs. 1100</p>
            </div>
        </div>
    </section>

    <!-- FOOTER: Solid Brown Bar -->
    <footer class="main-footer">
        <p>FeatherNote — Authenticity Wrapped in Elegance.</p>
    </footer>

</body>
</html>