# INDEXING FOR HIGH PERFORMANCE.
/*

Indexing are extremely important in large databases and high traffic website
Download 1oad_1000_customers.sql

Database Management System uses indexes to find the data in the table
just like telephone diary

The data of the index is stored in MEMORY
The data of the table is stored in DISK

Reading data from the MEMORY is easier/fast than the DISK

COST OF INDEXES
(1) Increase the database
(2) Slow down the writes[update,delete] (That's why we reserve the index for Performance Critical queries)

Design indexes based on your queries, not your tables.

*/

# (3) CREATING INDEXES
USE sql_store;
SELECT customer_id FROM customers
WHERE state='CA';

-- To ask the SQL, how does it fetch the result, simply type EXPLAIN
EXPLAIN SELECT customer_id FROM customers
WHERE state='CA';
-- Above, we only have to look to `type` and `key`

CREATE INDEX idx_state
ON customers(state);

EXPLAIN SELECT customer_id FROM customers
WHERE state='CA';
-- By running the above query, the type and key is changed.

# Exercise
-- Write a query to find customers with more than 1000 points
-- Use `explain` to show how many records does the sql fetch
-- Create index and see how many records does the sql fetch
SELECT * FROM customers
WHERE points > 1000;

EXPLAIN
SELECT customer_id FROM customers
WHERE points > 1000;

CREATE INDEX idx_points
ON customers (points);

-- To drop a INDEX
DROP INDEX idx_points ON customers;


# (4) VIEWING INDEXES

-- To view all the index in a particular table
SHOW INDEXES IN customers;
-- When you run the above query, their you will find Key_name = Primary key.
-- This is the index created by primary key
-- MySQL generate the index of primary key automatically so that it can fetch teh records easily/faster
-- PRIMARY KEY index is also called CLUSTER INDEX.


ANALYZE TABLE customers;
-- Use of Analyze is analyze SQL performance,
--                          identify and compare different optimizer approaches,
--                           and edit SQL statements for optimal performance--in some cases, automatically.

SHOW INDEXES IN customers;
/*
Run the above query query, look at Index_type, it's BTREE = Binary TREE
We can also see the indexes in the left side
*/


# (5) PREFIX INDEXES
/*
Index of INT<FLOAT is better than CHAR,VARCHAR,TEXT,BLOB
Because the other contains a lot of number
Smaller index is better because they can fit in memory
*/

/*
Most of the time, we only have to compare few character from char,varchar
In that case, we can use
*/

CREATE INDEX idx_lastname ON customers (last_name(20)); -- lastname is VARCHAR
-- Compulsory = TEXT, BLOB
-- Not-Compulsory = CHAR, VARCHAR

SELECT
    COUNT(DISTINCT LEFT(last_name,1)),
    COUNT(DISTINCT LEFT(last_name,5)),
    COUNT(DISTINCT LEFT(last_name,10))
FROM customers;
/*
By running the above query,we can only see slight difference in 5 and 10 characters
So 5 is the optimal length to get the maximum distinct records
*/

# (6) FULL-TEXT INDEXES
/*
Run the create-db-blog.sql
*/

USE sql_blog;
SELECT * FROM sql_blog.posts

-- Let's say we have to search for `react redux` in the column
SELECT * FROM posts
WHERE title LIKE '%react redux%' OR body LIKE '%react redux%';

/*
There is a problem in the above query.
If the `react redux` is found in the string then it will it.
But what if we need just `react` or just `redux`
It won't show it
*/

/*
Search engines like google does not use  */





