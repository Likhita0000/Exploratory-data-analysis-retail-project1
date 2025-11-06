/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Ranking for different categories based on total_sales
SELECT
    p.category,
    SUM(f.sales_amount) AS total_sales,
    RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS ranking
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS p
ON f.product_key = p.product_key
GROUP BY p.category;


-- Top 3 performing countries for total_sales
SELECT TOP 3
    c.country,
    SUM(f.sales_amount) AS total_sales,
    RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS ranking
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON f.customer_key = c.customer_key
GROUP BY c.country;

-- Least 3 performing countries for total_sales
SELECT TOP 3
    c.country,
    SUM(f.sales_amount) AS total_sales,
    RANK() OVER(ORDER BY SUM(f.sales_amount)) AS ranking
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON f.customer_key = c.customer_key
GROUP BY c.country;


-- Top 5 performing subcategories by their sales
SELECT
    subcategory,
    total_sales
FROM (
    SELECT
        p.subcategory,
        SUM(f.sales_amount) AS total_sales,
        RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS ranking
    FROM gold.fact_sales AS f
    LEFT JOIN  gold.dim_products AS p
    ON f.product_key = p.product_key
    GROUP BY P.subcategory) AS t
WHERE ranking <= 5
 
-- Top 5 performing products
 SELECT
    product_name,
    total_sales
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_sales,
        RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS ranking
    FROM gold.fact_sales AS f
    LEFT JOIN  gold.dim_products AS p
    ON f.product_key = p.product_key
    GROUP BY P.product_name) AS t
WHERE ranking <= 5


-- Least performing products
SELECT
    product_name,
    total_sales
FROM (
    SELECT
        p.product_name,
        SUM(f.sales_amount) AS total_sales,
        RANK() OVER(ORDER BY SUM(f.sales_amount)) AS ranking
    FROM gold.fact_sales AS f
    LEFT JOIN  gold.dim_products AS p
    ON f.product_key = p.product_key
    GROUP BY P.product_name) AS t
WHERE ranking <= 5

-- Top performing customers

SELECT TOP 5
    f.order_number,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_sales
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
ON f.customer_key = c.customer_key
GROUP BY
    f.order_number,
    c.first_name,
    c.last_name
ORDER BY total_sales DESC;
