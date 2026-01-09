/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - Track trends, growth, and changes in key metrics over time
    - Perform time-series analysis and identify seasonality
    - Measure growth or decline across different periods

SQL Functions Used (MySQL):
    - Date Functions: YEAR(), MONTH(), DATE_FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

USE DATABASEWAREHOUS;

/* =========================================================
   1. Monthly Sales Performance (Year + Month)
   ========================================================= */

-- Analyze sales performance by year and month
SELECT 
      YEAR(order_date) AS order_year,
      MONTH(order_date) AS order_month,
      SUM(sales_amount) AS total_sales,
      COUNT(DISTINCT customer_key) AS total_customers,
      SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
GROUP BY 
       YEAR (order_date),
       MONTH(order_date)
ORDER BY 
       order_year,
       order_month;

/* =========================================================
   2. Monthly Sales Performance (Month Start Date)
   ========================================================= */

-- Aggregate sales using month-level date (MySQL equivalent of DATETRUNC)
SELECT 
     DATE_FORMAT(order_date, '%Y-%M-01') AS order_month,
     SUM(sales_amount) AS total_sales,
     COUNT(DISTINCT customer_key) AS total_customers,
     SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_month
ORDER BY order_month;

/* =========================================================
   3. Formatted Monthly Sales Trend
   ========================================================= */

-- Display monthly sales trend using formatted date
SELECT
     DATE_FORMAT(order_date, '%Y-%b') AS order_month,
     SUM(sales_amount) AS total_sales,
     COUNT(DISTINCT customer_key) AS total_customers,
     SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
GROUP BY order_month 
ORDER BY order_month;

-- Calculate month-over-month sales growth
SELECT
    order_month,
    total_sales,
    total_sales - LAG(total_sales) OVER (ORDER BY order_month) AS sales_change,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY order_month)) /
        LAG(total_sales) OVER (ORDER BY order_month) * 100,
        2
    ) AS sales_growth_percentage
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY order_month
) monthly_sales;


-- Analyze new vs returning customers by month
SELECT
    order_month,
    COUNT(DISTINCT customer_key) AS total_customers,
    COUNT(DISTINCT CASE
        WHEN first_order_month = order_month THEN customer_key
    END) AS new_customers,
    COUNT(DISTINCT CASE
        WHEN first_order_month < order_month THEN customer_key
    END) AS returning_customers
FROM (
    SELECT
        customer_key,
        DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
        MIN(DATE_FORMAT(order_date, '%Y-%m-01'))
            OVER (PARTITION BY customer_key) AS first_order_month
    FROM fact_sales
) customer_orders
GROUP BY order_month
ORDER BY order_month;


