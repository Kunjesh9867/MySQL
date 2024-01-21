####### 1-VIEWS #######
USE sql_invoicing;

SELECT c.client_id,
       c.name,
       SUM(invoice_total) AS total_sales
       FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

-- The above query is very useful and might be used multiple times.
-- For this purpose, we can create VIEW

CREATE VIEW sales_by_client AS
SELECT c.client_id,
       c.name,
       SUM(invoice_total) AS total_sales
       FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name;

-- A view has been created in the database (here, sql_invoicing)
-- We can call a VIEW by using select statement and perform sorting, order by etc functionality

-- (1)
SELECT * FROM sales_by_client;

-- (2)
SELECT * FROM sales_by_client
WHERE total_sales > 500;

-- (3)
SELECT * FROM sales_by_client
JOIN clients USING (client_id);

#Exercise
-- Create a view to see the balance
-- for each client.
--
-- client_balance (name of view)

-- client_id
-- name
-- balance (invoicing total - payment total )

USE sql_invoicing;

CREATE VIEW client_balance AS
SELECT c.client_id,
       c.name,
       SUM(invoice_total-payment_total) AS balance
    FROM clients c
JOIN invoices i ON c.client_id = i.client_id
GROUP BY c.client_id;
-- GROUP BY c.client_id, c.name;



### 2- Altering or Dropping Views ###
USE sql_invoicing;

-- Dropping a view
DROP VIEW sales_by_client;

CREATE OR REPLACE VIEW client_balance AS  -- REPLACE
SELECT c.client_id,
       c.name,
       SUM(invoice_total-payment_total) AS balance
    FROM clients c
JOIN invoices i ON c.client_id = i.client_id
GROUP BY c.client_id;


### 3- Updatable Views ###
-- We can create an updatable view.
-- This tasks can be achieved if the VIEW does not have
-- (1) DISTINCT
-- (2) Aggregate Functions (SUM,MIN,MAX,AVG,COUNT)
-- (3) GROUP BY / HAVING
-- (4) UNION
USE sql_invoicing;

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT invoice_id,
       number,
       client_id,
       invoice_total,
       (invoice_total - payment_total) AS balance ,
       payment_total,
       invoice_date,
       due_date,
       payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0;
-- WHERE (SELECT balance) > 0; SQL will give you an error stating that the column does not exists

-- In the above query, we have not used any of the parameters listed above, so this is an updatable view

DELETE FROM invoices_with_balance
WHERE invoice_id=1;

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 2;


### 4- THE WITH OPTION CHECK Clause ###

UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 2;

select * from invoices_with_balance;

-- When we run the above query, the record where invoice_id = 2 will disappear
-- This is the default behavior of the view
-- When you update or delete the data, some of the rows may disappear

-- You can prevent it using

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT invoice_id,
       number,
       client_id,
       invoice_total,
       (invoice_total - payment_total) AS balance ,
       payment_total,
       invoice_date,
       due_date,
       payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION;  -- this will prevent excluding rows from the views

UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 3;
-- If we run the query, it will generate an error - CHECK OPTION failed
-- We will not be able to perform update or delete from the view


### 5- Other Benefits of Views ###
-- ADVANTAGES of views
-- (1) Simplify query
-- (2) Reduce the impact of changes (on the main table)
-- (3) Restrict access to the data
-- (4) Data Security

