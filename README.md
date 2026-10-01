# Exploratory Data Analysis and Advanced Analytics - Retail Project

## Overview
A two-phase SQL analytics project built on top of a retail data warehouse.
Phase one covers structured exploratory data analysis using a six-step
framework to understand the business landscape. Phase two covers advanced
analytics using five analytical techniques to answer real business questions.
All analysis is done in SQL Server and delivered as reusable SQL scripts
and reporting views.

## Data Source
Three gold layer tables from a retail data warehouse containing customer,
product, and sales data.

dim_customers - 18,000 customers across 6 countries
dim_products - 295 products across 4 categories
fact_sales - sales transactions covering 4 years of order history
Total revenue - 29 million

## Phase 1 - Exploratory Data Analysis

### Six Step Framework

Step 1 - Database Exploration
Queried information schema to understand table structure, column names,
and data types across the entire database.

Step 2 - Dimension Exploration
Used DISTINCT queries on categorical columns like country, category,
gender, and product line to understand value ranges and cardinality.

Step 3 - Date Boundary Analysis
Used MIN and MAX on date columns to identify the earliest and latest
order dates. Calculated 4 years of sales history using DATEDIFF.
Found oldest customer age at 109 and youngest at 39.

Step 4 - Key Metrics
Calculated top-level business KPIs using aggregate functions.
- Total revenue: 29 million
- Total orders: 27,000 unique orders
- Total quantity sold: 60,000 items
- Average selling price: 486
- Total customers: 18,000
- Total products: 295
All metrics combined into a single summary query for one-shot
business overview.

Step 5 - Magnitude Analysis
Broke every measure by every dimension systematically to find
distribution insights.
- Total revenue by category
- Total customers by country and gender
- Average cost by product line
- Total quantity sold by country

Step 6 - Ranking Analysis
Ranked dimensions by aggregated measures to identify top and
bottom performers using TOP with ORDER BY and window functions.
- Top 5 products by revenue
- Bottom 5 products by revenue
- Top 10 customers by total spending
- Worst 3 customers by order count

### Key EDA Finding
Bikes generated 69% of total revenue - 28 million out of 29 million.
Accessories and clothing combined were under 1 million. This signals
significant category concentration risk for the business.

## Phase 2 — Advanced Analytics

### Five Analytical Techniques

1. Change Over Time Analysis
Tracked yearly and monthly sales trends using YEAR, MONTH, and
DATE_TRUNC functions with GROUP BY on order date.
- 2013 was the peak revenue year
- December consistently the strongest month confirming seasonality
- February consistently the weakest month

2. Cumulative Analysis
Built running totals using SUM as a window function with ORDER BY
inside OVER clause, partitioned by year to reset annually.
Shows business growth trajectory rather than individual period
performance.
Also calculated moving average price using windowed AVG.

3. Performance Analysis
Year-over-year comparison using LAG window function to access
previous year sales for each product.
Current versus average comparison using windowed AVG partitioned
by product name.
Each product automatically flagged as above average, below average,
increasing, or decreasing.

4. Part-to-Whole Analysis
Calculated each category percentage contribution to total revenue
using windowed SUM with no partition to get overall total then
dividing and rounding to two decimals.
Bikes: 69 percent
Components: 20 percent
Accessories: 6 percent
Clothing: 2 percent

5. Customer Segmentation
Grouped customers into three segments based on two measures.
Lifespan - DATEDIFF between first and last order date in months.
Total spending - SUM of sales amount per customer.

VIP: at least 12 months history and over 5,000 in spending - 1,655 customers
Regular: at least 12 months history and 5,000 or under - 2,000 customers
New: less than 12 months history - 14,000 customers

## Reporting Views

### report_customers
Consolidated customer reporting view containing customer details,
age group segmentation, VIP/Regular/New segmentation, and three KPIs.
- Recency: months since last purchase
- Average order value: total sales divided by total orders
- Average monthly spend: total sales divided by lifespan

### report_products
Consolidated product reporting view containing product details,
performance segmentation (High/Mid/Low), and three KPIs.
- Recency: months since last sale
- Average order revenue: total sales divided by total orders
- Average monthly revenue: total sales divided by product lifespan

Both views are consumable directly in Power BI or Tableau without
any additional data preparation.

## Repository Structure
Datasets - source gold layer CSV files
scripts - SQL scripts organized by analysis type
  01_database_exploration.sql
  02_dimensions_exploration.sql
  03_date_exploration.sql
  04_measures_exploration.sql
  05_magnitude_analysis.sql
  06_ranking_analysis.sql
  07_changes_over_time.sql
  08_cumulative_analysis.sql
  09_performance_analysis.sql
  10_part_to_whole.sql
  11_data_segmentation.sql
  12_report_customers.sql
  13_report_products.sql

## Tools Used
- SQL Server Express
- SQL Server Management Studio
- GitHub for version control

## How to Run
1. Ensure the retail data warehouse database is set up with
   dim_customers, dim_products, and fact_sales tables populated
2. Run scripts in numbered order for guided walkthrough
3. Execute 12_report_customers.sql and 13_report_products.sql
   to create the final reporting views
4. Connect reporting views to Power BI or Tableau for visualization
