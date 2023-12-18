SELECT * FROM books;

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages) VALUES
('10% Happier', 'Dan', 'Harris', 2014, 29, 256),
('fake_book', 'Freida', 'Harris', 2001, 287, 428),
('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

-- (1) DISTINCT
SELECT DISTINCT(author_lname) FROM books;
SELECT DISTINCT author_lname FROM books;

-- (2) ORDER BY: NULL comes first
# If you have multiple NULL values in the column you are sorting, their specific order relative to each other
# is not guaranteed. In other words, the database engine might not provide a specific order for rows with NULL values.
SELECT author_fname, author_lname FROM books
ORDER BY author_lname;

SELECT author_fname, author_lname FROM books
ORDER BY 2; -- author_lname

SELECT author_fname, author_lname FROM books
ORDER BY author_fname, author_lname; -- ORDER BY multiple columns

SELECT author_fname, author_lname FROM books
ORDER BY title;


-- (3) LIMIT
SELECT * FROM books
LIMIT 5;

SELECT * FROM books
LIMIT 2, 3; -- remove 2 rows & fetch 3 rows

SELECT * FROM books
LIMIT 0, 5; -- remove 0 rows & fetch 5

-- (4) LIKE
SELECT  title FROM books
WHERE title LIKE 'The%';

-- Escaping Wildcards
SELECT  title FROM books
WHERE title LIKE '%\%%';


#### EXERCISE ####
-- 1
SELECT title FROM books
WHERE title LIKE '%stories%';

-- 2
SELECT title, pages FROM books
ORDER BY pages DESC
LIMIT 1;

-- 3
SELECT CONCAT(title, ' - ', released_year) AS summary FROM books
ORDER BY released_year DESC
LIMIT 3;

-- 4
SELECT title, author_lname FROM books
WHERE author_lname LIKE '% %';

-- 5
SELECT title, released_year, stock_quantity FROM books
ORDER BY stock_quantity, released_year DESC
LIMIT 3;

-- 6
SELECT title, author_lname FROM books
ORDER BY author_lname, title;

-- 7
SELECT CONCAT('MY FAVORITE AUTHOR IS ', UPPER(author_fname), ' ', UPPER(author_lname), '!' ) 'yell' FROM books
ORDER BY author_lname;
