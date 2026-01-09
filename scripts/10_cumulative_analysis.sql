/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - Analyze how key business metrics accumulate over time
    - Understand long-term growth patterns
    - Track running totals for sales, orders, and customers

SQL Functions Used:
    - Window Functions: SUM() OVER(), COUNT() OVER()
    - Date Functions: DATE_FORMAT()
    - Aggregate Functions: SUM(), COUNT()
===============================================================================
*/

USE DATABASEWAREHOUS;
/* =========================================================
   1. Cumulative Sales Over Time
   ========================================================= */

-- Track cumulative sales growth over time
SELECT
    order_date,
    daily_sales,
    SUM(daily_sales) OVER (ORDER BY order_date) AS cumulative_sales
FROM (
    SELECT
        order_date,
        SUM(sales_amount) AS daily_sales
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY order_date
) daily_sales_data
ORDER BY order_date;


/* =========================================================
   2. Cumulative Orders Over Time
   ========================================================= */

-- Track cumulative number of orders over time
SELECT
    order_date,
    daily_orders,
    SUM(daily_orders) OVER (ORDER BY order_date) AS cumulative_orders
FROM (
    SELECT
        order_date,
        COUNT(DISTINCT order_number) AS daily_orders
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY order_date
) daily_order_data
ORDER BY order_date;


/* =========================================================
   3. Cumulative Customers Over Time
   ========================================================= */

-- Track cumulative number of unique customers over time
SELECT
    order_date,
    daily_customers,
    SUM(daily_customers) OVER (ORDER BY order_date) AS cumulative_customers
FROM (
    SELECT
        order_date,
        COUNT(DISTINCT customer_key) AS daily_customers
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY order_date
) daily_customer_data
ORDER BY order_date;


/* =========================================================
   4. Monthly Cumulative Sales Trend
   ========================================================= */

-- Track cumulative sales at monthly level
SELECT
    order_month,
    monthly_sales,
    SUM(monthly_sales) OVER (ORDER BY order_month) AS cumulative_sales
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
        SUM(sales_amount) AS monthly_sales
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY order_month
) monthly_sales_data
ORDER BY order_month;


/* =========================================================
   5. Cumulative Revenue Contribution by Category Over Time
   ========================================================= */

-- Track cumulative revenue contribution of product categories
SELECT
    order_month,
    category,
    monthly_revenue,
    SUM(monthly_revenue) OVER (
        PARTITION BY category
        ORDER BY order_month
    ) AS cumulative_category_revenue
FROM (
    SELECT
        DATE_FORMAT(f.order_date, '%Y-%m-01') AS order_month,
        p.category,
        SUM(f.sales_amount) AS monthly_revenue
    FROM fact_sales f
    JOIN dim_products p
        ON p.product_key = f.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY order_month, p.category
) category_monthly_sales
ORDER BY category, order_month;
