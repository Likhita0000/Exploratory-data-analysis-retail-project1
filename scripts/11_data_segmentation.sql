/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

-- DATA Segmentation
 /*Segment products into cost ranges and count how 
 many products fall into each segment*/
WITH product_segment AS (
SELECT 
    product_key,
    product_name,
    cost,
    CASE 
        WHEN cost < 100 THEN 'Below 100'
        WHEN cost BETWEEN 100 AND 500 THEN '100 - 500'
        WHEN cost BETWEEN 500 AND 1000 THEN '500 - 1000'
        ELSE 'ABOVE 100'
    END AS cost_range
FROM gold.dim_products)

SELECT 
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products DESC;

--- VIP cust descr
WITH customer_spending AS (
SELECT
    c.customer_key,
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan,
    SUM(f.sales_amount) AS total_spending
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON f.customer_key = c.customer_key
GROUP BY c.customer_key)

SELECT
    customer_category,
    COUNT(customer_key) AS total_customers
FROM (
SELECT 
    customer_key,
    CASE 
     WHEN total_spending > 5000 AND lifespan >= 12 THEN 'VIP'
     WHEN total_spending <= 5000 AND lifespan >= 12 THEN 'Regular'
     ELSE 'New'
    END AS customer_category
FROM customer_spending) t
GROUP BY customer_category
ORDER BY total_customers DESC;
