-- Revenue vs Volume by warehouse
SELECT warehouse,client_type,
COUNT(*) AS total_order,
SUM(quantity) AS total_quantity,
ROUND(SUM(total::NUMERIC),2) AS gross_revenue,
ROUND(AVG(total::NUMERIC),2) AS avg_total_value
FROM sales
GROUP BY warehouse, client_type
ORDER BY gross_revenue DESC;


-- high volume driver vs high margin/value drivers by product line

SELECT product_line,
	SUM(quantity) AS volume_driver,
	ROUND(AVG(unit_price::NUMERIC),2) AS avg_unit_price,
	ROUND(SUM(total::NUMERIC),2) AS total_revenue
	FROM sales
	GROUP BY product_line
	ORDER BY total_revenue DESC;

	-- Sales by client_type
	SELECT client_type,
	COUNT(*) AS total_order,
	ROUND(AVG(total::NUMERIC),2) AS avg_total_revenue
	FROM sales
	GROUP BY client_type
	ORDER BY avg_total_revenue DESC;

	-- sales trend by month
	SELECT TO_CHAR(date, 'YYYY-MM') AS sales_month,client_type,warehouse,product_line,
	ROUND(AVG(total::NUMERIC),2) AS avg_monthly_revenue
	FROM sales
	GROUP BY TO_CHAR(date, 'YYYY-MM'),client_type,warehouse,product_line
	ORDER BY avg_monthly_revenue DESC;

	-- Payment method distribution
	SELECT count(*) AS transaction_sales,
	payment, client_type
	FROM sales
	GROUP BY payment, client_type 
	ORDER BY transaction_sales DESC;
	
	COPY sales TO 'C:/Users/Public/clean_sales.csv' DELIMITER ',' CSV HEADER;
