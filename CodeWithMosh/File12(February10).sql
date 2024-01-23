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
-- Durability = That means, once a transaction is committed the changes made by the transaction are permanent. So there is a failure or a system crash, we are not going to lose the system changes.


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

-- (3) CONCURRENCY AND LOCKING
-- Let's say in the real world there are 2 transaction performed at a same time
-- Then the second transaction has to wait until the first one is over
-- This is called LOCKING
/*
Open Workbench
Start a Connection
Write the following Query
Open another Connection
Write the same query
start the transaction in the first connection (line by line)
don't run COMMIT;
open second transaction
Run till Commit
The second transaction has to wait because the first one is not over yet...

You can see loading symbol near your file name
It means the first transaction is not over and you have to wait

Commit First then Second
*/
USE sql_store;
START TRANSACTION;
	UPDATE customers
	SET points = points + 10
	WHERE customer_id = 1 ;
COMMIT;

-- (4) CONCURRENCY PROBLEMS
/*
There are various concurrency problem arises
(1) Lost Update = These happens when two transactions try to update the same data and you don't use lock. In these the transaction performs later will overwrite the previous transaction = WE USE LOCKS
(2) Dirty Reads = In these scenario, SS
(3) Non-repeatable Reads =
*/

-- (5) TRANSACTION ISOLATION LEVEL
-- Screenshot

SHOW VARIABLES LIKE 'transaction_isolation'; -- REPEATABLE READS

-- To change the isolation level
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED ;

-- To change the isolation level for a particular session
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- To change the isolation level for ALL session
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Generally, the developer change the isolation for a particular session
-- Do the works, then make it default

-- (6) READ UNCOMMITTED isolation level
-- Files are added READ_UNCOMMITTED_1 READ_UNCOMMITTED_2

-- (7) READ COMMITTED isolation level
-- Files are added READ_COMMITTED_1 READ_COMMITTED_2

-- (8) REPEATABLE READ isolation level
-- Files are added REPEATABLE_READ_1 REPEATABLE_READ_2

-- (8) SERIALIZABLE isolation level
-- Files are added SERIALIZABLE_1 SERIALIZABLE_2


USE sql_store;
START TRANSACTION;
UPDATE customers SET state = 1 WHERE customer_id = 1;
UPDATE orders SET status = 1 WHERE order_id = 1;
COMMIT;