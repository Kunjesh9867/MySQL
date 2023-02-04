-- STORED PROCEDURE is a database object contains a block of SQL code
-- BENEFITS:
-- Store and organize SQL
-- Faster execution
-- Data Security (can perform various operation likes inserting, updating, deleting)

USE sql_invoicing;

DELIMITER $$
CREATE PROCEDURE get_clients()   -- name is the standard format for the stored procedure, all small case seperated by _
BEGIN -- Begin to End is called the body of the stored procedure
    SELECT * FROM clients;
END$$

DELIMITER ;


-- In the above example, we only have single statement, but quite often, we will have multiple statements
-- We have to separate each statement by using ;

-- In order to execute the above statement, we have to create a delimiter so that the statement can be executed

CALL get_clients();  -- To call the procedure

-- Usually we CALL the procedure in JAVA, C#, C++, PYTHON etc.



###Exercise
-- Create a stored procedure called
-- get_invoices_with_balance
-- to return all the invoices with a balance > 0

DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
    SELECT * FROM invoices
    WHERE invoice_total > 0;
END $$

DELIMITER ;

CALL get_invoices_with_balance();


### Creating Procedure Using MySQL Workbench
-- Now you might think that creating stored procedure is very tedious in MySQL because we have to change
-- the default delimiter every time we want to create a procedure
-- Easier Way:
-- Go to Stored Procedure => right click => Create Store Procedure => in the new window, you can create a procedure without delimiter
-- SQL add `` to prevent name clash with the SQL keywords


### Drop Procedure
USE sql_invoicing;
DROP PROCEDURE IF EXISTS get_clients;

