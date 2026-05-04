<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Feather Note | Menu</title>
</head>
<body style="background-color: #FFF9F6; font-family: 'serif', 'Times New Roman'; margin: 0; color: #5D4037;">
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
    <form action="UserMenuController" method="POST">
        <div style="text-align: center; padding: 50px;">
            <h1 style="color: #F8BBD0; font-size: 3.5rem; margin-bottom: 10px;">Feather Note </h1>
            <p style="color: #8D6E63; font-style: italic; font-size: 1.2rem;">Authentic flavors for you</p>
            
            <!-- FOOD SECTION -->
            <h2 style="color: #F8BBD0; margin-top: 50px; border-bottom: 2px solid #F8BBD033; display: inline-block; padding: 0 20px;">Main Entrees</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 25px; padding: 30px 60px;">
                
                <!-- Pad Thai -->
                <div style="text-align: left; background: white; padding: 20px; border: 1px solid #F8BBD0; border-radius: 8px;">
                    <div style="background: #EFEBE9; height: 180px; border-radius: 5px; margin-bottom: 15px;"></div>
                    <input type="hidden" name="itemNames" value="Pad Thai">
                    <h3 style="color: #F8BBD0; margin: 0; font-size: 1.5rem;">Pad Thai</h3>
                    <p style="color: #5D4037; font-weight: bold; margin: 8px 0;">Rs. 650</p>
                    <input type="hidden" name="itemPrices" value="650">
                    <input type="number" name="itemQuantities" value="0" min="0" oninput="calculateTotal()" 
                           style="width: 100%; border: 1px solid #D7CCC8; padding: 10px; border-radius: 4px;">
                </div>

                <!-- Green Curry -->
                <div style="text-align: left; background: white; padding: 20px; border: 1px solid #F8BBD0; border-radius: 8px;">
                    <div style="background: #EFEBE9; height: 180px; border-radius: 5px; margin-bottom: 15px;"></div>
                    <input type="hidden" name="itemNames" value="Green Curry">
                    <h3 style="color: #F8BBD0; margin: 0; font-size: 1.5rem;">Green Curry</h3>
                    <p style="color: #5D4037; font-weight: bold; margin: 8px 0;">Rs. 750</p>
                    <input type="hidden" name="itemPrices" value="750">
                    <input type="number" name="itemQuantities" value="0" min="0" oninput="calculateTotal()" 
                           style="width: 100%; border: 1px solid #D7CCC8; padding: 10px; border-radius: 4px;">
                </div>

                <!-- Tom Yum -->
                <div style="text-align: left; background: white; padding: 20px; border: 1px solid #F8BBD0; border-radius: 8px;">
                    <div style="background: #EFEBE9; height: 180px; border-radius: 5px; margin-bottom: 15px;"></div>
                    <input type="hidden" name="itemNames" value="Tom Yum Soup">
                    <h3 style="color: #F8BBD0; margin: 0; font-size: 1.5rem;">Tom Yum Soup</h3>
                    <p style="color: #5D4037; font-weight: bold; margin: 8px 0;">Rs. 800</p>
                    <input type="hidden" name="itemPrices" value="800">
                    <input type="number" name="itemQuantities" value="0" min="0" oninput="calculateTotal()" 
                           style="width: 100%; border: 1px solid #D7CCC8; padding: 10px; border-radius: 4px;">
                </div>
            </div>

            <!-- BEVERAGE SECTION -->
            <h2 style="color: #F8BBD0; margin-top: 30px; border-bottom: 2px solid #F8BBD033; display: inline-block; padding: 0 20px;">Beverages</h2>
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 25px; padding: 30px 60px;">
                <div style="text-align: left; background: white; padding: 20px; border: 1px solid #F8BBD0; border-radius: 8px;">
                    <div style="background: #EFEBE9; height: 180px; border-radius: 5px; margin-bottom: 15px;"></div>
                    <input type="hidden" name="itemNames" value="Thai Iced Tea">
                    <h3 style="color: #F8BBD0; margin: 0;">Thai Iced Tea</h3>
                    <p style="color: #5D4037; font-weight: bold; margin: 8px 0;">Rs. 250</p>
                    <input type="hidden" name="itemPrices" value="250">
                    <input type="number" name="itemQuantities" value="0" min="0" oninput="calculateTotal()" 
                           style="width: 100%; border: 1px solid #D7CCC8; padding: 10px; border-radius: 4px;">
                </div>
            </div>

            <div style="margin-top: 50px; background: white; display: inline-block; padding: 20px 40px; border: 1px solid #F8BBD0; border-radius: 50px;">
                <span style="font-size: 1.2rem; margin-right: 20px;">Estimated Total: <b>Rs. <span id="displayTotal">0</span></b></span>
                <input type="hidden" name="totalAmount" id="hiddenTotal" value="0">
                <button type="submit" style="background: #5D4037; color: white; border: none; padding: 15px 40px; font-weight: bold; border-radius: 30px; cursor: pointer;">
                    View My Cart
                </button>
            </div>
        </div>
    </form>

    <script>
        function calculateTotal() {
            let total = 0;
            let qtys = document.getElementsByName("itemQuantities");
            let prices = document.getElementsByName("itemPrices");
            for (let i = 0; i < qtys.length; i++) {
                total += (parseInt(qtys[i].value) || 0) * (parseInt(prices[i].value) || 0);
            }
            document.getElementById("hiddenTotal").value = total;
            document.getElementById("displayTotal").innerText = total;
        }
    </script>
</body>
</html>