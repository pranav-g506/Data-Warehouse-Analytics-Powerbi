USE DATABASEWAREHOUS;

/*
===============================================================================
Database Exploration (MySQL)
===============================================================================
Purpose:
    - Explore the structure of the database
    - List all tables available in the current database
    - Inspect column details for a specific table

System Tables Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/


/* =========================================================
   1. List all tables in the current database
   ========================================================= */
   
SELECT 
	TABLE_SCHEMA,
	TABLE_NAME,
	TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'DATABASEWAREHOUS';

/* =========================================================
   2. View column details of dim_customers, dim_products, fact_sales tables
   ========================================================= */
   
SELECT
	COLUMN_NAME,
	DATA_TYPE,
	IS_NULLABLE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'DATABASEWAREHOUS'
AND TABLE_NAME IN ('dim_customers', 'dim_products', 'fact_sales');

/* =========================================================
   3. Display all tables, columns, and their data types in the DATABASEWAREHOUS database
   ========================================================= */
   
SELECT 
	TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'DATABASEWAREHOUS';
