SELECT *
FROM CustomerShopping..customer_shopping_data$

-- Male vs Female
SELECT gender, ROUND(SUM(price),2) AS revenue
FROM CustomerShopping..customer_shopping_data$
GROUP BY gender

-- Digging deeper in category
SELECT gender, category, ROUND(SUM(price),2) AS revenue
FROM CustomerShopping..customer_shopping_data$
GROUP BY gender, category
ORDER BY 2

-- Check for Difference of gender in shopping malls
SELECT gender, shopping_mall, ROUND(SUM(price),2) AS revenue
FROM CustomerShopping..customer_shopping_data$
GROUP BY gender, shopping_mall
ORDER BY 2

--Most purchased products
SELECT category, SUM(quantity) as total_sold, ROUND(SUM(price),2) AS revenue
FROM CustomerShopping..customer_shopping_data$
GROUP BY category
ORDER BY revenue DESC

-- Most active age
SELECT age, ROUND(SUM(price),2) AS revenue
FROM CustomerShopping..customer_shopping_data$
GROUP BY age
ORDER BY revenue DESC

-- Revenue in shopping mall
SELECT shopping_mall, ROUND(SUM(price),2) AS revenue
FROM CustomerShopping..customer_shopping_data$
GROUP BY shopping_mall
ORDER BY 2 DESC

--Average revenue per month in year per product
SELECT category, year, month, ROUND(SUM(price),2) AS revenue
FROM (
	SELECT *, MONTH(invoice_date) AS month, YEAR(invoice_date) as year
	FROM CustomerShopping..customer_shopping_data$
) as tmp
GROUP BY category, year, month
ORDER BY category, year, month

--Total revenue each year per product
SELECT category, year, ROUND(SUM(price),2) AS revenue
FROM (
	SELECT *, MONTH(invoice_date) AS month, YEAR(invoice_date) as year
	FROM CustomerShopping..customer_shopping_data$
) as tmp
GROUP BY year, category
ORDER BY category ASC, revenue DESC

--Most preffered paying method
SELECT payment_method, COUNT(*) as invoice_paid
FROM CustomerShopping..customer_shopping_data$
GROUP BY payment_method

--Market share between shopping malls
SELECT shopping_mall, ROUND(CAST (COUNT(*) AS Decimal)/(SELECT COUNT(*)
FROM CustomerShopping..customer_shopping_data$) * 100,2) AS market_pct
FROM CustomerShopping..customer_shopping_data$
GROUP BY shopping_mall
