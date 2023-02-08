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

### Parameters
DELIMITER $$
CREATE PROCEDURE get_clients_by_state(state CHAR(2)) -- varchar
-- If there are multiple parameters, th,en you have to separate it by ,
BEGIN
    SELECT * FROM clients c
    WHERE c.state = state;
END$$

DELIMITER ;

CALL get_clients_by_state('CA');
-- If you don't provide a parameter, it will raise an error
-- Parameter are compulsory

#Exercise
-- Write a stored procedure to return invoices for a given client
-- get_invoices_by_client

DELIMITER $$
CREATE PROCEDURE get_invoices_by_client(client_id INT)
BEGIN
    SELECT * FROM invoices i
    WHERE i.client_id = client_id;
END$$

DELIMITER ;

CALL get_invoices_by_client(1);

# Paramerer with default values
USE sql_invoicing;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state2(state char(2))
BEGIN
    IF state IS NULL THEN
        SET state = 'CA';
    END IF;

    SELECT * FROM clients c
    WHERE state = c.state;
END $$

DELIMITER ;

CALL get_clients_by_state2(NULL);
-- When NULL is given as a parameter, it will show output with state=CA


-- We can also use IF/ELSE to separate multiple statements
DELIMITER //
CREATE PROCEDURE get_clients_by_state2(state char(2))
BEGIN
    IF state IS NULL THEN
        SELECT * FROM clients;
    ELSE
        SELECT * FROM clients c
        WHERE c.state = state;
    END IF;
END //

DELIMITER ;

DROP PROCEDURE get_clients_by_state2;
CALL get_clients_by_state2(NULL);
CALL get_clients_by_state2('CA');

-- Beautiful, however this approach is verbose
-- We can combine IF ELSE block in the single query

DELIMITER //
CREATE PROCEDURE get_clients_by_state2(state char(2))
BEGIN
    SELECT * FROM clients c
        WHERE c.state = IFNULL(state,c.state);    -- c.state = c.state ==> 1=1
END //

DELIMITER ;

#Exercise
-- Write a stored procedure called get_payment
-- with two parameters

-- client_id => int
-- payment_method_id => tinyint


DELIMITER //
CREATE PROCEDURE get_payments(client_id INT, payment_method_id TINYINT)
BEGIN
	SELECT * FROM payments p
    WHERE p.client_id = IFNULL(client_id, p.client_id) AND
		p.payment_method = IFNULL(payment_method_id, p.payment_method);
END //

DELIMITER ;

CALL get_payments(NULL,NULL);

# Parameter Validator
USE sql_invoicing;

DELIMITER //
CREATE PROCEDURE make_payment(invoice_id INT, payment_amount DECIMAL(9,2), payment_date DATE)
BEGIN
    UPDATE invoices i
    SET
        i.payment_total = payment_amount,
        i.payment_date = payment_date
    WHERE i.invoice_id = invoice_id;

END //

DELIMITER ;

DROP PROCEDURE make_payment;

CALL make_payment(2,100,'2019-01-01');

