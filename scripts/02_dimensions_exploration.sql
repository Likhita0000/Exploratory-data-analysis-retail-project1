
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
-- helps in grouping data
SELECT DISTINCT country
FROM gold.dim_customers;

SELECT DISTINCT marital_status
FROM gold.dim_customers;

SELECT DISTINCT gender
FROM gold.dim_customers;

SELECT DISTINCT 
    category,
    subcategory,
    product_name,
    CASE WHEN category IS NULL THEN 1 ELSE 0 END AS check_null,
    CASE WHEN subcategory IS NULL THEN 1 ELSE 0 END AS check_null
FROM gold.dim_products
ORDER BY 
    CASE WHEN category IS NULL THEN 1 ELSE 0 END,   -- NULLs last for category
    category,
    CASE WHEN subcategory IS NULL THEN 1 ELSE 0 END, -- NULLs last for subcategory
    subcategory,
    product_name;
