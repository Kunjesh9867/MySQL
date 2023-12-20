### LOGICAL OPERATOR ###
-- NOT EQUAl (!=)
SELECT * FROM books
WHERE released_year != 2017;

-- NOT LIKE
SELECT * FROM books
WHERE title NOT LIKE '% %';


-- GREATER THAN (>)
SELECT 1 = NULL; -- NULL, if the value is not present => NULL
SELECT 1 > NULL; -- NULL
SELECT 80 > 40;  -- 1, SQL don't have TRUE/FALSE instead 1/0

SELECT * FROM books
WHERE released_year > 2000;

-- LESS THAN (<)
SELECT * FROM books
WHERE released_year < 2000;

-- -- GREATER/EQUAL (>=) && LESS/EQUAL (<=)
SELECT * FROM books
WHERE released_year >= 2000;

-- LOGICAL AND (AND)
SELECT * FROM books
WHERE author_lname = 'Eggers' AND released_year > 200;

-- LOGICAL OR (OR)
SELECT * FROM books
WHERE author_lname = 'Eggers' OR released_year > 200;

-- BETWEEN (Both the values are inclusive) / NOT BETWEEN
SELECT title, released_year from books
WHERE released_year BETWEEN 2000 AND 2010;

SELECT title, released_year from books
WHERE released_year NOT BETWEEN 2000 AND 2010;

-- Comparing Dates
SELECT * FROM people
WHERE YEAR(birthdate) < 2005;

-- CAST
SELECT * FROM people WHERE birthtime
BETWEEN CAST('12:00:00' AS TIME) AND CAST('16:00:00' AS TIME);

SELECT CAST('1990-01-01' AS TIME); -- null
SELECT CAST('1990-01-01' AS DATE); -- 1990-01-01
SELECT CAST('1990-01-01' AS INT); -- error
SELECT CAST(412.651 AS INT); -- error

-- IN/NOT IN
SELECT * FROM books
WHERE author_lname IN ('Lahiri', 'Gaiman');

SELECT * FROM books
WHERE author_lname NOT IN ('Lahiri', 'Gaiman');

-- %
SELECT title, released_year FROM books
WHERE released_year >= 2000
AND released_year % 2 = 1;

-- CASE = HackerRank = It goes from top to bottom
SELECT title, released_year,
    CASE
        WHEN released_year >=2000 THEN 'modern lit'
        ELSE '20th century lit'
    END AS Genre
FROM books;

-- IS NULL
SELECT  * FROM books
WHERE author_lname IS NULL;


### Exercise ###
SELECT 10!=10; -- 0
SELECT 15 > 14 AND 99 -5 <= 94; -- 1
SELECT 1 IN (5,3) OR 9 BETWEEN 8 AND 10;   -- 1

SELECT * FROM books
WHERE released_year < 1980;

SELECT * FROM books
WHERE author_lname IN ('Eggers', 'Chabon');

SELECT * FROM books
WHERE author_lname = 'Lahiri'  AND released_year > 2000;

SELECT * FROM books
WHERE pages BETWEEN 100 and 200;

SELECT * FROM books
WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';


SELECT title, author_lname,
       CASE
           WHEN title LIKE '%stories%' THEN 'Short Stories'
           WHEN title LIKE '%Just Kids%' OR title LIKE 'A Heartbreaking Work' THEN 'Memoir'
           ELSE 'Novel'
       END AS TYPE
FROM books;


SELECT author_fname, author_lname,
       CASE
           WHEN COUNT(*) > 1 THEN CONCAT(COUNT(*), ' books')
           ELSE CONCAT(COUNT(*), ' book')
       END
       FROM books
GROUP BY author_fname, author_lname;

