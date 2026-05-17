<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>FeatherNote - Menu</title>
    <link rel="stylesheet" href="cssx/style.css">
    <style>
        :root {
            --brown: #5D4037;
            --soft-pink: #FCE4EC;
            --white: #FFF9FB;
            --deep-pink: #F8BBD0;
        }

        body {
            background-color: var(--white);
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            color: var(--brown);
        }

        header {
            background-color: var(--brown);
            color: white;
            padding: 15px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo { font-size: 24px; font-weight: bold; }
        nav a { color: white; text-decoration: none; margin-left: 20px; font-size: 14px; }

        .menu-container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background-color: var(--soft-pink);
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .menu-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid rgba(93, 64, 55, 0.1);
        }

        .qty-input {
            width: 50px;
            padding: 5px;
            border: 1px solid var(--brown);
            border-radius: 4px;
        }

        .delivery-option {
            margin: 20px 0;
            padding: 15px;
            border: 2px dashed var(--brown);
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .footer-cart {
            margin-top: 30px;
            padding: 20px;
            background-color: var(--brown);
            color: white;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-checkout {
            background-color: var(--deep-pink);
            color: var(--brown);
            border: none;
            padding: 12px 25px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 5px;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
        }

        .modal-content {
            background-color: var(--white);
            width: 350px;
            margin: 15% auto;
            padding: 25px;
            border-radius: 10px;
            border: 3px solid var(--brown);
        }

        .modal-content input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid var(--brown);
            border-radius: 5px;
        }

        .btn-save {
            background-color: var(--brown);
            color: white;
            border: none;
            padding: 10px 20px;
            width: 100%;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">FeatherNote</div>
    <nav>
        <a href="HomeController">Home</a>
        <a href="MenuController">Menu</a>
        <a href="ReservationController">Reservations</a>
        <a href="FeedbackController">Feedback</a>
        <a href="LogoutController">Logout</a>
    </nav>
</header>

<div class="menu-container">
    <h2 style="text-align:center">Feather Menu</h2>

    <div class="menu-item">
        <span><b>Pad Thai</b> ($12)</span>
        <input type="number" class="qty" data-price="12" value="0" min="0" onchange="updateTotal()">
    </div>
    <div class="menu-item">
        <span><b>Green Curry</b> ($14)</span>
        <input type="number" class="qty" data-price="14" value="0" min="0" onchange="updateTotal()">
    </div>
    <div class="menu-item">
        <span><b>Tom Yum</b> ($10)</span>
        <input type="number" class="qty" data-price="10" value="0" min="0" onchange="updateTotal()">
    </div>
    <div class="menu-item">
        <span><b>Spring Rolls</b> ($6)</span>
        <input type="number" class="qty" data-price="6" value="0" min="0" onchange="updateTotal()">
    </div>
    <div class="menu-item">
        <span><b>Mango Sticky Rice</b> ($7)</span>
        <input type="number" class="qty" data-price="7" value="0" min="0" onchange="updateTotal()">
    </div>

    <div class="delivery-option">
        <input type="checkbox" id="deliveryCheck" onclick="toggleDelivery()">
        <label for="deliveryCheck"><b>Opt for Home Delivery?</b></label>
    </div>

    <div class="footer-cart">
        <div>Total: <b>$<span id="grandTotal">0.00</span></b></div>
        <button class="btn-checkout" onclick="handleCheckout()">Place Order</button>
    </div>
</div>

<div id="deliveryModal" class="modal">
    <div class="modal-content">
        <h3 style="margin-top:0">Delivery Details</h3>
        <input type="text" id="address" placeholder="Enter Full Address">
        <input type="text" id="phone" placeholder="Enter Phone Number">
        <button class="btn-save" onclick="closeModal()">Save and  Continue</button>
    </div>
</div>

<script>
    function updateTotal() {
        let total = 0;
        document.querySelectorAll('.qty').forEach(input => {
            total += (parseInt(input.value) || 0) * parseFloat(input.getAttribute('data-price'));
        });
        document.getElementById('grandTotal').innerText = total.toFixed(2);
    }

    function toggleDelivery() {
        if (document.getElementById('deliveryCheck').checked) {
            document.getElementById('deliveryModal').style.display = 'block';
        }
    }

    function closeModal() {
        const addr = document.getElementById('address').value;
        const ph = document.getElementById('phone').value;
        if (addr && ph) {
            document.getElementById('deliveryModal').style.display = 'none';
        } else {
            alert("Please fill in delivery info!");
        }
    }

    function handleCheckout() {
        const total = parseFloat(document.getElementById('grandTotal').innerText);
        if (total <= 0) {
            alert("Your cart is empty!");
            return;
        }

        if (document.getElementById('deliveryCheck').checked) {
            const addr = document.getElementById('address').value;
            if (!addr) {
                document.getElementById('deliveryModal').style.display = 'block';
                return;
            }
        }

        alert("Payment Completed! Your order is being processed.");
        location.reload(); // Resets the page
    }
</script>

</body>
</html>