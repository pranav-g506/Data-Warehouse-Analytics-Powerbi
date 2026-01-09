USE DATABASEWAREHOUS;

/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - Explore the structure and categorical values of dimension tables
    - Understand distinct attributes used for grouping and analysis

SQL Clauses Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- List unique countries from the customer dimension
SELECT DISTINCT
    country
FROM dim_customers
ORDER BY country;

-- List unique product categories, subcategories, and product names
SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM dim_products
ORDER BY category, subcategory, product_name;

-- Distribution of products by category
SELECT
    category,
    COUNT(*) AS total_products
FROM dim_products
GROUP BY category
ORDER BY total_products DESC;

-- Analyze product hierarchy by counting products per category and subcategory
SELECT
    category,
    subcategory,
    COUNT(DISTINCT product_name) AS total_products
FROM dim_products
GROUP BY category, subcategory
ORDER BY category, subcategory;


