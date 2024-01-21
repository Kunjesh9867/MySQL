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

use sql_invoicing;
select * from invoices;


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
-- If there are multiple parameters, then you have to separate it by ,
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

# Parameter with default values
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

#--------------------------------#
/*
    The syntax for the IF-THEN-ELSE statement in MySQL is:

IF condition1 THEN
   {...statements to execute when condition1 is TRUE...}

[ ELSEIF condition2 THEN
   {...statements to execute when condition1 is FALSE and condition2 is TRUE...} ]

[ ELSE
   {...statements to execute when both condition1 and condition2 are FALSE...} ]
END IF;

*/
#--------------------------------#

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


-- GOOD CONCEPT OF USING 'IFNULL'
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

-- What if we pass a negative value to the payment_amount column,
-- Will it be added
-- YES! but it shouldn't
CALL make_payment(2,-100,'2019-01-01');

-- This is not GOOD
-- We shouldn't store invalid data in the column

DELIMITER //
CREATE PROCEDURE make_payment(invoice_id INT, payment_amount DECIMAL(9,2), payment_date DATE)
-- SIGNAL means throwing an exception just like in programming language

    BEGIN
    IF payment_amount <= 0 THEN
        SIGNAL SQLSTATE '22003' SET MESSAGE_TEXT = 'Invalid payment amount';
    END IF;

    UPDATE invoices i
    SET
        i.payment_total = payment_amount,
        i.payment_date = payment_date
    WHERE i.invoice_id = invoice_id;
END //
DELIMITER ;

-- If the payment_amount is less than 0 => It will throw the ERROR and rest of the stored procedure will not be executed.

-- It is good not to write all the validation in the procedure
-- Because it will hard to maintain in the future
-- Keep your validation logic to the bare minimum otherwise stored procedure will be bloated and necessary

-- Let's say you entered NULL in the column, but MySQL will automatically reject it because the datatype is INT


### OUTPUT PARAMETERS
-- In the output we can define the output variable in the parameter section
-- NOTE = not input but output
DELIMITER $$
CREATE PROCEDURE get_unpaid_invoices_for_clients(
        client_id INT,
        OUT invoices_count  INT,
        OUT invoices_total DECIMAL(9,2))

    BEGIN
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
        FROM invoices i
        WHERE i.client_id = client_id
        AND payment_total = 0;
END $$
DELIMITER ;

-- query = Run all the at once
SET @invoices_count = 0;
SET @invoices_total= 0;
CALL get_unpaid_invoices_for_clients(5, @invoices_count, @invoices_total);
SELECT @invoices_count, @invoices_total;


### Variables
-- User or session variables
-- This variable stays till session ends
SET @invoices_count = 0;

-- Setting the datatype is OPTIONAL
/*
DECLARE invoices_count INT;
SET invoices_count = 0;
*/

-- In MySQL we also have another kind of variable called
-- LOCAL Variable
-- This variable don't stay in the memory for the entire user session
-- We have to declare a variable right after BEGIN
USE sql_invoicing;

DELIMITER $$
CREATE PROCEDURE get_risk_factor()
BEGIN
    DECLARE risk_factor DECIMAL(9,2) DEFAULT 0; -- If DEFAULT is not given, then NULL
    DECLARE invoices_total DECIMAL(9,2);
    DECLARE invoices_count INT;

    SELECT COUNT(*), SUM(invoices_total)
    INTO invoices_count, invoices_total
    FROM invoices;

    SET risk_factor = invoices_total/invoices_count * 5;

    SELECT risk_factor;
    -- risk_factor = invoices_total / invoices_count * 5
END $$
DELIMITER ;

DROP PROCEDURE get_risk_factor;
CALL get_risk_factor();


### Functions
-- So far, we have seen many of the build in function in MySQL
-- Like MIN,MAX,SUBSTRING,NOW
-- You can create your own function now
-- Function can only returns a single value/atom value
-- Unlike Stored Procedure which returns multiple values

-- Syntax

DELIMITER $$
CREATE FUNCTION get_risk_factor_for_clients(client_id INT) RETURNS INTEGER

-- DETERMINISTIC = When the data is static like tax in the order
READS SQL DATA
-- MODIFIES SQL DATA

BEGIN
    DECLARE risk_factor DECIMAL(9,2) DEFAULT 0; -- If DEFAULT is not given, then NULL
    DECLARE invoices_total DECIMAL(9,2);
    DECLARE invoices_count INT;

    SELECT COUNT(*), SUM(invoices_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id ;

    SET risk_factor = invoices_total/invoices_count * 5;

    -- risk_factor = invoices_total / invoices_count * 5
#     RETURN risk_factor;
    RETURN IFNULL(risk_factor,0);
END $$
DELIMITER ;


SELECT client_id, name, get_risk_factor_for_clients(client_id) AS risk_factor
    FROM clients;

-- To drop a function
DROP FUNCTION IF EXISTS get_risk_factor_for_clients;


### Other Conventions
-- There are various convention used in the database and programming language
-- Some of them are:
-- procGetRiskFactor
-- getRiskFactor
-- get_risk_factor

-- DELIMITER $$
-- DELIMITER //

