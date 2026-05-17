<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>FeatherNote Thai | Book A Table</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/User/reservation.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

    <!-- HEADER -->
    <header class="nav-header">
        <div class="nav-logo">FeatherNote</div>
        <nav class="nav-links">
            <a href="${pageContext.request.contextPath}/HomeController">Home</a>
            <a href="${pageContext.request.contextPath}/UserMenuController">Menu</a>
            <a href="${pageContext.request.contextPath}/ReservationController">Reservations</a>
            <a href="${pageContext.request.contextPath}/FeedbackController">Feedback</a>
            <% if (session.getAttribute("userEmail") != null) { %>
                <a href="${pageContext.request.contextPath}/LoginController" class="logout-link">Logout</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/LoginController">Logout</a>
            <% } %>
        </nav>
    </header>

    <!-- RESERVATION FORM MAIN CONTENT -->
    <main class="reservation-wrapper">
        <div class="reservation-box">
            <h2>Reserve Your Table</h2>
            <p class="subtitle">Experience authentic Thai tradition wrapped in elegance</p>

            <!-- Alerts for Success/Error Responses -->
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert error-alert">
                    <i class="fa-solid fa-triangle-exclamation"></i> <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert success-alert">
                    <i class="fa-solid fa-circle-check"></i> <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/ReservationController" method="POST">
                
                <div class="form-group">
                    <label for="tableNumber"><i class="fa-solid fa-chair"></i> Select Table</label>
                    <select name="tableNumber" id="tableNumber" required>
                        <option value="" disabled selected>-- Select a Table --</option>
                        <option value="1">Table 1 (2 Persons)</option>
                        <option value="2">Table 2 (2 Persons)</option>
                        <option value="3">Table 3 (4 Persons)</option>
                        <option value="4">Table 4 (4 Persons)</option>
                        <option value="5">Table 5 (6 Persons)</option>
                        <option value="6">Table 6 (Family Lounge)</option>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="resDate"><i class="fa-solid fa-calendar-days"></i> Date</label>
                        <input type="date" name="resDate" id="resDate" required>
                    </div>

                    <div class="form-group">
                        <label for="resTime"><i class="fa-solid fa-clock"></i> Time</label>
                        <select name="resTime" id="resTime" required>
                            <option value="" disabled selected>-- Select Time Slot --</option>
                            <option value="12:00:00">12:00 PM</option>
                            <option value="13:00:00">1:00 PM</option>
                            <option value="14:00:00">2:00 PM</option>
                            <option value="17:00:00">5:00 PM</option>
                            <option value="18:00:00">6:00 PM</option>
                            <option value="19:00:00">7:00 PM</option>
                            <option value="20:00:00">8:00 PM</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="partySize"><i class="fa-solid fa-users"></i> Number of Guests</label>
                    <input type="number" name="partySize" id="partySize" min="1" max="15" placeholder="e.g. 3" required>
                </div>

                <button type="submit" class="btn-reserve">Confirm Reservation</button>
            </form>
        </div>
    </main>

    <!-- FOOTER -->
    <footer class="main-footer">
        <p>FeatherNote — Authenticity Wrapped in Elegance.</p>
    </footer>

    <!-- Minimal script to ensure users can't pick past dates -->
    <script>
        document.getElementById('resDate').min = new Date().toISOString().split("T")[0];
    </script>
</body>
</html>