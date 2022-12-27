### Implicit Join Syntax ###
USE sql_store;
SELECT * FROM orders o   -- Explicit Join Syntax
JOIN customers c
    ON c.customer_id = o.customer_id;

-- The above query can be written as:
SELECT * FROM orders o, customers c  -- Implicit join syntax
WHERE o.customer_id = c.customer_id;

-- If possible, avoid it because if you forgot WHERE clause, you will get CROSS JOIN

-- NOTE: Be aware of the implicit join syntax but write only explicit


###### OUTER JOIN ######
-- Earlier in the tutorial, we have discuss that we have 2 types of Join: Inner / Outer

-- In inner join, we only get the results where the results are matched
-- (we don't get the null value for the other results)

-- In outer join, we can structure the query in such a way that we can get all the null result as well

-- In INNER JOIN = INNER word is optional
-- IN OUTER JOIN i.e RIGHT OUTER JOIN / LEFT OUTER JOIN
-- The OUTER is optional

SELECT
    c.customer_id,
    c.first_name,
    o.order_id
    FROM orders o
RIGHT JOIN customers c
-- RIGHT OUTER JOIN
-- LEFT JOIN / LEFT OUTER JOIN
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

#Exercise
-- Question = Watch video:
-- Answer:
SELECT
    p.product_id,
    p.name,
    oi.quantity
    FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id;


### OUTER Joins Between Multiple Tables ###
-- For the best practice, avoid RIGHT join and write LEFT join only.
-- Because when multiple tables are joined its harder to visualize.

SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    s.name AS shipper
    FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN shippers s
    ON o.shipper_id = s.shipper_id
ORDER BY c.customer_id;


#Exercise
-- Question = Watch video:
-- Answer:

SELECT
    orders.order_date,
    orders.order_id,
    c.first_name,
    s.name AS shipper,
    os.name AS status
    FROM orders
LEFT JOIN customers c
    ON orders.customer_id = c.customer_id
LEFT JOIN shippers s
    ON orders.shipper_id = s.shipper_id
LEFT JOIN order_statuses os
    ON orders.status = os.order_status_id
ORDER BY os.name;


### SELF OUTER JOINS ###
USE sql_hr;
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    m.first_name AS manager
    FROM employees e
JOIN employees m ON e.reports_to = m.employee_id;
-- In the above query 1 record is missing
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    m.first_name AS manager
    FROM employees e
LEFT JOIN employees m ON e.reports_to = m.employee_id;

### USING clause ###
USE sql_store;


SELECT
    o.order_id,
    c.first_name
    FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id;
-- In the above example, join statement is joined by same column (customer_id)
-- So in the MySQL, we have a powerful tool called USING
-- Here, we can use USING clause

SELECT
    o.order_id,
    c.first_name
    FROM orders o
JOIN customers c
--     ON c.customer_id = o.customer_id;
        USING (customer_id);

-- Another Example
SELECT * FROM order_items oi
JOIN order_item_notes oin
    USING (order_id,product_id);


#Exercise
-- Question = Watch video:
-- Answer:
USE sql_invoicing;

SELECT
    payments.date,
    c.name AS client,
    payments.amount,
    pm.name AS name
    FROM payments
JOIN clients c   -- LEFT JOIN / INNER JOIN(JOIN) = same
    USING (client_id)
JOIN payment_methods pm
    ON payments.payment_method = pm.payment_method_id;



### NATURAL JOIN ###
-- The SQL will automatically join the table based on the same column
-- Avoid it because we let SQL to decided to join by column

USE sql_store;

SELECT * FROM orders o
NATURAL JOIN customers c;

SELECT
    o.order_id,
    c.first_name
    FROM orders o
NATURAL JOIN customers c;


### CROSS JOINS ###
-- There are 2 ways: Implicit cross join and Explicit cross join

-- Explicit = Preferred = More Clear
SELECT
    customers.first_name AS customer,
    p.name AS product
    FROM customers
CROSS JOIN products p
ORDER BY customers.first_name;

-- Implicit
SELECT
    customers.first_name AS customer,
    p.name AS product
    FROM customers, products p
ORDER BY customers.first_name;


#Exercise
-- Do a cross join between shippers and products
-- using the implicit syntax
-- and then using the explicit syntax

SELECT * FROM shippers,products;

SELECT * FROM shippers
    CROSS JOIN products;


###### Till now, we covers to combines column, but now we will learn to join rows WOW :)

### UNION ###

SELECT
    order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'

UNION

SELECT
    order_id,
    order_date,
    'Archive' AS status
FROM orders
WHERE order_date <= '2019-01-01';


-- The number of column should be same in both the query
-- Name of the Column = Name of the Column in the first query


#Exercise
-- Question = Watch video:
-- Answer:

SELECT
    customer_id,
    first_name,
    points,
    'Bronze' AS type
    FROM customers
WHERE points <2000

UNION

SELECT
    customer_id,
    first_name,
    points,
    'Silver'
    FROM customers
WHERE points >= 2000 AND points < 3000

UNION

SELECT
    customer_id,
    first_name,
    points,
    'Gold' AS type
    FROM customers
WHERE points >= 3000

ORDER BY first_name;


-- NOTE: THe above query can be written by using BETWEEN clause

