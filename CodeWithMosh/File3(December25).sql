-- To Select a database
USE sql_store;

SELECT orders.order_id, customers.first_name, customers.last_name
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id; -- INNER JOIN or JOIN, both are same
-- If there a column which is available in both the table then,
-- we have to explicitly tell (customers.customer_id) to the SQL

SELECT o.order_id, c.first_name, c.last_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
-- In the above query if you are using the ALIASES then you have to use it COMPULSORY

#Exercise
-- Question = Watch Video
-- Answer is below:
SELECT order_id, order_items.product_id, name, quantity, order_items.unit_price FROM order_items
JOIN products p ON order_items.product_id = p.product_id;


## Joining Across Databases;
-- We use DATABASE = TABLE
--        sql_inventory = products
--        sql_store = products

-- Note: You only have to prefix the database that is not the part of the table
USE sql_store;
SELECT * FROM order_items
JOIN sql_inventory.products
    ON order_items.product_id = sql_inventory.products.product_id;

### SELF JOIN ###
-- Joining Table by itself
USE sql_hr;
SELECT * FROM employees e
JOIN employees m
    ON e.reports_to = m.employee_id;

-- Simplifying the query to display only the names of the employee and manager
SELECT e.employee_id,
       e.first_name,
       m.first_name Manager
FROM employees e
JOIN employees m
    ON e.reports_to = m.employee_id;

-- Joining a Table with itself (or SELF JOIN) is same as joining a table with another table



### Joining MULTIPLE Tables ###  More than 2 table
-- DATABASE = TABLE
-- sql_store = customers
-- sql_store = order_status
-- sql_store = orders

USE sql_store;
SELECT o.order_id, o.order_date,c.first_name,c.last_name,os.name AS status FROM orders o
JOIN customers c on o.customer_id = c.customer_id
JOIN order_statuses os on o.status = os.order_status_id;

#Exercise
-- Question = Watch Video
-- Answer is below:
USE sql_invoicing;
SELECT payments.payment_id,
       payments.client_id,
       c.name,invoice_id,
       payments.date,
       payments.amount,
       payments.payment_method,
       pm.name AS 'Payment Type'
FROM  payments
JOIN clients c
    ON c.client_id = payments.client_id
JOIN payment_methods pm
    ON payments.payment_method = pm.payment_method_id;

# select payment_id, c.client_id,
# 	c.name, invoice_id, date, amount,pm.name
#  from payments p
# JOIN clients c on p.client_id = c.client_id
# JOIN payment_methods pm on
# p.payment_method = pm.payment_method_id;


### Compound Join Conditions
-- Some of the times we cannot uniquely identify by using one column,
-- in such cases we have to combine multiple columns to get the unique value

USE sql_store;
SELECT * FROM order_items oi
JOIN order_item_notes oin
    ON oi.order_id = oin.order_Id
    AND oi.product_id = oin.product_id;

