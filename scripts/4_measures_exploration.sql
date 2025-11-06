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

SELECT *
FROM gold.fact_sales;

-- Total and Average of sales, quantity, price.
SELECT
    SUM(sales_amount) AS total_sales,
    AVG(sales_amount) AS avg_sales,
    SUM(quantity) AS total_quantity,
    AVG(quantity) AS avg_quantity,
    SUM(price) AS toatl_price,
    AVG(price) AS avg_price
FROM gold.fact_sales;

-- Total number of customers
SELECT COUNT(DISTINCT customer_id) AS number_of_customers FROM gold.dim_customers;

-- Total number of unique products
SELECT COUNT(DISTINCT product_id) AS number_of_products FROM gold.dim_products;

-- Number of orders placed
SELECT COUNT(DISTINCT order_number) AS number_of_orders FROM gold.fact_sales;

-- Total number of customers who placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;
