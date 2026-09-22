SELECT *
FROM retail_project.retail_sales
LIMIT 10;

SELECT COUNT(*) AS total_rows
FROM retail_project.retail_sales;
SELECT COUNT(*) AS cancellation_rows
FROM retail_project.retail_sales
WHERE invoice_no LIKE 'C%';

SELECT description, SUM(quantity) as units_sold
FROM retail_project.retail_sales
WHERE invoice_no NOT LIKE 'C%' AND quantity > 0
GROUP BY description
ORDER BY units_sold DESC
LIMIT 10;

SELECT description, SUM(quantity * unit_price) AS revenue
FROM retail_project.retail_sales
WHERE invoice_no NOT LIKE 'C%' AND quantity > 0 AND unit_price > 0
GROUP BY description
ORDER BY revenue DESC
LIMIT 10;

SELECT country, SUM(quantity * unit_price) AS revenue
FROM retail_project.retail_sales
WHERE invoice_no NOT LIKE 'C%' AND quantity > 0 AND unit_price > 0
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;

SELECT DATE_FORMAT(invoice_date, '%Y-%m') AS month,
       SUM(quantity * unit_price) AS revenue
FROM retail_project.retail_sales
WHERE invoice_no NOT LIKE 'C%'
  AND quantity > 0
  AND unit_price > 0
GROUP BY DATE_FORMAT(invoice_date, '%Y-%m')
ORDER BY month;

SELECT
    COUNT(*) AS rows_in_sample,
    COUNT(DISTINCT invoice_no) AS distinct_invoices,
    COUNT(DISTINCT country) AS countries
FROM retail_project.retail_sales;

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN invoice_no LIKE 'C%' THEN 1 ELSE 0 END) AS cancellation_rows,
    SUM(CASE WHEN quantity <= 0 OR unit_price <= 0 THEN 1 ELSE 0 END) AS nonpositive_rows
FROM retail_project.retail_sales;

SELECT COUNT(*) AS usable_sales_rows
FROM retail_project.retail_sales
WHERE invoice_no NOT LIKE 'C%'
  AND quantity > 0
  AND unit_price > 0;

SELECT
    ROUND(SUM(quantity * unit_price), 2) AS sample_revenue
FROM retail_project.retail_sales
WHERE invoice_no NOT LIKE 'C%'
  AND quantity > 0
  AND unit_price > 0;
  
SELECT
    stock_code,
    description,
    SUM(quantity) AS units_sold,
    ROUND(SUM(quantity * unit_price), 2) AS revenue
FROM retail_project.retail_sales
WHERE invoice_no NOT LIKE 'C%'
  AND quantity > 0
  AND unit_price > 0
  AND description IS NOT NULL
  AND description <> ''
AND stock_code NOT IN ('POST', 'DOT')
GROUP BY stock_code, description
ORDER BY revenue DESC
LIMIT 10;

SELECT
    country,
    COUNT(DISTINCT invoice_no) AS invoices,
    ROUND(SUM(quantity * unit_price), 2) AS revenue
FROM retail_project.retail_sales
WHERE invoice_no NOT LIKE 'C%'
  AND quantity > 0
  AND unit_price > 0
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;
