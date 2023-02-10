# [Transactions & Concurrency]
-- (1) TRANSACTIONS
-- A group of SQL statements that represent a single unit of work.
-- For Example = When you transfer the money from your account to your friends  account, It has steps
-- Debit from your account & Credit to your friend accounts

-- Transactions has few properties:
-- ACID
-- Atomicity = Each transaction is single unit of work. No matter how many transaction it contains
-- Consistency = That means, with these transaction, our database will always remains in consistent state. We won't end up with an order without an item
-- Isolation = These transaction are isolated from each other and protected from each other if they try to modify the same data. So they cannot interfere with each other.
--             If multiple transaction try to update the same data, the rows that are being affected get locked, so only one transaction at a time can update those rows. Other transactions have to wait for that transaction to complete.
-- Durability = That means, once a transacion is committed the changes made by the transaction are permanent. So there is a failure or a system crash, we are not going to lose the system changes.


-- (2) CREATING TRANSACTIONS
USE sql_store;

START TRANSACTION;

INSERT INTO orders (customer_id, order_date, status)
VALUES (1,'2019-01-01',1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(),1,1,1);

COMMIT; -- ROLL BACK
-- When MySQL sees this command it will write all the changes to the database.
-- If one of the changes fails, it will automatically undue one of the previous changes, and we say that the transaction is rolled backed.

-- When we execute any query in the MySQL, it will automatically commit because by default, autocommit is ON
SHOW VARIABLES LIKE 'autocommit%'; -- SEE HERE




