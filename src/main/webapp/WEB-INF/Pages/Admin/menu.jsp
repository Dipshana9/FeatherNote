<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Management | FeatherNote</title>
   <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Admin/menu.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

    <nav class="sidebar">
        <div class="sidebar-header">
            <i class="fa-solid fa-cloud-moon"></i>
            <span>FeatherNote</span>
        </div>
        <ul>
            <li>
                <a href="dashboard.jsp">
                    <i class="fa-solid fa-wand-magic-sparkles"></i> Dashboard
                </a>
            </li>
            <li class="active">
                <a href="menu.jsp">
                    <i class="fa-solid fa-utensils"></i> Menu
                </a>
            </li>
            <li><a href="bookings.jsp"><i class="fa-solid fa-calendar-alt"></i> Bookings</a></li>
            <li><a href="orders.jsp"><i class="fa-solid fa-receipt"></i> Orders</a></li>
            <li><a href="customers.jsp"><i class="fa-solid fa-users"></i> Customers</a></li>
        </ul>
    </nav>

    <main class="main-content">
        <header class="topbar">
            <div>
                <h1>The Grimoire</h1>
                <p>Manage your menu offerings and enchantments (discounts).</p>
            </div>
            <div class="user-profile">
                <i class="fa-solid fa-circle-user"></i>
            </div>
        </header>

        <section class="form-section">
            <div class="content-card">
                <h3>Add New Dish</h3>
                <form action="AddMenuController" method="POST" class="noir-form">
                    <div class="input-row">
                        <input type="text" name="itemName" placeholder="Dish Name" required>
                        <input type="number" name="price" placeholder="Price (Rs.)" required>
                        <input type="number" name="discount" placeholder="Discount %">
                        <select name="category">
                            <option value="Starter">Starter</option>
                            <option value="Main Course">Main Course</option>
                            <option value="Dessert">Dessert</option>
                        </select>
                        <button type="submit" class="glow-btn">Add Item</button>
                    </div>
                </form>
            </div>
        </section>

        <section class="table-container">
            <div class="table-header">
                <h3>Current Offerings</h3>
            </div>
            
            <table class="dashboard-table">
                <thead>
                    <tr>
                        <th>Item Name</th>
                        <th>Category</th>
                        <th>Base Price</th>
                        <th>Discount</th>
                        <th>Final Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="primary-text">Midnight Truffle Pasta</td>
                        <td>Main Course</td>
                        <td>Rs. 450</td>
                        <td><span class="badge discount">10%</span></td>
                        <td class="price-highlight">Rs. 405</td>
                        <td>
                            <div class="action-icons">
                                <button class="icon-btn edit"><i class="fa-solid fa-pen-to-square"></i></button>
                                <button class="icon-btn delete"><i class="fa-solid fa-trash-can"></i></button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>
    </main>

</body>
</html>