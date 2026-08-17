--Which of the 5 products genetare the highest revenue?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key =f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC

--What are the 5 worst performing products in terms of service?
SELECT TOP 5
p.product_name,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key =f.product_key
GROUP BY p.product_name
ORDER BY total_revenue 

--What are the 5 best subcategorys?
SELECT TOP 5
p.subcategory,
SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key =f.product_key
GROUP BY p.subcategory
ORDER BY total_revenue DESC

--This one is made using a window function for more flexibility
SELECT *
FROM(
	SELECT 
	p.product_name,
	SUM(f.sales_amount) total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount)DESC) AS rank_products
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON p.product_key =f.product_key
	GROUP BY p.product_name)t
WHERE rank_products <= 5

--Who are the top 10 customers who have generated the highest revenue?
SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amount)AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key= f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_revenue DESC

--Who are the top 3 customers who have generated the lowest revenue?
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT order_number)AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key= f.customer_key
GROUP BY
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders 