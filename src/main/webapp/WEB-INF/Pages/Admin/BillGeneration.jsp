<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bill Generation</title>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/BillGeneration.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <h2>Gokyo Admin</h2>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</div>

<div class="container">

    <!-- LEFT SIDE -->
    <div class="left">

        <h2>Orders</h2>

        <input type="text" id="searchInput" placeholder="Search..." onkeyup="searchOrders()">

        <div id="ordersList"></div>

    </div>

    <!-- RIGHT SIDE -->
    <div class="right" id="billPreview" style="display:none;">

        <h2>Bill</h2>

        <div id="billContent"></div>

        <button onclick="printBill()">Print</button>

    </div>

</div>

<script>

/* ------------------ UTIL FUNCTIONS ------------------ */

function formatCurrency(val){
    return "Rs. " + val.toLocaleString();
}

function formatDate(date){
    return new Date(date).toLocaleDateString();
}

function calculateTotal(items){
    return items.reduce((sum,i)=> sum + i.price*i.quantity,0);
}

function showMessage(msg){
    alert(msg);
}

/* ------------------ SAMPLE DATA ------------------ */

let orders = [
    {
        id:'ORD-1',
        customer:'John',
        phone:'9800000000',
        table:5,
        type:'dine-in',
        items:[
            {name:'Momo',quantity:2,price:150},
            {name:'Coffee',quantity:1,price:80}
        ],
        advancePaid:100
    },
    {
        id:'ORD-2',
        customer:'Sara',
        phone:'9811111111',
        table:null,
        type:'delivery',
        items:[
            {name:'Chowmein',quantity:1,price:250}
        ],
        advancePaid:0
    }
];

/* ------------------ LOAD ------------------ */

window.onload = function(){
    displayOrders(orders);
};

/* ------------------ DISPLAY ------------------ */

function displayOrders(list){
    let html = "";

    list.forEach(o=>{
        html += `
        <div class="card" onclick="selectOrder('${o.id}')">
            <h3>${o.id}</h3>
            <p>${o.customer}</p>
            <p>${formatCurrency(calculateTotal(o.items))}</p>
        </div>
        `;
    });

    document.getElementById("ordersList").innerHTML = html;
}

/* ------------------ SELECT ------------------ */

function selectOrder(id){
    let order = orders.find(o=>o.id===id);

    let subtotal = calculateTotal(order.items);
    let service = subtotal * 0.1;
    let vat = (subtotal+service)*0.13;
    let total = subtotal + service + vat;

    let html = `
        <p><b>Customer:</b> ${order.customer}</p>
        <p><b>Phone:</b> ${order.phone}</p>
        <p><b>Table:</b> ${order.table || "N/A"}</p>

        <table>
            <tr><th>Item</th><th>Qty</th><th>Total</th></tr>
    `;

    order.items.forEach(i=>{
        html += `<tr>
            <td>${i.name}</td>
            <td>${i.quantity}</td>
            <td>${formatCurrency(i.price*i.quantity)}</td>
        </tr>`;
    });

    html += `
        </table>

        <p>Subtotal: ${formatCurrency(subtotal)}</p>
        <p>Service: ${formatCurrency(service)}</p>
        <p>VAT: ${formatCurrency(vat)}</p>
        <h3>Total: ${formatCurrency(total)}</h3>
    `;

    document.getElementById("billContent").innerHTML = html;
    document.getElementById("billPreview").style.display = "block";
}

/* ------------------ SEARCH ------------------ */

function searchOrders(){
    let val = document.getElementById("searchInput").value.toLowerCase();

    let filtered = orders.filter(o =>
        o.customer.toLowerCase().includes(val) ||
        o.id.toLowerCase().includes(val)
    );

    displayOrders(filtered);
}

/* ------------------ ACTIONS ------------------ */

function printBill(){
    window.print();
}

function logout(){
    alert("Logged out");
}

</script>

</body>
</html>