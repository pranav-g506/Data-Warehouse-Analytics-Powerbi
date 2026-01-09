/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - Rank products and customers based on performance metrics
    - Identify top performers and laggards

SQL Functions Used:
    - Window Functions: RANK()
    - Clauses: GROUP BY, ORDER BY, LIMIT
===============================================================================
*/

USE DATABASEWAREHOUS;

-- Top 5 products generating the highest revenue (Simple ranking)
SELECT 
    p.product_name,
    SUM(f.sales_amount) AS total_revenue 
FROM fact_sales f
LEFT JOIN dim_products p 
   ON p.product_key = f.product_key 
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

-- Top 5 products using window ranking (flexible ranking) 
SELECT 
     product_name,
     total_revenue, 
     revenue_rank
from (
      select 
	      p.product_name,
          SUM(f.sales_amount) AS total_revenue,
          RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS revenue_rank 
		FROM fact_sales f
        LEFT JOIN dim_products p 
            ON p.product_key = f.product_key
		GROUP BY p.product_name
        ) ranked_products
        WHERE revenue_rank <= 5;
        
-- Bottom 5 product by total revenue 
SELECT 
   p.product_name,
   SUM(f.sales_amount) AS total_revenue 
FROM fact_sales f
LEFT JOIN  dim_products p
  ON p.product_key = f.product_key
GROUP BY p.product_name 
ORDER BY total_revenue ASC
LIMIT 5;

-- Top 10 customers by total revenue 
SELECT 
  c.customer_key, 
  c.first_name,
  c.last_name,
  SUM(f.sales_amount) AS total_revenue 
FROM fact_sales f
LEFT JOIN dim_customers c
  ON c.customer_key = f.customer_key
GROUP BY 
     c.customer_key,
     c.first_name,
     c.last_name
ORDER BY total_revenue DESC
LIMIT 10;


-- Bottom 3 customers by number of orders placed
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM fact_sales f
LEFT JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_orders ASC
LIMIT 3;

-- Top 5 products by quantity sold
SELECT
    p.product_name,
    SUM(f.quantity) AS total_quantity_sold
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Rank product categories by total revenue
SELECT
    p.category,
    SUM(f.sales_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS category_rank
FROM fact_sales f
JOIN dim_products p
    ON p.product_key = f.product_key
GROUP BY p.category;


-- Top 5 countries by total revenue
SELECT
    c.country,
    SUM(f.sales_amount) AS total_revenue
FROM fact_sales f
JOIN dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY total_revenue DESC
LIMIT 5;


-- Top 5 highest value orders
SELECT
    order_number,
    SUM(sales_amount) AS order_value
FROM fact_sales
GROUP BY order_number
ORDER BY order_value DESC
LIMIT 5;

