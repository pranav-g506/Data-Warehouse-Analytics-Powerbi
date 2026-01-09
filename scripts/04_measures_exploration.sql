/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

USE DATABASEWAREHOUS;

-- Calculate total sales amount 
SELECT SUM(sales_amount) AS total_sales
FROM fact_sales;

-- -- Calculate total quantity of items sold
SELECT SUM(quantity) AS total_quantity 
FROM fact_sales;

-- Calculate average selling price
SELECT AVG(price) AS avg_price
FROM fact_sales;

-- Count total number of unique orders
SELECT COUNT(DISTINCT order_number) AS total_orders 
FROM fact_sales;

-- Count total number of products
SELECT COUNT(product_key) AS total_products
FROM fact_sales;

-- Count total number of customer 
SELECT COUNT(customer_key) AS total_customers
FROM dim_customers;

-- Count total number of customer who have placed at least one order 
SELECT COUNT(DISTINCT customer_key) AS ordering_customers
FROM fact_sales;

-- Check minimum and maximum values of key measures 
SELECT 
     MIN(sales_amount) AS min_sales,
     MAX(sales_amount) AS max_sales,
     MIN(quantity) AS min_quantity,
     MAX(quantity) AS max_quantity,
     MIN(price) AS min_price,
     MAX(price) AS max_price
FROM fact_sales;

-- Identify record with invalid (zero or negative) measures values 
SELECT COUNT(*) AS invalid_measure_records
FROM fact_sales
WHERE sales_amount <= 0
	  OR quantity <= 0
      OR price <= 0;
      
-- Valid sales amount calculation logic 
SELECT COUNT(*) AS incosistent_sales_records
FROM fact_sales
WHERE sales_amount <> quantity * price;

-- Explore cost range of product 
SELECT 
     MIN(cost) AS min_cost,
     MAX(cost) AS max_cost,
     AVG(cost) AS avg_cost
FROM dim_products;


-- Summary report of key business measures
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value
FROM fact_sales

UNION ALL
SELECT 'Total Quantity Sold', SUM(quantity)
FROM fact_sales

UNION ALL
SELECT 'Average Selling Price', AVG(price)
FROM fact_sales

UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number)
FROM fact_sales

UNION ALL
SELECT 'Total Products', COUNT(product_key)
FROM dim_products

UNION ALL
SELECT 'Total Customers', COUNT(customer_key)
FROM dim_customers

UNION ALL
SELECT 'Customers Who Placed Orders', COUNT(DISTINCT customer_key)
FROM fact_sales

UNION ALL
SELECT 'Minimum Sales Amount', MIN(sales_amount)
FROM fact_sales

UNION ALL
SELECT 'Maximum Sales Amount', MAX(sales_amount)
FROM fact_sales

UNION ALL
SELECT 'Invalid Measure Records (≤ 0)',
       COUNT(*)
FROM fact_sales
WHERE sales_amount <= 0
   OR quantity <= 0
   OR price <= 0

UNION ALL
SELECT 'Inconsistent Sales Records',
       COUNT(*)
FROM fact_sales
WHERE sales_amount <> quantity * price;
