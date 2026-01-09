/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - Understand how individual parts contribute to the overall total
    - Measure percentage contribution of categories, products, customers,
      and regions to total sales and volume
    - Support share analysis (used in pie charts & contribution visuals)

Tables Used:
    - fact_sales
    - dim_customers
    - dim_products

SQL Concepts Used:
    - Aggregations: SUM(), COUNT()
    - Subqueries
    - Percentage calculations
    - GROUP BY, ORDER BY
===============================================================================
*/

USE DATABASEWAREHOUS;

/* =========================================================
   1. Revenue Contribution by Product Category
   ========================================================= */

-- Percentage contribution of each product category to total revenue
SELECT
    p.category,
    SUM(f.sales_amount) AS category_revenue,
    ROUND(
        SUM(f.sales_amount) * 100.0 /
        (SELECT SUM(sales_amount) FROM fact_sales),
        2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY revenue_percentage DESC;


/* =========================================================
   2. Revenue Contribution by Product
   ========================================================= */

-- Percentage contribution of each product to total revenue
SELECT
    p.product_name,
    SUM(f.sales_amount) AS product_revenue,
    ROUND(
        SUM(f.sales_amount) * 100.0 /
        (SELECT SUM(sales_amount) FROM fact_sales),
        2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY revenue_percentage DESC;


/* =========================================================
   3. Revenue Contribution by Customer
   ========================================================= */

-- Percentage contribution of each customer to total revenue
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS customer_revenue,
    ROUND(
        SUM(f.sales_amount) * 100.0 /
        (SELECT SUM(sales_amount) FROM fact_sales),
        2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY revenue_percentage DESC;


/* =========================================================
   4. Revenue Contribution by Country
   ========================================================= */

-- Percentage contribution of each country to total revenue
SELECT
    c.country,
    SUM(f.sales_amount) AS country_revenue,
    ROUND(
        SUM(f.sales_amount) * 100.0 /
        (SELECT SUM(sales_amount) FROM fact_sales),
        2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY revenue_percentage DESC;


/* =========================================================
   5. Quantity Contribution by Product Category
   ========================================================= */

-- Percentage contribution of each product category to total quantity sold
SELECT
    p.category,
    SUM(f.quantity) AS category_quantity,
    ROUND(
        SUM(f.quantity) * 100.0 /
        (SELECT SUM(quantity) FROM fact_sales),
        2
    ) AS quantity_percentage
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY quantity_percentage DESC;


/* =========================================================
   6. Top Contributors vs Rest (80/20 Insight)
   ========================================================= */

-- Identify top customers contributing to majority of revenue
SELECT
    c.customer_key,
    SUM(f.sales_amount) AS customer_revenue,
    ROUND(
        SUM(f.sales_amount) * 100.0 /
        (SELECT SUM(sales_amount) FROM fact_sales),
        2
    ) AS revenue_percentage
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.customer_key
ORDER BY revenue_percentage DESC;
