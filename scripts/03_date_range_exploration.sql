USE DATABASEWAREHOUS;

/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Explore the date range of customer creation
SELECT 
     MIN(CREATE_DATE) AS EARLIEST_CUSTOMER_DATE,
     MAX(CREATE_DATE) AS LATEST_CUSTOMER_DATE
FROM dim_customers;

-- Check birthdate range of customers
SELECT
     MIN(BIRTHDATE) AS OLDEST_BIRTHDATE,
     MAX(BIRTHDATE) AS YOUNGEST_BIRTHDATE
FROM dim_customers;
     
-- Explore product availability timeline
SELECT
    MIN(start_date) AS earliest_product_start,
    MAX(start_date) AS latest_product_start
FROM dim_products;

-- Explore sales order date range
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM fact_sales;


-- Explore shipping date range
SELECT
    MIN(shipping_date) AS first_shipping_date,
    MAX(shipping_date) AS last_shipping_date
FROM fact_sales;


-- Explore due date range for orders
SELECT
    MIN(due_date) AS earliest_due_date,
    MAX(due_date) AS latest_due_date
FROM fact_sales;

-- Check for orders shipped before order date
SELECT COUNT(*) AS invalid_shipping_dates
FROM fact_sales
WHERE shipping_date < order_date;

-- Combined view of all sales-related date ranges
SELECT
    MIN(order_date)    AS min_order_date,
    MAX(order_date)    AS max_order_date,
    MIN(shipping_date) AS min_shipping_date,
    MAX(shipping_date) AS max_shipping_date,
    MIN(due_date)      AS min_due_date,
    MAX(due_date)      AS max_due_date
FROM fact_sales;
