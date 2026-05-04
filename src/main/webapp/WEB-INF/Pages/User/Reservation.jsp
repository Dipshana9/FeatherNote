<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Table Reservation | Thai SpiceSip</title>
</head>
<header class="nav-header" style="display: flex; justify-content: space-between; padding: 20px 60px; background: rgba(93, 64, 55, 0.9); color: white;">
    <div style="font-size: 1.8rem; font-family: serif;">FeatherNote</div>
    <nav>
        <!-- Added Home Link -->
        <a href="${pageContext.request.contextPath}/HomeController" style="color: white; margin-left: 20px; text-decoration: none;">Home</a>
        
        <a href="UserMenuController" style="color: white; margin-left: 20px; text-decoration: none;">Menu</a>
        <a href="ReservationController" style="color: white; margin-left: 20px; text-decoration: none;">Reservations</a>
        
        <!-- Updated Logout to point to LogoutController for session safety -->
        <a href="${pageContext.request.contextPath}/LoginController" style="color: #F8BBD0; margin-left: 20px; text-decoration: none;">Logout</a>
    </nav>
</header>
<body style="background-color: #FFF9F6; font-family: sans-serif; color: #5D4037;">

    <!-- SUCCESS OVERLAY (Hidden by default) -->
    <div id="resSuccess" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(255,249,246,0.98); z-index:2000; flex-direction:column; align-items:center; justify-content:center;">
        <div style="text-align:center; padding:50px; border:2px solid #F8BBD0; background:white; border-radius:20px;">
            <div style="font-size: 60px; color: #F8BBD0; margin-bottom: 20px;">📅</div>
            <h1 style="font-family: serif;">Reservation Complete!</h1>
            <p>Your table is booked. We look forward to serving you.</p>
            <button onclick="window.location.href='${pageContext.request.contextPath}/UserMenuController'" style="margin-top:30px; background:#5D4037; color:white; border:none; padding:15px 40px; border-radius:30px; cursor:pointer;">
                Back to Menu
            </button>
        </div>
    </div>

    <div style="max-width: 600px; margin: 50px auto; background: white; border: 1px solid #F8BBD0; padding: 40px; border-radius: 8px;">
        <h1 style="text-align: center; color: #F8BBD0; font-family: serif;">Table Reservation</h1>
        
        <form id="resForm">
            <!-- DATE AND TIME SELECTION -->
            <div style="margin-bottom: 20px;">
                <label style="display:block; font-weight:bold; margin-bottom: 8px;">Select Date  Time:</label>
                <div style="display: flex; gap: 10px;">
                    <input type="date" name="resDate" required style="flex: 2; padding: 10px; border: 1px solid #D7CCC8;">
                    <input type="time" name="resTime" required style="flex: 1; padding: 10px; border: 1px solid #D7CCC8;">
                </div>
            </div>

            <div style="margin-bottom: 20px;">
                <label style="display:block; font-weight:bold; margin-bottom: 8px;">Select Table:</label>
                <select name="tableNo" style="width: 100%; padding: 10px; border: 1px solid #D7CCC8;">
                    <option>Table 1 (Window View)</option>
                    <option>Table 2 (Garden Side)</option>
                    <option>Table 3 (Couple Booth)</option>
                </select>
            </div>

            <div style="margin-bottom: 25px;">
                <label style="display:block; font-weight:bold; margin-bottom: 8px;">Payment Method:</label>
                <input type="radio" name="payMethod" value="Cash" checked> Cash at Counter
                <input type="radio" name="payMethod" value="Online" style="margin-left:20px;"> Online Payment
            </div>

            <div style="display: flex; justify-content: space-between; font-size: 1.4rem; font-weight: bold; border-top: 1px solid #EEE; padding-top: 20px;">
                <span>Order Total:</span>
                <!-- Fix: Providing a fallback if total is null -->
                <span style="color: #F8BBD0;">Rs. <%= (request.getParameter("total") != null) ? request.getParameter("total") : "0.00" %></span>
                <input type="hidden" name="totalAmount" value="<%= request.getParameter("total") %>">
            </div>

            <button type="button" onclick="submitReservation()" style="width: 100%; background: #5D4037; color: white; border: none; padding: 18px; margin-top: 30px; border-radius: 5px; cursor: pointer; font-weight: bold;">
                Confirm Reservation
            </button>
        </form>
    </div>

    <script>
        function submitReservation() {
            const form = document.getElementById('resForm');
            const formData = new FormData(form);

            // AJAX call to your ReservationController
            fetch('ReservationController', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
            .then(response => {
                // Show the "Reservation Complete" message
                document.getElementById('resSuccess').style.display = 'flex';
            })
            .catch(err => alert("Error processing reservation."));
        }
    </script>
</body>
</html>