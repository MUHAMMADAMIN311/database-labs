-- ============================================================
-- Lab 03: Advanced SQL Aggregations & Analytics
-- Author: MUHAMMAD_AMIN
-- Date: 28/02/2026
-- ============================================================

-- Query 1: Overall Business Summary
SELECT 
-- Query 2: Revenue by Product Category (Refined)
SELECT 
    p.category,
    COUNT(DISTINCT oi.order_id) AS orders_containing,
    SUM(oi.unit_price * oi.quantity) AS category_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;    COUNT(order_id) AS total_orders,
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
-- ============================================================
-- Advanced Analytics: Queries 8, 9, and 10
-- ============================================================

-- Query 8: High-Value Session Analysis (Subquery)
-- Objective: Find sessions where pages viewed is above the overall average.
SELECT session_id, customer_id, pages_viewed, device
FROM user_sessions
WHERE pages_viewed > (SELECT AVG(pages_viewed) FROM user_sessions);

-- Query 9: Customer Conversion Status (CTE)
-- Objective: Categorize customers based on their session activity.
WITH SessionSummary AS (
    SELECT customer_id, 
           COUNT(*) as total_sessions,
           SUM(CASE WHEN converted THEN 1 ELSE 0 END) as total_conversions
    FROM user_sessions
    GROUP BY customer_id
)
SELECT customer_id, total_sessions,
       CASE 
           WHEN total_conversions > 0 THEN 'Converted'
           ELSE 'Browser Only'
       END as customer_status
FROM SessionSummary;

-- Query 10: Top Selling Product by Category (Window Function)
-- Objective: Identify the #1 product in each category.
SELECT category, product_name, category_revenue
FROM (
    SELECT p.category, p.product_name,
           SUM(oi.unit_price * oi.quantity) as category_revenue,
           RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.unit_price * oi.quantity) DESC) as rank
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_name
) ranked_products
WHERE rank = 1;
