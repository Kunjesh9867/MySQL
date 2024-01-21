### Inserting a Row ###
USE sql_store;

INSERT INTO customers
VALUES (DEFAULT,'John','Smith','1990-01-01',NULL,'address','city','CA',DEFAULT);
--                                          DEFAULT                     0
-- Default is for auto_increment


select * from customers;

### Inserting Multiple Rows ###
INSERT INTO shippers
VALUES (DEFAULT,'Shipper1'),
       (DEFAULT,'Shipper2'),
       (DEFAULT,'Shipper3');

#Exercise
-- Insert three rows in the products table
SELECT * FROM products;
INSERT INTO products
VALUES (DEFAULT,'Mushroom',100,10.99),  -- Default because it is auto_increment
       (DEFAULT,'Apple',50,5.5),
       (DEFAULT,'Guava',500,3.99);

### Inserting Hierarchical Rows ###
-- order = parent
-- order_items = child
INSERT INTO orders (customer_id, order_date, status) -- rest of them are OPTIONAL
VALUES (1,'2019-01-02',1);

SELECT LAST_INSERT_ID();

INSERT INTO order_items
VALUES (LAST_INSERT_ID(),1,1,2.95),
       (LAST_INSERT_ID(),2,1,3.95);



### Creating a Copy of the Table ###
-- In the copy, the primary key, auto_increment is deleted
CREATE TABLE orders_archieved AS
    SELECT * FROM orders;

TRUNCATE TABLE orders_archieved; -- To delete all the rows from the table


INSERT INTO orders_archieved
SELECT * FROM orders  -- Sub query
WHERE order_date < '2019-01-01';

#Exercise
-- Question: Watch Video
-- Answer:
USE sql_invoicing;

CREATE TABLE invoice_archieved as
select i.invoice_id,
       i.number,
       c.name,
       invoice_total,
       payment_date
       from invoices i
JOIN sql_invoicing.clients c on c.client_id = i.client_id
JOIN sql_invoicing.payments p on p.invoice_id = i.invoice_id
WHERE i.payment_date is not null;

### Updating a Single Row ###
USE sql_invoicing;

UPDATE invoices
SET payment_total = 10, payment_date='2019-03-01'
WHERE invoice_id=1;

UPDATE invoices
SET payment_total = DEFAULT, payment_date=NULL
WHERE invoice_id=1;

UPDATE invoices
SET payment_total = invoice_total*0.5,
    payment_date=due_date
WHERE invoice_id=3;


### Updating Multiple Rows ###
-- MySQL works on safe update mode, so it will give you an warning
-- But if you are using other software, it won't
-- In order to turn off safe update mode, Go to
-- MySQL Workbench => Edit => Preference => SQL Editor => Tick off the safe update mode
-- Exit workbench and reopen it again

UPDATE invoices
SET payment_total = invoice_total*0.5,
    payment_date=due_date
WHERE client_id=3;   -- multiple client id

UPDATE invoices
SET payment_total = invoice_total*0.5,
    payment_date=due_date
WHERE client_id IN (3,4);   -- multiple client id

-- If you want to update all the records when REMOVE 'where' clause
-- Though, it will give you a warning
UPDATE invoices
SET payment_total = invoice_total*0.5,
    payment_date=due_date;

#Exercise
-- Write a SQL statement to
-- give any customers born before 1990
-- 50 extra points
USE sql_store;
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';


### Using Subqueries in Updates ###

-- While using subqueries, execute the subquery first, then the main query to look at the result of the sub query

-- Let's say the programmer don't know the id but he/she know the name of the client
-- whose value is to be updated
-- How to do it?
-- You can achieve this task by using subqueries
USE sql_invoicing;

UPDATE invoices
SET payment_total = invoice_total*0.5,
    payment_date=due_date
WHERE client_id =
      ( SELECT client_id from clients
        WHERE name='Myworks');

#Exercise
-- Look at the orders table. There are many 'comments' rows will NULL value. Convert it to GOLD
-- if the customer has more than 3000 points
USE sql_store;

UPDATE orders
SET comments = 'GOLD'
WHERE customer_id IN (SELECT customer_id from customers WHERE points > 3000);
--               Here, we used IN because, we had multiple records


### Deleting Rows ###
USE sql_invoicing;
-- DELETE FROM invoices; = This will delete all the records from the table

DELETE FROM invoices
WHERE invoice_id=1;


DELETE FROM invoices
WHERE client_id = ( SELECT client_id FROM clients WHERE name = 'Myworks');

/*  DELETE FROM invoices
    WHERE client_id = (
    SELECT * FROM clients    -- SIR mistake
    WHERE name = 'Myworks');
 */


### Restoring the Databases
-- It means, again running the script of CREATION of DATABASES so that it restore in the same state as before

