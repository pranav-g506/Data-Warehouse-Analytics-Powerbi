/*
===============================================================================
Data Segmentation
===============================================================================
Purpose:
    - Segment customers and products into meaningful groups
    - Support targeted analysis, marketing, and business decisions
    - Classify entities based on behavior, value, and activity

Tables Used:
    - fact_sales
    - dim_customers
    - dim_products

SQL Concepts Used:
    - Aggregations: SUM(), COUNT(), AVG()
    - CASE statements
    - GROUP BY
===============================================================================
*/

USE DATABASEWAREHOUS;
/* =========================================================
   1. Customer Segmentation by Revenue (Value-Based)
   ========================================================= */

-- Segment customers based on total revenue contribution
SELECT
    customer_key,
    SUM(sales_amount) AS total_revenue,
    CASE
        WHEN SUM(sales_amount) >= 50000 THEN 'High Value'
        WHEN SUM(sales_amount) BETWEEN 20000 AND 49999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS revenue_segment
FROM fact_sales
GROUP BY customer_key;


/* =========================================================
   2. Customer Segmentation by Order Frequency
   ========================================================= */

-- Segment customers based on number of orders placed
SELECT
    customer_key,
    COUNT(DISTINCT order_number) AS total_orders,
    CASE
        WHEN COUNT(DISTINCT order_number) = 1 THEN 'One-Time Customer'
        WHEN COUNT(DISTINCT order_number) BETWEEN 2 AND 5 THEN 'Repeat Customer'
        ELSE 'Loyal Customer'
    END AS order_frequency_segment
FROM fact_sales
GROUP BY customer_key;


/* =========================================================
   3. Customer Segmentation by Average Order Value
   ========================================================= */

-- Segment customers based on average order value
SELECT
    customer_key,
    AVG(order_value) AS avg_order_value,
    CASE
        WHEN AVG(order_value) >= 10000 THEN 'High AOV'
        WHEN AVG(order_value) BETWEEN 4000 AND 9999 THEN 'Medium AOV'
        ELSE 'Low AOV'
    END AS aov_segment
FROM (
    SELECT
        customer_key,
        order_number,
        SUM(sales_amount) AS order_value
    FROM fact_sales
    GROUP BY customer_key, order_number
) customer_orders
GROUP BY customer_key;


/* =========================================================
   4. Product Segmentation by Revenue
   ========================================================= */

-- Segment products based on revenue contribution
SELECT
    p.product_name,
    SUM(f.sales_amount) AS total_revenue,
    CASE
        WHEN SUM(f.sales_amount) >= 30000 THEN 'Top Product'
        WHEN SUM(f.sales_amount) BETWEEN 10000 AND 29999 THEN 'Mid Product'
        ELSE 'Low Product'
    END AS product_revenue_segment
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name;


/* =========================================================
   5. Product Segmentation by Quantity Sold
   ========================================================= */

-- Segment products based on quantity sold
SELECT
    p.product_name,
    SUM(f.quantity) AS total_quantity_sold,
    CASE
        WHEN SUM(f.quantity) >= 1000 THEN 'High Volume'
        WHEN SUM(f.quantity) BETWEEN 300 AND 999 THEN 'Medium Volume'
        ELSE 'Low Volume'
    END AS quantity_segment
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name;


/* =========================================================
   6. Geographic Customer Segmentation
   ========================================================= */

-- Segment countries based on total revenue contribution
SELECT
    c.country,
    SUM(f.sales_amount) AS total_revenue,
    CASE
        WHEN SUM(f.sales_amount) >= 100000 THEN 'High Revenue Market'
        WHEN SUM(f.sales_amount) BETWEEN 40000 AND 99999 THEN 'Medium Revenue Market'
        ELSE 'Low Revenue Market'
    END AS country_segment
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country;
