-- ============================================================
-- Lab 03: Advanced SQL Aggregations & Analytics
-- Author: MUHAMMAD_AMIN
-- Date: 28/02/2026
-- ============================================================

-- Query 1: Overall Business Summary
SELECT 
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM orders;

-- Query 2: Revenue by Product Category (FINAL FIX)
SELECT 
    p.category,
    COUNT(oi.item_id) AS items_sold,
    SUM(oi.unit_price * oi.quantity) AS category_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;
-- Query 3: Monthly Sales Trends
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    COUNT(order_id) AS num_orders,
    SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY month
ORDER BY month;

-- Query 4: Active Cities (Filtering with HAVING)
-- Shows cities with more than 2 orders
SELECT c.city,
       COUNT(DISTINCT c.customer_id) AS customers,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING COUNT(o.order_id) > 2
ORDER BY total_orders DESC;

-- Query 5: Device Performance Analysis
-- Analyzes user behavior by device type
SELECT device,
       COUNT(*) AS total_sessions,
       ROUND(AVG(duration_mins), 2) AS avg_duration,
       SUM(CASE WHEN converted THEN 1 ELSE 0 END) AS conversions,
       ROUND(100.0 * SUM(CASE WHEN converted THEN 1 ELSE 0 END) / COUNT(*), 1) AS conv_rate
FROM user_sessions
GROUP BY device
HAVING COUNT(*) >= 5;
-- ============================================================
-- Window Functions & Advanced Analytics
-- ============================================================

-- Query 6: Ranking Customers by Spending
-- Objective: Rank customers from highest to lowest spender based on their orders.
SELECT 
    customer_id, 
    total_amount,
    RANK() OVER (ORDER BY total_amount DESC) as spend_rank,
    ROW_NUMBER() OVER (ORDER BY total_amount DESC) as row_num
FROM orders;

-- Query 7: Month-over-Month Comparison (LAG)
-- Objective: Compare current monthly revenue with the previous month.
WITH MonthlySales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        SUM(total_amount) AS revenue
    FROM orders
    GROUP BY 1
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) as prev_month_revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) as revenue_diff
FROM MonthlySales;
