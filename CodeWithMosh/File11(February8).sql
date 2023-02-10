 ### Trigger and Events ###


### (1) TRIGGERS
/*
    Trigger
    (1) A block of SQL code that automatically get executed before or after an insert, update or delete statement.
    (2) Quite often, we use trigger for data consistency
*/

USE sql_invoicing;

DELIMITER $$
CREATE TRIGGER payments_after_insert
    AFTER INSERT ON payments
--  BEFORE (UPDATE/DELETE)
    FOR EACH ROW
BEGIN
    UPDATE invoices
        SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$
DELIMITER ;

-- Insert statement for the above trigger
INSERT INTO payments
VALUES (DEFAULT, 5, 3, '209-01-01',100,1);

/*
    Note:
    (1) In the Trigger, We can update data of any table
    Except the table we are working in
    HERE payments

*/


#Exercise#
-- Create a trigger that gets fired when we
-- delete a payment

USE sql_invoicing;

DELIMITER $$
CREATE TRIGGER payments_after_trigger
    AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
    UPDATE invoices
        SET payment_total = payment_total - OLD.amount
        WHERE invoice_id = OLD.invoice_id;
END $$
DELIMITER ;


-- Delete statement for the above trigger
-- (1)
DELETE FROM payments
WHERE payment_id = 9;
-- (2)
DELETE FROM payments
WHERE payment_id = 10;


### (2) VIEWING TRIGGERS

SHOW TRIGGERS; -- To get all the triggers in the database
SHOW TRIGGERS LIKE 'payments%'; -- To match a pattern
-- CONVENTIONS: tableName_after_insert



### (3) DROPPING TRIGGERS
DROP TRIGGER payments_after_insert;
DROP TRIGGER IF EXISTS payments_after_insert;

-- Conventions followed by the companies FAANG
DELIMITER $$
DROP TRIGGER IF EXISTS payments_after_trigger;  -- This is the added line of code
CREATE TRIGGER payments_after_trigger
    AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
    UPDATE invoices
        SET payment_total = payment_total - OLD.amount
        WHERE invoice_id = OLD.invoice_id;
END $$
DELIMITER ;

### (4) USING TRIGGERS FOR AUDITING

/*
Auditing in databases refers to the process of monitoring and tracking the activities that are performed on a database, including data modifications, access, and security events. The purpose of auditing is to maintain a record of these activities for purposes such as compliance, security, and troubleshooting.

The data collected during auditing can be used for a variety of purposes, such as:

Ensuring compliance with regulatory requirements
Detecting and preventing unauthorized access to sensitive data
Detecting and investigating security incidents
Troubleshooting problems with database performance or functionality
Evaluating the performance of database administrators and other users
Database auditing typically involves recording information such as the date and time of the activity, the user who performed the activity, and the type of activity performed. The information collected during auditing can be stored in a separate log or audit trail, which can be analyzed to gain insights into the activities performed on the database.

Most modern databases have built-in auditing features, which allow administrators to specify which activities to audit and to configure the auditing settings as needed. In addition, there are also specialized auditing tools and solutions available that can provide more advanced auditing capabilities, such as real-time monitoring, alerts, and reporting.

*/


USE sql_invoicing;

CREATE TABLE payments_audit
(
	client_id 		INT 			NOT NULL,
    date 			DATE 			NOT NULL,
    amount 			DECIMAL(9, 2) 	NOT NULL,
    action_type 	VARCHAR(50) 	NOT NULL,
    action_date 	DATETIME 		NOT NULL
);

-- (1)
DELIMITER $$
DROP TRIGGER IF EXISTS payments_after_insert;
CREATE TRIGGER payments_after_insert
    AFTER INSERT ON payments
--  BEFORE (UPDATE/DELETE)
     FOR EACH ROW
BEGIN
    UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;

    INSERT INTO payments_audit VALUES (NEW.client_id, NEW.date, NEW.amount, 'Insert',NOW());
END $$
DELIMITER ;

-- (2)
DELIMITER $$
DROP TRIGGER IF EXISTS payments_after_delete;
CREATE TRIGGER payments_after_delete
    AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
    UPDATE invoices
        SET payment_total = payment_total - OLD.amount
        WHERE invoice_id = OLD.invoice_id;

        INSERT INTO payments_audit VALUES (OLD.client_id, OLD.date, OLD.amount,'Delete',NOW());
END $$
DELIMITER ;


-- Insert statement for the above trigger
INSERT INTO payments
VALUES (DEFAULT,5,3,'2019-01-01',10,1);

-- Delete statement for the above trigger
DELETE FROM payments
WHERE payment_id = 11;



### (5) EVENTS
/*
    (1)What is a Event?
    A task (or block of SQL code) that gets executed according to a schedule
    For Example: Everyday at 10am or once a month or once a year
*/

-- To see all the system variable in MySQL
SHOW VARIABLES;
SHOW VARIABLES LIKE 'event%'; -- event_scheduler

-- By default, event_scheduler is ON but if it is turned OFF then do the following
SET GLOBAL event_scheduler = ON;
-- It is OFF to save the resources of your PC

DELIMITER $$
CREATE EVENT yearly_delete_stale_audit_rows  -- It is good practice to start the EVENT with yearly, monthly, daily, hourly
ON SCHEDULE
    -- AT '2019-05-01'
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'   -- From starts it's optional
DO BEGIN
    DELETE FROM payments_audit
        WHERE action_date < NOW() - INTERVAL 1 YEAR;
    -- To delete all the records before 1 year
END $$
DELIMITER ;

### (6) VIEWING, DROPPING AND ALTERING EVENTS

-- To view all the events
SHOW EVENTS;

-- So when we write the EVENTS starting with daily, monthly, yearly
-- We can be able to filter the events in the future using LIKE clause
# NO HARM NO FOUL
SHOW EVENTS LIKE 'yearly%';

-- To Drop a Event
DROP EVENT yearly_delete_stale_audit_rows;
DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;

-- To alter the event
-- Syntax is same as the create event statement
 #ALTER EVENT yearly....

-- We can also ENABLE or DISABLE events using ALTER
ALTER EVENT yearly_delete_stale_audit_rows DISABLE ;

