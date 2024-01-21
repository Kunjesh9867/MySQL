-- To Select a database
USE sql_store;

# To select all the entries from a Table
SELECT * FROM customers;

# To Select all the entries from a table by giving some condition
SELECT * FROM customers
WHERE customer_id=1;

-- Selection without table
SELECT 1 First,2 Second,3;
SELECT 1,2,3;


### SELECT Clause ###

-- Performing arithmetic operation using SELECT clause
SELECT first_name,
       last_name,
       points,
       (points+10)*100 AS "discount factor"
FROM customers;

-- DISTINCT
SELECT DISTINCT state FROM customers;

#Exercise
-- Returns all the products
-- name
-- unit price
-- new price (unit price * 1.1)

SELECT name,
       unit_price,
       unit_price*1.1 AS 'new price'
FROM products;

SELECT name, unit_price, (unit_price*1.1) 'new price' FROM products;


### WHERE Clause ###

-- Where clause is used to filter the data in the table
SELECT * FROM customers
WHERE points > 3000;
-- There are various comparison operator like [> || >= || < || <= || = || != || <>]
-- When there is a STRING or DATE to compare, we use single/double quote, but by default we use ' '

### AND,OR,NOT Operators ###

-- AND = all true
-- OR = least one true
-- NOT = change the condition (true ==> false or false ==> true)

SELECT * FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA';
--                             [AND]            [OR]
-- Here, AND operator has high priority than OR operator

-- Math Trick
-- When applying NOT Change =
-- > to <=
-- < to <=
-- AND to OR
-- OR to AND
SELECT * FROM customers
WHERE NOT(birth_date > '1990-01-01' OR points > 1000);
SELECT * FROM customers
WHERE birth_date <= '1990-01-01' AND points <= 1000;


#Exercise
-- From the order_items table, get the items
-- for order #6
-- where the total price is greater than 30
SELECT * FROM order_items
WHERE order_id = 6 AND (unit_price * quantity) > 30;


### IN Operators ###
-- In Operator is used to compare in the list of value

SELECT * FROM customers
WHERE state = 'VA' OR state = 'GA' OR state = 'FL';  -- This is quite MESSY :(

SELECT * FROM customers
WHERE state IN ('VA', 'GA','FL')
ORDER BY customer_id;
--         NOT IN

#Exercise
-- Return products with
-- quantity in stock equal to 49, 38, 72
SELECT * FROM products
WHERE quantity_in_stock IN (49, 38, 72);
