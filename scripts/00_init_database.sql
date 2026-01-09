/* =========================================================
   STEP 1: Create Database
   ========================================================= */

-- Create a new database for analytics

CREATE DATABASE DATABASEWAREHOUS;

-- Select the database to work on
use DATABASEWAREHOUS;

/* =========================================================
   STEP 2: Create Dimension & Fact Tables
   ========================================================= */

-- Customer Dimension Table
CREATE TABLE dim_customers (
    customer_key     INT,
    customer_id      INT,
    customer_number  VARCHAR(50),
    first_name       VARCHAR(50),
    last_name        VARCHAR(50),
    country          VARCHAR(50),
    marital_status   VARCHAR(50),
    gender           VARCHAR(50),
    birthdate        DATE,
    create_date      DATE
);

-- Product Dimension Table
CREATE TABLE dim_products (
    product_key     INT,
    product_id      INT,
    product_number  VARCHAR(50),
    product_name    VARCHAR(50),
    category_id     VARCHAR(50),
    category        VARCHAR(50),
    subcategory     VARCHAR(50),
    maintenance     VARCHAR(50),
    cost            INT,
    product_line    VARCHAR(50),
    start_date      DATE
);

-- Sales Fact Table
CREATE TABLE fact_sales (
    order_number   VARCHAR(50),
    product_key    INT,
    customer_key   INT,
    order_date     DATE,
    shipping_date  DATE,
    due_date       DATE,
    sales_amount   INT,
    quantity       SMALLINT,
    price          INT
);

/* =========================================================
   STEP 3: Enable CSV File Import (LOCAL INFILE)
   ========================================================= */

-- Enable CSV loading from local machine (server side)
SET GLOBAL local_infile = 1;

-- Verify if local_infile is enabled
SHOW VARIABLES LIKE 'local_infile';

/* =========================================================
   STEP 4: Load Customer Data from CSV
   ========================================================= */

-- Load data into dim_customers table
LOAD DATA LOCAL INFILE
'C:/Users/ADMIN/Downloads/sql-data-analytics-project-main/sql-data-analytics-project-main/datasets/csv-files/dim_customers.csv'
INTO TABLE dim_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Check how many rows were loaded
SELECT COUNT(*) FROM dim_customers;

-- Check missing birthdates (data quality check)
SELECT COUNT(*) 
FROM dim_customers
WHERE birthdate IS NULL;

/* =========================================================
   STEP 5: Load Product Data from CSV
   ========================================================= */

-- Check table structure before loading
DESC dim_products;

-- Load data into dim_products table
LOAD DATA LOCAL INFILE
'C:/Users/ADMIN/Downloads/sql-data-analytics-project-main/sql-data-analytics-project-main/datasets/csv-files/dim_products.csv'
INTO TABLE dim_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Verify product data
SELECT * FROM dim_products;
SELECT COUNT(*) FROM dim_products;

/* =========================================================
   STEP 6: Load Sales Fact Data from CSV
   ========================================================= */

-- Load data into fact_sales table
LOAD DATA LOCAL INFILE
'C:/Users/ADMIN/Downloads/sql-data-analytics-project-main/sql-data-analytics-project-main/datasets/csv-files/fact_sales.csv'
INTO TABLE fact_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Verify sales records
SELECT COUNT(*) FROM fact_sales;



