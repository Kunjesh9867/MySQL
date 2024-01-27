# INDEXING FOR HIGH PERFORMANCE.
/*

Indexing are extremely important in large databases and high traffic website
Download 1oad_1000_customers.sql

Indexing is the data structures that database engine uses to quickly find data.
Database Management System uses indexes to find the data in the table
just like telephone diary

The data of the index is stored in MEMORY
The data of the table is stored in DISK

Reading data from the MEMORY is easier/fast than the DISK

COST OF INDEXES
(1) Increase the database
(2) Slow down the writes[update,delete] (That's why we reserve the index for Performance Critical queries)

Design indexes based on your queries, not your tables.

Generally, indexes are stored as binary tree but in the course it is represented as Table

*/

# (3) CREATING INDEXES
USE sql_store;
SHOW TABLES;
SELECT COUNT(*) FROM customers;

SELECT customer_id FROM customers
WHERE state='CA';

-- To ask the SQL, how does it fetch the result, simply type EXPLAIN
EXPLAIN SELECT customer_id FROM customers
WHERE state='CA';
-- Above, we only have to look to `type` and `key`
CREATE INDEX idx_state -- idx is CONVENTION
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
SHOW INDEXES IN customers; -- name of the table
-- When you run the above query, their you will find Key_name = Primary key.
-- This is the index created by primary key
-- MySQL generate the index of primary key automatically so that it can fetch the records easily/faster
-- PRIMARY KEY index is also called CLUSTER INDEX.
-- PRIMARY KEY, FOREIGN KEY index = Primary Index
-- REST ALL index = Secondary Index


ANALYZE TABLE customers;
-- Use of Analyze is analyze SQL performance,
--                           identify and compare different optimizer approaches,
--                           and edit SQL statements for optimal performance--in some cases, automatically.

SHOW INDEXES IN customers;
/*
Run the above query query, look at Index_type, it's BTREE = Binary TREE
We can also see the indexes in the left side
*/


# (5) PREFIX INDEXES
/*
Index of INT,FLOAT is better than CHAR,VARCHAR,TEXT,BLOB
Because the other contains a lot of number
Smaller index is better because they can fit in memory
*/

/*
Most of the time, we only have to compare few character from char,varchar
In that case, we can use
*/

CREATE INDEX idx_lastname ON customers (last_name(20)); -- lastname is VARCHAR
-- Indexes only apply in the first 20 character and not the whole VARCHAR
-- Compulsory = TEXT, BLOB
-- Not-Compulsory = CHAR, VARCHAR


SELECT COUNT(*) FROM customers;

SELECT
    COUNT(DISTINCT LEFT(last_name,1)), -- 25 out of 1010
    COUNT(DISTINCT LEFT(last_name,5)), -- 966
    COUNT(DISTINCT LEFT(last_name,10)) -- 996
FROM customers;
/*
By running the above query,we can only see slight difference in 5 and 10 characters
So 5 is the optimal length to get the maximum distinct records
*/

-- MORE Unique Value == Better INDEX



# (6) FULL-TEXT INDEXES (Not case-sensitive)
/*
We create this to build faster and optimal search engine
Run the create-db-blog.sql
*/

USE sql_blog;
SELECT * FROM sql_blog.posts;

-- Let's say we have to search for `react redux` in the column
SELECT * FROM posts
WHERE title LIKE '%react redux%' OR
      body LIKE '%react redux%';

/*
There is a problem in the above query.
If the `react redux` is found in the string then it will it.
But what if we need just `react` or just `redux`
It won't show it
*/

/* Search engines like google does not work this way */

CREATE FULLTEXT INDEX idx_title_body ON posts(title,body);

SELECT * FROM posts
WHERE MATCH(title,body) AGAINST ('react redux');
/*
One of the beauty of fulltext index is that they includes a relevance score.
So based on a number of factors, MySQL calculates a relevancy score that contains a search phrase
The relevancy score is a floating point number between 0.0 and 1.0
0.0 means no relevance
Let's display the relevance score...
*/
SELECT *, MATCH(title,body) AGAINST ('react redux') 'Relevancy score' -- score sorted in descending order
FROM posts
WHERE MATCH(title,body) AGAINST ('react redux');

/*
Full text searches has 2 modes: natural language mode(default) && Boolean Mode.
Natural language = We are using it already
Boolean = includes or excludes certain words just like how we use Google
*/

-- Boolean Mode in action:
SELECT *, MATCH(title,body) AGAINST ('react redux') 'Relevancy score' -- score sorted in descending order
FROM posts
WHERE MATCH(title,body) AGAINST ('react -redux' IN BOOLEAN MODE); -- Includes: react , Excludes: redux

/*
    +form = must have the word form
    "Handling the form" = Exact phrase or word (enclosed in '') => '"Handling the form"'
*/

# (7) COMPOSITE INDEXES (What if we want to sort data using 2 indexes)
USE sql_store;
SHOW INDEXES IN customers;

