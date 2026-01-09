/*
===============================================================================
Performance Analysis
===============================================================================
Purpose:
    - Evaluate and compare performance across customers, products, categories,
      and regions
    - Identify high-performing and low-performing entities
    - Support business performance assessment and benchmarking

Tables Used:
    - fact_sales
    - dim_customers
    - dim_products

SQL Concepts Used:
    - Aggregations: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
    - JOINs
===============================================================================
*/

USE DATABASEWAREHOUS;

/* =========================================================
   1. Product Performance Analysis
   ========================================================= */

-- Analyze product performance based on revenue and quantity sold
SELECT
    p.product_name,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue,
    AVG(f.sales_amount) AS avg_sales_per_record
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;


/* =========================================================
   2. Category Performance Comparison
   ========================================================= */

-- Compare performance of product categories
SELECT
    p.category,
    COUNT(DISTINCT p.product_key) AS total_products,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue,
    AVG(f.sales_amount) AS avg_sales
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;


/* =========================================================
   3. Customer Performance Analysis
   ========================================================= */

-- Evaluate customer performance based on orders and revenue
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.sales_amount) AS total_revenue,
    AVG(f.sales_amount) AS avg_sales_per_order
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;


/* =========================================================
   4. Geographic Performance Analysis
   ========================================================= */

-- Analyze performance across countries
SELECT
    c.country,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue,
    AVG(f.sales_amount) AS avg_sales
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_revenue DESC;


/* =========================================================
   5. Order-Level Performance Analysis
   ========================================================= */

-- Evaluate performance of orders based on order value
SELECT
    order_number,
    COUNT(*) AS total_items,
    SUM(quantity) AS total_quantity,
    SUM(sales_amount) AS order_value
FROM fact_sales
GROUP BY order_number
ORDER BY order_value DESC;


/* =========================================================
   6. High vs Low Performing Products (Threshold-Based)
   ========================================================= */

-- Classify products based on average revenue contribution
SELECT
    p.product_name,
    AVG(f.sales_amount) AS avg_sales,
    CASE
        WHEN AVG(f.sales_amount) >= 5000 THEN 'High Performing'
        WHEN AVG(f.sales_amount) BETWEEN 2000 AND 4999 THEN 'Medium Performing'
        ELSE 'Low Performing'
    END AS performance_category
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name;
