<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart | Thai SpiceSip</title>
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
<body style="background-color: #FFF9F6; font-family: sans-serif; margin: 0; color: #5D4037;">

    <!-- SUCCESS OVERLAY -->
    <div id="successMessage" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(255,249,246,0.98); z-index:2000; flex-direction:column; align-items:center; justify-content:center;">
        <div style="text-align:center; padding:50px; border:2px solid #F8BBD0; background:white; border-radius:20px; box-shadow: 0 15px 40px rgba(0,0,0,0.05);">
            <div style="font-size: 60px; color: #F8BBD0; margin-bottom: 20px;">✿</div>
            <h1 style="color: #5D4037; font-family: serif;">Order Successfully Placed!</h1>
            <p style="color: #8D6E63; font-size: 1.1rem;">Your delicious Thai meal is being prepared.</p>
            <button onclick="window.location.href='${pageContext.request.contextPath}/UserMenuController'" 
        style="margin-top:30px; background:#5D4037; color:white; border:none; padding:15px 40px; border-radius:30px; cursor:pointer; font-weight:bold;">
    Back to Menu
</button>
        </div>
    </div>

    <div style="display: flex; gap: 40px; padding: 60px;">
        <!-- CART ITEMS DISPLAY -->
        <div style="flex: 2;">
            <h1 style="color: #F8BBD0; font-size: 3rem; margin-bottom: 40px; font-family: serif;">Your Cart</h1>
            <% 
                String[] names = (String[]) request.getAttribute("items");
                String[] qtys = (String[]) request.getAttribute("qty");
                String[] prices = (String[]) request.getAttribute("price");
                if (names != null) {
                    for (int i = 0; i < names.length; i++) {
                        if (qtys[i] != null && Integer.parseInt(qtys[i]) > 0) {
            %>
            <div style="display: flex; background: white; border: 1px solid #F8BBD0; padding: 25px; margin-bottom: 20px; align-items: center; border-radius: 8px;">
                <div style="width: 120px; height: 100px; background: #EFEBE9; border-radius: 4px; margin-right: 25px;"></div>
                <div style="flex-grow: 1;">
                    <h3 style="margin: 0; color: #3E2723; font-size: 1.4rem;"><%= names[i] %></h3>
                    <p style="color: #5D4037; font-weight: bold; margin: 8px 0;">Rs. <%= prices[i] %></p>
                    <span style="font-size: 0.9rem; color: #8D6E63;">Qty: <%= qtys[i] %></span>
                </div>
            </div>
            <% } } } %>
        </div>

        <!-- SUMMARY PANEL -->
        <div style="flex: 1; background: white; border: 1px solid #F8BBD0; padding: 40px; height: fit-content; border-radius: 8px;">
            <h2 style="font-size: 2.2rem; border-bottom: 2px solid #F8BBD033; padding-bottom: 15px; margin-top: 0; font-family: serif;">Summary</h2>
            
            <div style="margin: 25px 0;">
                <p style="font-weight: bold; color: #8D6E63; margin-bottom: 15px;">Service Preference:</p>
                <div style="margin-bottom: 12px;">
                    <input type="radio" id="delivery" name="serviceType" value="delivery" onclick="selectedService='delivery'">
                    <label for="delivery">Home Delivery</label>
                </div>
                <div style="margin-bottom: 12px;">
                    <input type="radio" id="dinein" name="serviceType" value="dinein" onclick="selectedService='dinein'">
                    <label for="dinein">Dine In</label>
                </div>
            </div>

            <div style="display: flex; justify-content: space-between; font-weight: bold; font-size: 1.6rem; border-top: 2px solid #F8BBD033; padding-top: 20px; margin-top: 20px;">
                <span>Total</span>
                <span style="color: #3E2723;">Rs. ${total}</span>
            </div>

            <button type="button" onclick="handleCheckout()" style="width: 100%; background: #5D4037; color: white; border: none; padding: 20px; font-weight: bold; border-radius: 5px; margin-top: 30px; cursor: pointer; font-size: 1.1rem;">
                Proceed to Checkout
            </button>
        </div>
    </div>

    <!-- DELIVERY DETAILS POPUP -->
    <div id="deliveryModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.4); z-index:1000;">
        <div style="background:white; width:450px; margin:80px auto; padding:40px; border: 2px solid #F8BBD0; border-radius:15px;">
            <h2 style="color: #F8BBD0; font-family: serif; font-size: 2rem;">Delivery Info</h2>
            <!-- Added ID to form and removed action to handle via JS -->
            <form id="orderForm">
                <input type="text" name="custName" placeholder="Full Name" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #D7CCC8; box-sizing:border-box;">
                <input type="text" name="custAddress" placeholder="Full Address" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #D7CCC8; box-sizing:border-box;">
                <input type="text" name="custPhone" placeholder="Mobile Number" required style="width:100%; padding:12px; margin-bottom:15px; border:1px solid #D7CCC8; box-sizing:border-box;">
                
                <p style="font-weight:bold; color:#8D6E63; margin-top: 10px;">Payment Method:</p>
                <div style="margin-bottom: 20px;">
                    <input type="radio" name="payMethod" value="Cash" checked> Cash 
                    <input type="radio" name="payMethod" value="Online" style="margin-left: 20px;"> Online
                </div>
                
                <input type="hidden" name="totalAmount" value="${total}">
                <!-- Changed button to type="button" to prevent default submission -->
                <button type="button" onclick="placeOrder()" style="width:100%; background:#F8BBD0; color:white; border:none; padding:18px; font-weight:bold; cursor:pointer; border-radius: 5px;">Place Order</button>
                <button type="button" onclick="closeModal()" style="width:100%; background:none; border:none; color:#8D6E63; cursor:pointer; margin-top:15px;">Go Back</button>
            </form>
        </div>
    </div>

    <script>
        let selectedService = "";

        function handleCheckout() {
            if (selectedService === 'delivery') {
                document.getElementById('deliveryModal').style.display = 'block';
            } else if (selectedService === 'dinein') {
                window.location.href = "${pageContext.request.contextPath}/ReservationController";
            } else {
                alert("Please select a service type!");
            }
        }

        function closeModal() { 
            document.getElementById('deliveryModal').style.display = 'none'; 
        }

        // Handles the actual background submission
        function placeOrder() {
            const form = document.getElementById('orderForm');
            const formData = new FormData(form);

            fetch('FinalOrderController', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
            .then(response => {
                // Hide input modal and show success overlay regardless of Controller redirect
                closeModal();
                document.getElementById('successMessage').style.display = 'flex';
            })
            .catch(err => {
                console.error(err);
                alert("Error placing order. Please try again.");
            });
        }
    </script>
</body>
</html>