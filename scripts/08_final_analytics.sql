/*
===============================================================================
Final Analytics
===============================================================================
Purpose:
    - Generate business-level insights and KPIs
    - Support dashboarding and decision-making
    - Answer key business questions using clean, structured queries

Tables Used:
    - fact_sales
    - dim_customers
    - dim_products

SQL Concepts Used:
    - Aggregations (SUM, COUNT, AVG)
    - JOINs
    - GROUP BY, ORDER BY
    - Window Functions (RANK)
===============================================================================
*/

USE DATABASEWAREHOUS;

/* =========================================================
   1. Overall Business KPIs
   ========================================================= */

-- High-level business performance metrics
SELECT 'Total Sales' AS metric, SUM(sales_amount) AS value FROM fact_sales
UNION ALL
SELECT 'Total Quantity Sold', SUM(quantity) FROM fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM fact_sales
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM dim_customers
UNION ALL
SELECT 'Active Customers', COUNT(DISTINCT customer_key) FROM fact_sales;


/* =========================================================
   2. Revenue Contribution by Product Category
   ========================================================= */

-- Identify top-performing product categories
SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;


/* =========================================================
   3. Top 10 Products by Revenue
   ========================================================= */

-- Identify products generating the highest revenue
SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


/* =========================================================
   4. Top 10 Customers by Revenue
   ========================================================= */

-- Identify highest-value customers
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC
LIMIT 10;


/* =========================================================
   5. Customer Segmentation by Order Activity
   ========================================================= */

-- Classify customers based on number of orders
SELECT
    customer_key,
    COUNT(DISTINCT order_number) AS total_orders,
    CASE
        WHEN COUNT(DISTINCT order_number) = 1 THEN 'One-time Customer'
        WHEN COUNT(DISTINCT order_number) BETWEEN 2 AND 5 THEN 'Repeat Customer'
        ELSE 'Loyal Customer'
    END AS customer_segment
FROM fact_sales
GROUP BY customer_key;


/* =========================================================
   6. Geographic Performance Analysis
   ========================================================= */

-- Analyze revenue and orders by country
SELECT
    c.country,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_revenue DESC;


/* =========================================================
   7. Average Order Value (AOV)
   ========================================================= */

-- Calculate average order value
SELECT
    AVG(order_value) AS avg_order_value
FROM (
    SELECT
        order_number,
        SUM(sales_amount) AS order_value
    FROM fact_sales
    GROUP BY order_number
) order_totals;


/* =========================================================
   8. Product Profitability Proxy (Revenue vs Cost)
   ========================================================= */

-- Compare revenue against product cost (proxy profitability)
SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue,
    AVG(p.cost) AS avg_cost
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;


/* =========================================================
   9. Revenue Concentration (Top Customers Impact)
   ========================================================= */

-- Rank customers based on revenue contribution
SELECT
    c.customer_key,
    SUM(f.sales_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS revenue_rank
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.customer_key;


/* =========================================================
   10. Sales Volume vs Value Analysis
   ========================================================= */

-- Compare quantity sold vs revenue by product category
SELECT
    p.category,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;