-- lets search for customer living in california and points>1000
EXPLAIN SELECT customer_id FROM customers
WHERE state='CA' AND points>1000;
/*
By executing above query, you will find that there are 2 possible_keys but MySQL used one with state
So, no matter how many possible_keys you have, MySQL will take maximum of 1 index
*/

-- Let's create a composite index
CREATE INDEX idx_state_points ON customers(state,points); -- orders matters (will learn in next lecture)
EXPLAIN SELECT customer_id FROM customers
WHERE state='CA' AND points>1000;
-- By executing above query, you will find that there are 3 possible_keys
-- It helps in optimization

/*
In reality, most of the time, we should use composite index because a query can have multiple filters.
(Later on...) Index can helps to sort data faster.
One of the common mistake a lot of beginners make is they create a lot of separate index on each column
As you see, these indexes do half of the job, they don't helps us get the optimum performance and also they take a lot of space.
Also every time you modify a data in your table, indexes also modified => results in slower performance.
As we know that MySQL will automatically add PRIMARY KEY in the index so this single index will consume a lot of space.
In MYSQL, you can have a maximum of 16 columns (around 4-6 performs well)
*/

-- DROPPING INDEX
DROP INDEX idx_points ON customers;

# (8) ORDER Of COLUMNS in COMPOSITE INDEXES

/*
2 Basic rules: (not hard n fast)
(1) Put the frequently used column first
(2) Put the columns with a higher cardinality(number of uniques values in an index) first
[Take your queries/data into account]
*/

-- There are times where the above rules aren't efficient
-- In this case, we have to take all the data in account

EXPLAIN SELECT customer_id FROM customers
WHERE state='CA' AND last_name LIKE 'A%';

-- 1
CREATE INDEX idx_lastname_state ON customers(last_name,state);  -- 240 rows
-- 2
CREATE INDEX idx_state_lastname ON customers(state,last_name);  -- 42 rows (but it violate the rules)

-- try it on:
EXPLAIN SELECT customer_id FROM customers
WHERE state='CA' AND last_name LIKE 'A%';

/*
When you run the query, MySQL will automatically use index 2
What if we forcefully want to use index 1?
*/
EXPLAIN SELECT customer_id
FROM customers
USE INDEX (idx_lastname_state)
WHERE state='CA' AND last_name LIKE 'A%';

/*
EXPLAIN SELECT customer_id
FROM customers
USE INDEX (idx_state_lastname)
WHERE last_name LIKE 'A%';

In this case index idx_state_lastname is not better
So we have to make another index which includes JUST LASTNAME
*/

# (9) WHEN INDEXES ARE IGNORED

EXPLAIN SELECT customer_id FROM customers
WHERE state='CA' OR points>1000; -- OR
/*
FULL INDEX SCAN
It is faster than the table scan so MySQL uses it.
So how can we utilize table index?
In this situation, you have to utilize your knowledge and rewrite the query in so that it uses indexes
*/

CREATE INDEX idx_points ON customers(points);

EXPLAIN SELECT customer_id FROM customers
WHERE state='CA'
UNION
SELECT customer_id FROM customers
WHERE points>1000;
-- THis way we can utilize the indexes

EXPLAIN SELECT customer_id FROM customers
WHERE points +10 > 2010;  -- 1010

EXPLAIN SELECT customer_id FROM customers
WHERE points > 2000;  -- 4 {Isolate your query}

# (10) USING INDEXES FOR SORTING
EXPLAIN SELECT customer_id FROM customers
ORDER BY state;  -- type=index, using index = cheap

EXPLAIN SELECT customer_id FROM customers
ORDER BY first_name;  -- type=ALL, using filesort(algorithm used my MySQL to sort data) = expensive


-- Query Cost
SHOW STATUS LIKE 'Last_query_cost'; -- not working 0.000000

EXPLAIN SELECT customer_id FROM customers
ORDER BY state,points; -- Index, Low cost  LOOK AT Extra(last column) using EXPLAIN

EXPLAIN SELECT customer_id FROM customers
ORDER BY state,first_name, points; -- No index, High cost, filesort

EXPLAIN SELECT customer_id FROM customers
ORDER BY state, points DESC ; -- Using index; Using filesort

EXPLAIN SELECT customer_id FROM customers
ORDER BY state DESC,points DESC; -- Low, Backward sort

/*
(a,b)
a
a,b
a Desc, b Desc
b with 'where' clause including a
*/


# (11) COVERING INDEXES
SELECT * FROM customers
ORDER BY state; -- Expensive because all columns are not added in indexes

-- YOu can add state, customer_id(primary key index), points

# (12) INDEXES MAINTENANCE
-- Before creating new indexes, check the existing ones.

/*
Duplicate index = (A,B,C) (A,B,C)
Redundant index = (A,B) (A) = {redundant} (B,A) (B) => When people create index without looking at the existing one.

BEFORE CREATING NEW INDEXES, CHECK THE EXISTING ONES.
*/







