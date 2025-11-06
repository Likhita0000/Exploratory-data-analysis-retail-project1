/*
Exploratory Data Analysis

*/

-- Data exploration
SELECT *
FROM gold.dim_customers; --This table mostly useful for dimensional exploration

SELECT *
FROM gold.dim_products; --This table gives both dim and measures exploration

SELECT *
FROM gold.fact_sales; -- Both dimension and measures exploration
