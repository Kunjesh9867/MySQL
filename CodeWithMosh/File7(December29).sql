### Writing Complex Queries ###

### (1) Introduction ###
### (2) Subqueries ###
USE sql_store;

-- Find products that are more
-- expensive than Lettuce (id=3)
SELECT * FROM products
WHERE unit_price >
      (
      SELECT unit_price FROM products
      WHERE product_id=3
      );

#Exercise
-- In sql_hr database:
-- Find employees whose earn more than average
USE sql_hr;
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

### (3) IN Operator ###
-- Find the products that have never been ordered
USE sql_store;

SELECT * FROM products
WHERE product_id NOT IN
      (SELECT DISTINCT product_id FROM order_items);

#Exercise
-- Find clients without invoices
USE sql_invoicing;

SELECT * FROM clients
WHERE client_id NOT IN
      (SELECT DISTINCT client_id FROM invoices);


### (4) Subqueries V/S Joins ###
-- Find clients without invoices

-- Using Subqueries
USE sql_invoicing;

SELECT * FROM clients
WHERE client_id NOT IN
      (SELECT DISTINCT client_id FROM invoices);

-- Using Join
SELECT * FROM clients
    LEFT JOIN invoices i USING (client_id)
WHERE i.invoice_id IS NULL;

#Exercise
-- Find customers who have ordered lettuce (id=3)
-- Select customer_id, first_name, last_name
USE sql_store;

-- 1
SELECT * FROM customers
WHERE customer_id IN (
    SELECT orders.customer_id FROM orders
    JOIN order_items oi on orders.order_id = oi.order_id
    WHERE product_id =3
    );

-- 2
SELECT
    DISTINCT c.customer_id,
             first_name,
             last_name
    FROM customers c
JOIN orders o on c.customer_id = o.customer_id
JOIN order_items oi on o.order_id = oi.order_id
WHERE product_id=3;


### (5) ALL Keyword ###
-- Select invoices larger than all invoices of client 3
-- client 3
USE sql_invoicing;


-- Both the below queries produces the same result.
SELECT * FROM invoices
WHERE invoice_total >
      (SELECT MAX(invoice_total)
       FROM invoices
       WHERE client_id=3);


SELECT * FROM invoices
WHERE invoice_total > ALL (
    SELECT invoice_total
    FROM invoices
    WHERE client_id=3
    );

### (6) ANY Keyword ###
-- Select products that were sold by
-- the unit (quantity = 1)
USE sql_invoicing;

SELECT * FROM invoices
WHERE invoice_total > SOME(
    SELECT invoice_total
    FROM invoices
    WHERE client_id=3
    );


### (7) Correlated Subqueries

-- Select employees whose salary is
-- above the average in their office
USE sql_hr;
select * from employees;

-- Pseudo Code
-- for each employee,
--      calculate the avg salary for employee.office
--      return the employee if salary > avg
SELECT * FROM employees e
WHERE salary > (   -- SubQuery
    SELECT AVG(salary) FROM employees
    WHERE  office_id = e.office_id  -- Correlated subquery = We correlate outer query with inner
    );



# Some of the times the correlated query will be slow as it need to correlate with the outer query
-- Correlated query has a lot of applications in the real world.

#Exercise
-- Get invoices that are larger than the
-- client's average invoice amount
USE sql_invoicing;


SELECT * FROM invoices i
WHERE invoice_total > (
    SELECT AVG(invoice_total) FROM invoices
    WHERE client_id = i.client_id
);

### (8) EXISTS Operator
-- Select clients that have an invoice
USE sql_invoicing;

SELECT * FROM invoices
WHERE client_id IN (
    SELECT DISTINCT client_id FROM invoices
    );

-- In the above query, we have get the desired output using IN - Subquery
# The above query will look like

# SELECT * FROM invoices
# WHERE client_id IN (1,2,3,5);

-- But when we have thousands of records, the LISTS will augment and it will have negative effect on the performance
-- That's why we use EXITS


-- We can also get the same result using the JOINTS


-- Now, we are going to the 3rd method to solve the same problem

SELECT * FROM clients c
WHERE EXISTS( -- Exists = It will generate True/False result, if True then => it will display the record
    SELECT client_id FROM invoices
    WHERE client_id = c.client_id  -- Correlated Subquery
);

#Exercise
-- Find the products that have never been ordered
USE sql_store;

SELECT * FROM products
WHERE product_id NOT IN (
    SELECT product_id FROM order_items
    );

SELECT * FROM products p
WHERE NOT EXISTS(
    SELECT  product_id FROM order_items
    WHERE product_id = p.product_id
    );


### (9) Subquery in the SELECT clause
USE sql_invoicing;

SELECT invoice_id,
       invoice_total,
       (SELECT AVG(invoice_total) FROM invoices) AS invoice_average,
       invoice_total - (SELECT invoice_average) AS difference
   --  invoice_total - (SELECT AVG(invoice_total) FROM invoices) AS difference  ==> But this is too long
    FROM invoices;


#Exercise
USE sql_invoicing;

-- Solution-1
SELECT client_id,
       name,
       (SELECT SUM(invoice_total) FROM invoices WHERE c.client_id = client_id) AS total_sales,
       (SELECT AVG(invoice_total) FROM invoices) AS average,
        (SELECT total_sales) - (SELECT average) AS difference
    -- (SELECT total_sales - average) AS difference
    FROM clients c ;

-- Solution-2
select c.client_id, c.name, SUM(invoice_total) as total_sales,
       (SELECt AVG(invoice_total) FROM invoices) as average,
       SUM(invoice_total) - (SELECT average)  as difference
from invoices
RIGHT JOIN sql_invoicing.clients c on invoices.client_id = c.client_id
GROUP BY c.client_id, c.name;

### (10) Subquery in the FROM clause
-- In the above exercise, we have generate a valuable data
-- This data can be filtered, change, added (rows), or other operation can be performed
-- In order to achieve this, we have to use it in the FROM clause

SELECT * FROM (
    SELECT client_id,
       name,
       (SELECT SUM(invoice_total) FROM invoices WHERE c.client_id = client_id) AS total_sales,
       (SELECT AVG(invoice_total) FROM invoices) AS average,
        (SELECT total_sales) - (SELECT average) AS difference
    -- (SELECT total_sales - average) AS difference
    FROM clients c
) AS sales_summary  -- Alias is IMP
WHERE total_sales IS NOT NULL;
