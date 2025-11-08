/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

--Identify the earliest and latest dates and understand the timespan, age etc.

SELECT MIN(birthdate) AS earliest_date,
DATEDIFF(YEAR,MIN(birthdate), GETDATE() ) AS oldest_age,
Max(birthdate) AS latest_date,
DATEDIFF(YEAR,MAX(birthdate), GETDATE() ) AS yongest_age
FROM gold.dim_customers;

SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(YEAR, MIN(order_date),MAX(order_date)) AS order_range_years
FROM gold.fact_sales;
