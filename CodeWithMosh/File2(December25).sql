-- To Select a database
USE sql_store;

### BETWEEN operator ###
-- Let's say we want to include all the customers whose points are between 1000 and 3000
SELECT * FROM customers
WHERE points>=1000 AND points<=3000;

SELECT * FROM customers
WHERE points BETWEEN 1000 AND 3000;

-- Both the above query generates the same result

#Exercise
-- Return the customers born between 1/1/1990 and 1/1/2000

SELECT * FROM customers
WHERE birth_date >= '1990-1-1' AND birth_date <= '2000-1-1';
--                   1990-01-01                   2000-01-01

SELECT * FROM customers
WHERE birth_date BETWEEN '1990-1-1' AND '2000-1-1';


### LIKE operator ###
-- LIKE operator is used for matching patterns
SELECT * FROM customers
WHERE last_name LIKE 'b%';    -- lastname starts with b

SELECT * FROM customers
WHERE last_name LIKE '%b%';    -- lastname with any number of character before or after 'b'

SELECT * FROM customers
WHERE last_name LIKE '%y';    -- lastname ends with y

SELECT * FROM customers
WHERE last_name LIKE '_____y';    -- lastname with any 5 character and y at the last

-- % any number of characters
-- _ single character

#Exercise 1
-- Get the customers whose addresses contains TRAIL or AVENUE
SELECT * FROM customers
WHERE address like '%TRAIL%' OR
      address like '%AVENUE%';

-- Get the customers whose phone number ends with 9
SELECT * FROM customers
WHERE phone LIKE '%9';

-- Get the customers whose phone number not ends with 9
SELECT * FROM customers
WHERE phone NOT LIKE '%9';


###### REGEXP ######   Tip: NO SPACES between the REGEXP
SELECT * FROM customers
WHERE last_name LIKE '%field%';
-- The same output of the above query can be obtain by using REGEXP

SELECT * FROM customers
WHERE last_name REGEXP 'field';

SELECT * FROM customers
WHERE last_name REGEXP '^field';   -- must starts with field

SELECT * FROM customers
WHERE last_name REGEXP 'field$';   -- must ends with field

SELECT * FROM customers
WHERE last_name REGEXP 'field|mac';   -- must have field or mac in the word

SELECT * FROM customers
WHERE last_name REGEXP 'field|mac|rose';   -- must have field, mac, or rose  in the word

SELECT * FROM customers
WHERE last_name REGEXP '^field|mac$|rose';   -- must have field(at the start), mac(at the end) or rose in the word

SELECT * FROM customers
WHERE last_name REGEXP '[gim]e'; -- ge , ie , me

SELECT * FROM customers
WHERE last_name REGEXP 'e[fmq]'; -- ef , em , eq

SELECT * FROM customers
WHERE last_name REGEXP '[a-h]e';  -- [abcdefgh]e (Problem here is that it is very verbose)


#Exercise
-- Get the customer whose

-- firstnames are ELKA or AMBUR
SELECT * FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';

-- lastnames ends with EY or ON
SELECT * FROM customers
WHERE last_name REGEXP 'EY$|ON$';

-- lastnames starts with MY or contains SE
SELECT * FROM customers
WHERE last_name REGEXP '^MY|SE';

-- lastnames contain B followed by R or U
SELECT * FROM customers  -- 1st
WHERE last_name REGEXP 'B[RU]';

SELECT * FROM customers  -- 2nd
WHERE last_name REGEXP 'BR|BU';

-- Above both are valid solution, but prefer the first one because when there are range then first one works well


### IS NULL operator (Absence of Value)
SELECT * FROM customers
WHERE phone IS NULL;
--          IS NOT NULL

#Exercise
-- Get the orders that are not shipped
SELECT * FROM orders
WHERE shipper_id IS NULL;

### ORDER BY clause ###
SELECT first_name,last_name FROM customers
ORDER BY state, first_name DESC;
--       ascending, descending
-- One of the MySQL feature which separate it from other DBMS
-- is that you can order the data by any column(whether or not it is included in your SELECT statement)

SELECT * FROM customers;
SELECT first_name, last_name, 10 AS points FROM customers
ORDER BY points, first_name DESC;

SELECT first_name, last_name, 10 AS points FROM customers
ORDER BY 1,2;
-- Here 1 is the first column in SELECT statement and 2 is the second column.
-- It should be avoided in the real time because
-- in future if someone add column at the 1st position then the SQL will sort it by that new column

#Exercise
-- Question = Screenshot (Desired Output)
-- Answer is below:
SELECT * FROM order_items;
SELECT order_id,product_id,quantity,unit_price FROM order_items
WHERE order_id = 2
ORDER BY (quantity*unit_price) DESC;


### LIMIT clause (It is used to limit the number of rows)
# LIMIT clause is always put at the end of the query

SELECT * FROM customers
LIMIT 5;

SELECT * FROM customers
LIMIT 300; -- If LIMIT is greater than the total rows then we will get all the rows

--  page 1: 1-3
--  page 2: 4-6
--  page 3: 7-9

SELECT * FROM customers
LIMIT 6,3;
--   offset, Number of record to be fetched
--  offset: Skip record (here 6)

#Exerecise
-- Get the top three loyal customers
SELECT * FROM customers
ORDER BY points DESC
LIMIT 3;

SELECT * FROM customers
ORDER BY points DESC
LIMIT 0,3;
-- Both the above query produces the same result
