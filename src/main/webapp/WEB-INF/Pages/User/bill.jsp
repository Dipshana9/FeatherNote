<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>FeatherNote | Billing Records</title>
    <style>
        /* Matching the background from image_a7c43d.png */
        body {
            background-color: #FFF9F6; 
            font-family: 'serif'; 
            margin: 0; 
            color: #5D4037;
            padding: 40px;
        }

        .bill-container {
            max-width: 1000px;
            margin: 0 auto;
            background: white; 
            padding: 30px; 
            border-radius: 15px; 
            border: 1px solid #FAD1D1; /* Soft Pink Border */
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .header-title {
            color: #F8BBD0; /* Theme Pink */
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 30px;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .bill-table {
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px;
        }

        .bill-table thead tr {
            background-color: #5D4037; /* Solid Brown Header */
            color: white; 
            text-align: left;
        }

        .bill-table th, .bill-table td {
            padding: 15px;
            border-bottom: 1px solid #FAD1D1;
        }

        .bill-table tbody tr:hover {
            background-color: #FFF9F6; /* Subtle highlight on hover */
        }

        .price-tag {
            font-weight: bold; 
            color: #5D4037;
        }

        .bill-id {
            color: #8D6E63;
            font-family: monospace;
            font-weight: bold;
        }

        .status-paid {
            background: #E8F5E9;
            color: #2E7D32;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>

    <div class="bill-container">
        <h1 class="header-title">Billing History</h1>
        
        <table class="bill-table">
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Customer Email</th>
                    <th>Total Amount</th>
                    <th>Order Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bill" items="${billList}">
                    <tr>
                        <td class="bill-id">#BT-${bill.billId}</td>
                        <td>${bill.userEmail}</td>
                        <td class="price-tag">Rs. ${bill.totalAmount}</td>
                        <td style="font-size: 0.9rem;">${bill.orderDate}</td>
                        <td><span class="status-paid">Completed</span></td>
                    </tr>
                </c:forEach>
                
                <%-- Shown if no bills are found --%>
                <c:if test="${empty billList}">
                    <tr>
                        <td colspan="5" style="text-align:center; padding: 50px; color: #8D6E63;">
                            No billing records found.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

</body>
</html>