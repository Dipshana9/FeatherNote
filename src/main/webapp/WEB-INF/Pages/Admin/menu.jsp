<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<body style="background-color: #FFF9F6; font-family: 'serif'; margin: 0; color: #5D4037;">
    <form action="UserMenuController" method="POST">
        <div style="text-align: center; padding: 50px;">
            <h1 style="color: #F8BBD0; font-size: 3rem; margin-bottom: 5px;">Thai Spice Collection</h1>
            <p style="color: #8D6E63; font-style: italic;">Authentic flavors from our kitchen to yours</p>
            
            <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; padding: 40px;">
                <!-- Pad Thai Item -->
                <div style="text-align: left; background: white; padding: 15px; border: 1px solid #F8BBD0; border-radius: 5px;">
                    <div style="background: #EFEBE9; height: 200px; border-radius: 3px; margin-bottom: 12px;"></div>
                    <input type="hidden" name="itemNames" value="Pad Thai">
                    <h3 style="color: #F8BBD0; margin: 0;">Pad Thai</h3>
                    <p style="color: #5D4037; font-weight: bold; margin: 5px 0;">Rs. 650</p>
                    <input type="hidden" name="itemPrices" value="650">
                    <input type="number" name="itemQuantities" value="0" min="0" oninput="calculateTotal()" style="width: 100%; border: 1px solid #D7CCC8; padding: 8px; box-sizing: border-box;">
                </div>

                <!-- Green Curry Item -->
                <div style="text-align: left; background: white; padding: 15px; border: 1px solid #F8BBD0; border-radius: 5px;">
                    <div style="background: #EFEBE9; height: 200px; border-radius: 3px; margin-bottom: 12px;"></div>
                    <input type="hidden" name="itemNames" value="Green Curry">
                    <h3 style="color: #F8BBD0; margin: 0;">Green Curry</h3>
                    <p style="color: #5D4037; font-weight: bold; margin: 5px 0;">Rs. 750</p>
                    <input type="hidden" name="itemPrices" value="750">
                    <input type="number" name="itemQuantities" value="0" min="0" oninput="calculateTotal()" style="width: 100%; border: 1px solid #D7CCC8; padding: 8px; box-sizing: border-box;">
                </div>
            </div>

            <div style="margin-top: 20px;">
                <input type="hidden" name="totalAmount" id="hiddenTotal" value="0">
                <button type="submit" style="background: #5D4037; color: white; border: none; padding: 15px 50px; font-weight: bold; border-radius: 30px; cursor: pointer;">
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
        }
    </script>
</body>