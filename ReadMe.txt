# SQL Data Analytics Project

## 📌 Project Overview

This project is the **Data Analytics part** of the Data Warehouse project.

The Data Warehouse was created first and the data was prepared in the **Gold layer**. After that, I used SQL Server to explore the data and try to find useful information from it.

The main things I focused on were:

* 👥 Customers
* 📦 Products
* 💰 Sales

The main idea of this project was to practice using SQL for data analysis and not just for simple `SELECT` queries. I wanted to see what kind of information I could get from the data and find some useful patterns.

---

## 🎯 What I Wanted to Do

The main things I wanted to do in this project were:

* Explore the data in the Gold layer.
* Understand the tables and columns.
* Do some basic data exploration.
* Calculate some useful numbers and KPIs.
* Look at sales over time.
* Find the best and worst products.
* Look at customer purchases.
* Compare customers and products.
* Use SQL window functions.
* Create some customer and product groups.
* Find how much each category contributes to the total sales.
* Try to get some useful conclusions from the results.

---

## 🗂️ Data Used

For this part of the project I used the Gold layer from the Data Warehouse.

The main tables I used were:

* `gold.fact_sales`
* `gold.dim_customers`
* `gold.dim_products`

The `fact_sales` table contains the sales data, while the customer and product tables contain information about the customers and products.

The Data Warehouse and ETL part of the project is explained in a different README.

This README is only about the analysis I did after the Gold layer was ready.

---

## 🔎 Data Exploration

The first thing I did was explore the data.

Before starting with more complicated queries, I wanted to understand what was inside the database.

Some of the questions I looked at were:

* What tables do I have?
* What columns are in the tables?
* What is the first sales date?
* What is the last sales date?
* How many customers are there?
* How many products are there?
* How many sales are there?
* What are the total sales?
* How many products were sold?
* What product categories are available?
* Which customers have the highest sales?
* Which products have the highest sales?

This helped me get a better idea of the data before moving on to the other queries.

---

## 📊 Measures and Metrics

After exploring the data, I calculated some basic numbers.

For example:

* Total Sales
* Total Quantity Sold
* Average Sales
* Average Price
* Number of Orders
* Number of Customers
* Number of Products
* Number of Sales

One example is:

```sql
SELECT
    SUM(sls_sales) AS total_sales,
    SUM(sls_quantity) AS total_quantity,
    AVG(sls_price) AS average_price
FROM gold.fact_sales;
```

These queries helped me get a general idea of the data.

---

## 📅 Sales Over Time

I also wanted to see how the sales changed over time.

I looked at sales by:

* Year
* Month
* Quarter
* Day

For example:

```sql
SELECT
    YEAR(sls_order_dt) AS order_year,
    SUM(sls_sales) AS total_sales
FROM gold.fact_sales
GROUP BY YEAR(sls_order_dt)
ORDER BY order_year;
```

With this type of query I can see which years had more sales and compare the results between them.

---

## 📈 Cumulative Analysis

I also practiced using cumulative calculations.

For example, I calculated running totals of sales.

I used SQL window functions such as:

* `SUM() OVER()`
* `AVG() OVER()`

For example:

```sql
SUM(total_sales) OVER (
    ORDER BY order_year
) AS cumulative_sales
```

This shows how the total sales increase over time.

---

## 🏆 Performance Analysis

Another thing I tried was comparing the performance of different periods and groups.

For example:

* One year compared with the previous year.
* One month compared with another month.
* A product compared with the average product.
* A customer compared with the average customer.

I used functions like `LAG()` and `AVG() OVER()` for this.

For example:

```sql
LAG(total_sales) OVER (
    ORDER BY order_year
) AS previous_year_sales
```

This allowed me to compare the current year's sales with the previous year's sales.

---

## 🥇 Ranking Analysis

I also used ranking functions to find the top and bottom results.

For example, I looked for:

* Top products by sales.
* Top products by quantity.
* Top customers by sales.
* Customers with the most orders.
* Products with low sales.

Some of the SQL functions I used for ranking were:

* `RANK()`
* `DENSE_RANK()`
* `ROW_NUMBER()`

Example:

```sql
SELECT
    product_name,
    total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM product_sales;
```

This gives each product a rank depending on its sales.

---

## 👥 Customer Analysis

