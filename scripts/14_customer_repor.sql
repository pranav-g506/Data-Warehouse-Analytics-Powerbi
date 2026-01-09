/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - Provide a consolidated, customer-level business report
    - Summarize customer demographics, activity, and value
    - Support CRM analysis, customer profiling, and dashboard reporting

Tables Used:
    - dim_customers
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
   1. Customer Overview Report
   ========================================================= */

-- Generate a complete customer-level summary
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    c.gender,
    c.country,
    c.marital_status,
    c.create_date AS customer_since,
    COUNT(DISTINCT f.order_number) AS total_orders,
    SUM(f.quantity) AS total_items_purchased,
    SUM(f.sales_amount) AS total_revenue,
    ROUND(AVG(f.sales_amount), 2) AS avg_sales_per_record
FROM dim_customers c
LEFT JOIN fact_sales f
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name,
    c.gender,
    c.country,
    c.marital_status,
    c.create_date;


/* =========================================================
   2. Customer Lifetime Value (CLV Proxy)
   ========================================================= */

-- Estimate customer lifetime value using total revenue
SELECT
    customer_key,
    SUM(sales_amount) AS lifetime_value
FROM fact_sales
GROUP BY customer_key
ORDER BY lifetime_value DESC;


/* =========================================================
   3. Customer Activity Classification
   ========================================================= */

-- Classify customers based on order frequency
SELECT
    c.customer_key,
    COUNT(DISTINCT f.order_number) AS total_orders,
    CASE
        WHEN COUNT(DISTINCT f.order_number) = 0 THEN 'Inactive'
        WHEN COUNT(DISTINCT f.order_number) = 1 THEN 'One-Time'
        WHEN COUNT(DISTINCT f.order_number) BETWEEN 2 AND 5 THEN 'Repeat'
        ELSE 'Loyal'
    END AS customer_activity_segment
FROM dim_customers c
LEFT JOIN fact_sales f
    ON c.customer_key = f.customer_key
GROUP BY c.customer_key;


/* =========================================================
   4. Average Order Value (AOV) per Customer
   ========================================================= */

-- Calculate average order value for each customer
SELECT
    customer_key,
    ROUND(AVG(order_value), 2) AS avg_order_value
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
   5. First and Most Recent Purchase Dates
   ========================================================= */

-- Track customer purchase timeline
SELECT
    customer_key,
    MIN(order_date) AS first_purchase_date,
    MAX(order_date) AS latest_purchase_date
FROM fact_sales
GROUP BY customer_key;
