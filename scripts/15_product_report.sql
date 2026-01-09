/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - Provide a consolidated, product-level business report
    - Summarize product attributes, sales performance, and demand
    - Support product analysis, inventory planning, and dashboards

Tables Used:
    - dim_products
    - fact_sales

SQL Concepts Used:
    - Aggregations: SUM(), COUNT(), AVG(), MIN(), MAX()
    - CASE statements
    - JOINs
    - GROUP BY
===============================================================================
*/
USE DATABASEWAREHOUS;

/* =========================================================
   1. Product Performance Overview
   ========================================================= */

-- Generate a complete product-level summary
SELECT
    p.product_key,
    p.product_name,
    p.category,
    p.subcategory,
    p.product_line,
    p.cost,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue,
    ROUND(AVG(f.sales_amount), 2) AS avg_sales_per_record
FROM dim_products p
LEFT JOIN fact_sales f
    ON p.product_key = f.product_key
GROUP BY
    p.product_key,
    p.product_name,
    p.category,
    p.subcategory,
    p.product_line,
    p.cost;


/* =========================================================
   2. Product Revenue Classification
   ========================================================= */

-- Classify products based on total revenue contribution
SELECT
    p.product_key,
    p.product_name,
    SUM(f.sales_amount) AS total_revenue,
    CASE
        WHEN SUM(f.sales_amount) >= 50000 THEN 'High Revenue Product'
        WHEN SUM(f.sales_amount) BETWEEN 20000 AND 49999 THEN 'Medium Revenue Product'
        ELSE 'Low Revenue Product'
    END AS revenue_segment
FROM dim_products p
LEFT JOIN fact_sales f
    ON p.product_key = f.product_key
GROUP BY
    p.product_key,
    p.product_name;


/* =========================================================
   3. Product Volume Classification
   ========================================================= */

-- Segment products based on quantity sold
SELECT
    p.product_key,
    p.product_name,
    SUM(f.quantity) AS total_quantity_sold,
    CASE
        WHEN SUM(f.quantity) >= 1000 THEN 'High Volume'
        WHEN SUM(f.quantity) BETWEEN 300 AND 999 THEN 'Medium Volume'
        ELSE 'Low Volume'
    END AS volume_segment
FROM dim_products p
LEFT JOIN fact_sales f
    ON p.product_key = f.product_key
GROUP BY
    p.product_key,
    p.product_name;


/* =========================================================
   4. Product Order Activity
   ========================================================= */

-- Analyze order frequency per product
SELECT
    p.product_key,
    p.product_name,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM dim_products p
LEFT JOIN fact_sales f
    ON p.product_key = f.product_key
GROUP BY
    p.product_key,
    p.product_name
ORDER BY total_orders DESC;


/* =========================================================
   5. Product Lifecycle Insight
   ========================================================= */

-- Review product introduction timeline
SELECT
    product_key,
    product_name,
    category,
    start_date AS product_start_date
FROM dim_products
ORDER BY start_date;


