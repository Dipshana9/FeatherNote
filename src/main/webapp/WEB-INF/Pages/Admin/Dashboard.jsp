<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Gokyo Bistro</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-logo">
                <i class="fas fa-utensils"></i>
                <span>Gokyo Bistro Admin</span>
            </div>
            <ul class="nav-menu">
                <li><a href="admin-dashboard.html" class="active">Dashboard</a></li>
                <li><a href="menu-management.html">Menu</a></li>
                <li><a href="reservations.html">Reservations</a></li>
                <li><a href="orders.html">Orders</a></li>
                <li><a href="offers-management.html">Offers</a></li>
            </ul>
            <div class="nav-actions">
                <span class="admin-name">Admin</span>
                <button class="btn btn-outline" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </div>
        </div>
    </nav>

    <!-- Admin Dashboard Content -->
    <section class="admin-dashboard">
        <div class="container">
            <h1>Admin Dashboard</h1>
            <p>Manage restaurant operations and view analytics</p>
            
            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Today's Reservations</h3>
                        <p class="stat-number">12</p>
                        <span class="stat-change positive">+3 from yesterday</span>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-bag"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Today's Orders</h3>
                        <p class="stat-number">28</p>
                        <span class="stat-change positive">+5 from yesterday</span>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Today's Revenue</h3>
                        <p class="stat-number">Rs. 45,280</p>
                        <span class="stat-change positive">+12% from yesterday</span>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-info">
                        <h3>Total Members</h3>
                        <p class="stat-number">342</p>
                        <span class="stat-change positive">+8 this week</span>
                    </div>
                </div>
            </div>
            
            <!-- Charts Section -->
            <div class="charts-section">
                <div class="chart-container">
                    <div class="chart-header">
                        <h2>Revenue Overview</h2>
                        <div class="chart-controls">
                            <select id="revenuePeriod" onchange="updateRevenueChart()">
                                <option value="week">Last 7 Days</option>
                                <option value="month">Last 30 Days</option>
                                <option value="year">Last Year</option>
                            </select>
                        </div>
                    </div>
                    <div class="chart-content">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
                
                <div class="chart-container">
                    <div class="chart-header">
                        <h2>Popular Menu Items</h2>
                        <button class="btn btn-primary" onclick="generateMenuReport()">
                            <i class="fas fa-download"></i> Generate Report
                        </button>
                    </div>
                    <div class="chart-content">
                        <canvas id="menuChart"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- Recent Activities -->
            <div class="activities-section">
                <h2>Recent Activities</h2>
                <div class="activities-list">
                    <div class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <div class="activity-details">
                            <p><strong>New Reservation</strong> - Table 5 for 4 guests at 7:00 PM</p>
                            <span class="activity-time">5 minutes ago</span>
                        </div>
                    </div>
                    
                    <div class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-receipt"></i>
                        </div>
                        <div class="activity-details">
                            <p><strong>Order Completed</strong> - Order #1234 for Rs. 2,450</p>
                            <span class="activity-time">15 minutes ago</span>
                        </div>
                    </div>
                    
                    <div class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div class="activity-details">
                            <p><strong>New Member Registration</strong> - John Doe joined as premium member</p>
                            <span class="activity-time">1 hour ago</span>
                        </div>
                    </div>
                    
                    <div class="activity-item">
                        <div class="activity-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="activity-details">
                            <p><strong>New Review</strong> - 5-star rating for Table 8 experience</p>
                            <span class="activity-time">2 hours ago</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Quick Actions -->
            <div class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="actions-grid">
                    <button class="action-card" onclick="window.location.href='menu-management.html'">
                        <i class="fas fa-utensils"></i>
                        <h3>Manage Menu</h3>
                        <p>Add, edit, or remove menu items</p>
                    </button>
                    
                    <button class="action-card" onclick="window.location.href='reservations.html'">
                        <i class="fas fa-calendar-alt"></i>
                        <h3>View Reservations</h3>
                        <p>Manage all table reservations</p>
                    </button>
                    
                    <button class="action-card" onclick="window.location.href='orders.html'">
                        <i class="fas fa-shopping-cart"></i>
                        <h3>Manage Orders</h3>
                        <p>Track and manage food orders</p>
                    </button>
                    
                    <button class="action-card" onclick="window.location.href='offers-management.html'">
                        <i class="fas fa-tags"></i>
                        <h3>Manage Offers</h3>
                        <p>Create and manage special offers</p>
                    </button>
                    
                    <button class="action-card" onclick="generateFinancialReport()">
                        <i class="fas fa-file-invoice-dollar"></i>
                        <h3>Financial Report</h3>
                        <p>Generate detailed financial reports</p>
                    </button>
                    
                    <button class="action-card" onclick="generateRevenuePrediction()">
                        <i class="fas fa-chart-line"></i>
                        <h3>Revenue Prediction</h3>
                        <p>Predict future revenue trends</p>
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Report Modal -->
    <div id="reportModal" class="modal">
        <div class="modal-content modal-large">
            <span class="close" onclick="closeModal('reportModal')">&times;</span>
            <h2 id="reportTitle">Report</h2>
            <div id="reportContent"></div>
            <div class="modal-actions">
                <button class="btn btn-primary" onclick="downloadReport()">
                    <i class="fas fa-download"></i> Download PDF
                </button>
                <button class="btn btn-outline" onclick="closeModal('reportModal')">Close</button>
            </div>
        </div>
    </div>

    <script src="script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Initialize charts when page loads
        document.addEventListener('DOMContentLoaded', function() {
            initializeRevenueChart();
            initializeMenuChart();
        });
        
        function initializeRevenueChart() {
            const ctx = document.getElementById('revenueChart').getContext('2d');
            window.revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                    datasets: [{
                        label: 'Revenue',
                        data: [32000, 35000, 28000, 42000, 45000, 52000, 48000],
                        borderColor: '#667eea',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return 'Rs. ' + value.toLocaleString();
                                }
                            }
                        }
                    }
                }
            });
        }
        
        function initializeMenuChart() {
            const ctx = document.getElementById('menuChart').getContext('2d');
            window.menuChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Momo', 'Chowmein', 'Thakali Set', 'Coffee', 'Wine', 'Whiskey'],
                    datasets: [{
                        label: 'Orders',
                        data: [45, 38, 32, 28, 15, 12],
                        backgroundColor: [
                            '#ff6b6b',
                            '#667eea',
                            '#f093fb',
                            '#4ecdc4',
                            '#45b7d1',
                            '#f9ca24'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }
        
        function updateRevenueChart() {
            const period = document.getElementById('revenuePeriod').value;
            let labels, data;
            
            switch(period) {
                case 'week':
                    labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                    data = [32000, 35000, 28000, 42000, 45000, 52000, 48000];
                    break;
                case 'month':
                    labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];
                    data = [220000, 245000, 280000, 265000];
                    break;
                case 'year':
                    labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                    data = [850000, 920000, 880000, 950000, 1020000, 1100000, 1150000, 1080000, 980000, 1050000, 1120000, 1200000];
                    break;
            }
            
            window.revenueChart.data.labels = labels;
            window.revenueChart.data.datasets[0].data = data;
            window.revenueChart.update();
        }
        
        function generateFinancialReport() {
            const reportContent = `
                <div class="report-section">
                    <h3>Financial Summary - Last 30 Days</h3>
                    <div class="financial-stats">
                        <div class="financial-stat">
                            <h4>Total Revenue</h4>
                            <p>Rs. 1,010,000</p>
                        </div>
                        <div class="financial-stat">
                            <h4>Total Orders</h4>
                            <p>856</p>
                        </div>
                        <div class="financial-stat">
                            <h4>Average Order Value</h4>
                            <p>Rs. 1,179</p>
                        </div>
                        <div class="financial-stat">
                            <h4>Advance Payments</h4>
                            <p>Rs. 144,000</p>
                        </div>
                    </div>
                    
                    <h4>Revenue Breakdown</h4>
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th>Category</th>
                                <th>Revenue</th>
                                <th>Orders</th>
                                <th>Avg. Value</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Dine-in</td>
                                <td>Rs. 680,000</td>
                                <td>420</td>
                                <td>Rs. 1,619</td>
                            </tr>
                            <tr>
                                <td>Delivery</td>
                                <td>Rs. 330,000</td>
                                <td>436</td>
                                <td>Rs. 757</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            `;
            
            document.getElementById('reportTitle').textContent = 'Financial Report';
            document.getElementById('reportContent').innerHTML = reportContent;
            document.getElementById('reportModal').style.display = 'block';
        }
        
        function generateMenuReport() {
            const reportContent = `
                <div class="report-section">
                    <h3>Menu Performance Report - Last 30 Days</h3>
                    <div class="menu-recommendations">
                        <h4>Top Performing Items</h4>
                        <ol>
                            <li>Momo (45 orders) - Consider adding variety</li>
                            <li>Chicken Chowmein (38 orders) - Popular lunch item</li>
                            <li>Thakali Set (32 orders) - Premium offering</li>
                        </ol>
                        
                        <h4>Recommendations</h4>
                        <ul>
                            <li>Add more momo varieties (veg, chicken, buff)</li>
                            <li>Create combo meals with Chowmein</li>
                            <li>Promote Thakali Set during weekends</li>
                            <li>Introduce seasonal beverages</li>
                        </ul>
                    </div>
                    
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th>Menu Item</th>
                                <th>Orders</th>
                                <th>Revenue</th>
                                <th>Rating</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Momo</td>
                                <td>45</td>
                                <td>Rs. 6,750</td>
                                <td>4.8⭐</td>
                            </tr>
                            <tr>
                                <td>Chicken Chowmein</td>
                                <td>38</td>
                                <td>Rs. 9,500</td>
                                <td>4.6⭐</td>
                            </tr>
                            <tr>
                                <td>Thakali Set</td>
                                <td>32</td>
                                <td>Rs. 14,400</td>
                                <td>4.9⭐</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            `;
            
            document.getElementById('reportTitle').textContent = 'Menu Performance Report';
            document.getElementById('reportContent').innerHTML = reportContent;
            document.getElementById('reportModal').style.display = 'block';
        }
        
        function generateRevenuePrediction() {
            const reportContent = `
                <div class="report-section">
                    <h3>Revenue Prediction Analysis</h3>
                    <div class="prediction-summary">
                        <h4>Next Quarter Prediction</h4>
                        <div class="prediction-card">
                            <h5>Predicted Revenue: Rs. 3,250,000</h5>
                            <p>Based on current trends and historical data</p>
                        </div>
                        
                        <h4>Growth Factors</h4>
                        <ul>
                            <li>Seasonal increase in tourism (+15%)</li>
                            <li>Weekend specials driving higher spend (+8%)</li>
                            <li>Member loyalty program (+12%)</li>
                        </ul>
                        
                        <h4>Risk Factors</h4>
                        <ul>
                            <li>Competition from new restaurants (-5%)</li>
                            <li>Seasonal slowdown during monsoon (-8%)</li>
                        </ul>
                        
                        <h4>Recommended Actions</h4>
                        <ul>
                            <li>Launch summer special menu</li>
                            <li>Increase digital marketing spend</li>
                            <li>Introduce happy hour promotions</li>
                            <li>Expand delivery partnerships</li>
                        </ul>
                    </div>
                </div>
            `;
            
            document.getElementById('reportTitle').textContent = 'Revenue Prediction Report';
            document.getElementById('reportContent').innerHTML = reportContent;
            document.getElementById('reportModal').style.display = 'block';
        }
        
        function downloadReport() {
            // In a real application, this would generate and download a PDF
            showMessage('Report downloaded successfully!', 'success');
        }
    </script>
</body>
</html>
