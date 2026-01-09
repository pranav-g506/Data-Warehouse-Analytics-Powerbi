/*
===============================================================================
Exploratory Data Analysis (EDA)
===============================================================================
Purpose:
    - Explore data distributions, patterns, and relationships
    - Identify anomalies and outliers
    - Understand customer, product, and sales behavior
    - Prepare the data for final analytics and insights

Tables Used:
    - fact_sales
    - dim_customers
    - dim_products

SQL Concepts Used:
    - Aggregations: SUM(), COUNT(), AVG(), MIN(), MAX()
    - GROUP BY, ORDER BY
    - JOINs
===============================================================================
*/

USE DATABASEWAREHOUS;

/* =========================================================
   1. Overall Sales Distribution
   ========================================================= */

-- Explore basic distribution of sales amount
SELECT
    MIN(sales_amount) AS min_sales,
    MAX(sales_amount) AS max_sales,
    AVG(sales_amount) AS avg_sales
FROM fact_sales;


/* =========================================================
   2. Quantity Distribution
   ========================================================= */

-- Analyze how frequently different quantities are sold
SELECT
    quantity,
    COUNT(*) AS frequency
FROM fact_sales
GROUP BY quantity
ORDER BY quantity;


/* =========================================================
   3. Revenue Distribution by Product Category
   ========================================================= */

-- Explore revenue contribution across product categories
SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;


/* =========================================================
   4. Customer Purchasing Behavior
   ========================================================= */

-- Analyze relationship between number of orders and revenue per customer
SELECT
    c.customer_key,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.customer_key;


/* =========================================================
   5. Country-wise Sales Patterns
   ========================================================= */

-- Explore how sales vary across different countries
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
   6. Product Performance Distribution
   ========================================================= */

-- Analyze sales distribution across products
SELECT
    p.product_name,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.quantity) AS total_quantity_sold,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;


/* =========================================================
   7. Order Value Distribution
   ========================================================= */

-- Explore distribution of order values
SELECT
    order_number,
    SUM(sales_amount) AS order_value
FROM fact_sales
GROUP BY order_number
ORDER BY order_value DESC;


/* =========================================================
   8. Identify Potential High-Value Outliers
   ========================================================= */

-- Identify unusually high-value orders (possible outliers)
SELECT
    order_number,
    SUM(sales_amount) AS order_value
FROM fact_sales
GROUP BY order_number
ORDER BY order_value DESC
LIMIT 10;


/* =========================================================
   9. Average Order Value per Customer
   ========================================================= */

-- Explore average order value by customer
SELECT
    c.customer_key,
    AVG(order_totals.order_value) AS avg_order_value
FROM (
    SELECT
        order_number,
        customer_key,
        SUM(sales_amount) AS order_value
    FROM fact_sales
    GROUP BY order_number, customer_key
) order_totals
JOIN dim_customers c
    ON c.customer_key = order_totals.customer_key
GROUP BY c.customer_key;


/* =========================================================
   10. Check for Data Skew (Revenue Concentration)
   ========================================================= */

-- Explore how revenue is concentrated among customers
SELECT
    c.customer_key,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.customer_key
ORDER BY total_revenue DESC;



