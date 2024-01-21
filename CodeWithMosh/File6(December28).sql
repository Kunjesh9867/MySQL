### Aggregate Functions ###
-- Function is a piece of code that can be used
-- MIN()
-- MAX()
-- AVG()
-- SUM()
-- COUNT()
-- We can apply this to Number, Date, String
-- It only works on NON-NULL values

USE sql_invoicing;
SELECT MAX(invoice_total) AS Highest,
       MIN(invoice_total) AS Lowest,
       AVG(invoice_total) AS Average,
       SUM(invoice_total * 1.1) AS Total,
       COUNT(invoice_total) AS Number_Of_Invoices,
       COUNT(payment_date) AS Count_Of_Payments,  -- Not all rows included because few are NULL
       COUNT(*) AS Total_Records,
       COUNT(DISTINCT client_id)
FROM invoices
WHERE invoice_date>'2019-07-01';

#Exercise
-- Question = Video
-- Answer:
USE sql_invoicing;
SELECT 'First half of 2019' AS data_range,
       SUM(invoice_total) AS total_sales,
       SUM(payment_total) AS total_payments,
       SUM(invoice_total-payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'

UNION

SELECT 'Second half of 2019' AS data_range,
       SUM(invoice_total) AS total_sales,
       SUM(payment_total) AS total_payments,
       SUM(invoice_total-payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'

UNION
SELECT 'Total' AS data_range,
       SUM(invoice_total) AS total_sales,
       SUM(payment_total) AS total_payments,
       SUM(invoice_total-payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31';


### GROUP BY clause ###
-- When we have to group the records by using Aggregate function
USE sql_invoicing;
SELECT
    client_id,
    SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date>='2019-07-01'
GROUP BY client_id
ORDER BY total_sales DESC;


SELECT state,
       city,
       SUM(invoice_total)
    FROM invoices i
JOIN clients c USING (client_id)
GROUP BY state,city
ORDER BY city;

#Exercise
SELECT date,
       name,
       SUM(amount) AS total_payment
FROM payments
JOIN payment_methods pm
    ON payments.payment_method = pm.payment_method_id
GROUP BY date,name
ORDER BY date;


### HAVING clause ###
USE sql_invoicing;

# SELECT client_id,
#        SUM(invoice_total) AS total_sales
# FROM invoices
# WHERE total_sales >500    -- Here, MySQL will yell at you because it is an unknown column
# GROUP BY client_id

SELECT client_id,
      SUM(invoice_total) AS total_sales,
      COUNT(*) AS number_of_invoices
FROM invoices
GROUP BY client_id
HAVING total_sales>500 AND number_of_invoices>5;

-- WHERE = before the data is grouped
-- HAVING = after the data is grouped
-- Note: In the HAVING clause, we cannot include the column which is not in the SELECT statement

#Exercise
-- Get the customers
-- located in Virginia
-- who have spent more than $100
USE sql_store;


SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE state='VA'
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING total_sales > 100;


### ROLLUP Operator ###
-- ROLLUP means total of the value
-- Only applies to aggregate columns
-- Only available in MySQL
USE sql_invoicing;


SELECT
    c.client_id,
    SUM(invoice_total) AS total_sales
    FROM invoices v
JOIN clients c on v.client_id = c.client_id
GROUP BY c.client_id WITH ROLLUP;


SELECT
    state,
    city,
    SUM(invoice_total) AS total_sales
    FROM invoices v
JOIN clients c on v.client_id = c.client_id
GROUP BY state, city WITH ROLLUP;