I also looked at the customers and their purchasing behavior.

Some of the things I checked were:

* How many customers there are.
* How much each customer spent.
* How many orders each customer made.
* Average order value.
* Top customers.
* Customers with lower sales.

I also tried to group customers into different categories.

For example:

* VIP
* Regular
* Occasional

This was mainly done using `CASE` statements.

---

## 📦 Product Analysis

For the products, I looked at their sales and performance.

Some of the questions were:

* Which products have the most sales?
* Which products sell the most units?
* Which categories have the most sales?
* Which products have low sales?
* Which products contribute the most to the total sales?

I also used ranking to compare the products with each other.

---

## 🧩 Customer Segmentation

I used segmentation to put customers into different groups based on how much they spent.

For example:

```sql
CASE
    WHEN total_sales >= 50000 THEN 'VIP'
    WHEN total_sales >= 10000 THEN 'Regular'
    ELSE 'Occasional'
END AS customer_segment
```

This is just an example of how I can separate customers based on their total sales.

I also looked at similar ways of grouping products based on their performance.

---

## 🧮 Part-to-Whole Analysis

I also checked how much each category contributes to the total sales.

For example:

```sql
SELECT
    category,
    total_sales,
    total_sales * 100.0 /
        SUM(total_sales) OVER() AS percentage_of_total
FROM category_sales;
```

This shows the percentage of the total sales that comes from each category.

This can help answer questions like:

* Which category has the most sales?
* Which category is responsible for most of the revenue?
* How much does each category contribute?

---

## 🛠️ SQL I Used

During the project I used different SQL commands and functions.

### Basic SQL

* `SELECT`
* `FROM`
* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`

### Aggregations

* `SUM()`
* `AVG()`
* `COUNT()`
* `COUNT(DISTINCT)`

### Joins

* `INNER JOIN`
* `LEFT JOIN`

### Other

* `CASE`
* NULL handling
* CTEs
* Subqueries

### Window Functions

* `RANK()`
* `DENSE_RANK()`
* `ROW_NUMBER()`
* `LAG()`
* `LEAD()`
* `SUM() OVER()`
* `AVG() OVER()`

### Date Functions

* `YEAR()`
* `MONTH()`
* `DATEPART()`

---

## 📁 Project Structure

The analytics part of the project is organized something like this:

```text
data-analytics/
│
├── scripts/
│   ├── 01_database_exploration.sql
│   ├── 02_measures_and_metrics.sql
│   ├── 03_magnitude_analysis.sql
│   ├── 04_ranking_analysis.sql
│   ├── 05_change_over_time.sql
│   ├── 06_cumulative_analysis.sql
│   ├── 07_performance_analysis.sql
│   ├── 08_part_to_whole_analysis.sql
│   └── 09_customer_segmentation.sql
│
└── README.md
```

The names of the files can be different depending on how the project is organized.

---

## 💡 Some Things I Can Find From the Data

After doing the analysis, I can use the results to find things like:

* Which products sell the most.
* Which products sell the least.
* Which categories have the highest sales.
* Which customers spend the most.
* How sales change over time.
* Which periods have higher sales.
* Which customer groups are more valuable.
* How much each category contributes to total sales.

The idea is to look at the results and try to understand what they mean instead of just getting numbers from SQL.

---

## 🚀 Project Process

The general process I followed was:

```text
Gold Layer
    ↓
Explore the Data
    ↓
Calculate Metrics
    ↓
Analyze Sales Over Time
    ↓
Ranking Analysis
    ↓
Cumulative Analysis
    ↓
Performance Analysis
    ↓
Customer/Product Segmentation
    ↓
Part-to-Whole Analysis
    ↓
Look at the Results
```

---

## 🎓 What I Learned

While working on this project, I got more practice with:

* SQL Server
* T-SQL
* Data exploration
* Aggregations
* Joins
* CTEs
* Subqueries
* Window functions
* Date functions
* Ranking
* Customer analysis
* Product analysis
* Sales analysis
* Basic data segmentation

The main thing I learned from this project is that SQL can be used for more than just getting data from a database.

I started using SQL to ask questions about the data and then use the results to understand what is happening.

This project also helped me get more comfortable working with the **Gold layer of a Data Warehouse** and doing analysis on top of it.
