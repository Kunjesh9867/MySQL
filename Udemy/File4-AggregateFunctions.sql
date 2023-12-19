SELECT * FROM books;

-- (1) COUNT
SELECT COUNT(*) FROM books;
SELECT COUNT(author_fname) FROM books;
SELECT COUNT(DISTINCT author_fname) FROM books;

-- (2) GROUP BY
-- GROUP BY summarizes or aggregates identical data into single rows
SELECT author_lname FROM books;

SELECT author_lname FROM books
GROUP BY author_lname;

SELECT author_lname, COUNT(*) FROM books
GROUP BY author_lname;

-- (3) MIN & MAX
SELECT MAX(stock_quantity) FROM books;
SELECT MAX(pages) FROM books;
# SELECT MAX(pages), title FROM books
# GROUP BY title;
# Above query doesn't work



-- (4) SUB-QUERY
SELECT * FROM books
WHERE pages = (SELECT MAX(pages) FROM books); -- Correct result
-- -----------------------------------------
SELECT * FROM books
ORDER BY pages DESC
LIMIT 1; -- Only gives 1 output, what if we have 2 books with same highest pages

-- (5) GROUP BY multiple columns
SELECT author_lname, COUNT(*) FROM books
GROUP BY author_lname, author_fname;

SELECT author_fname, author_lname, COUNT(*) FROM books
GROUP BY author_lname, author_fname;

SELECT CONCAT(author_fname, ' ', author_lname) AS author , COUNT(*) FROM books
GROUP BY author;

-- (6) MIN & MAX with GROUP BY
SELECT
	author_lname,
	COUNT(*) as books_written,
	MAX(released_year) AS latest_release,
	MIN(released_year)  AS earliest_release,
      MAX(pages) AS longest_page_count
FROM books GROUP BY author_lname;

-- (7) SUM
SELECT author_fname, SUM(pages) FROM books
GROUP BY author_fname;

SELECT SUM(author_fname) FROM books; -- 0, if not number => 0


-- (8) AVG
SELECT AVG(pages) FROM books; -- RESULT is numeric with decimal

-- (9) ROUND

-- (10) REPLACE

#### EXERCISE ####
SELECT * FROM books;

-- (A)
SELECT COUNT(book_id) FROM books;

-- (B)
SELECT released_year, COUNT(book_id) FROM books
GROUP BY released_year;

-- (C)
SELECT SUM(stock_quantity) FROM books;

-- (D)
SELECT CONCAT(author_fname,' ',author_lname) AS author, AVG(released_year) FROM books
GROUP BY author;

-- (E)
SELECT CONCAT(author_fname,' ', author_lname) FROM books
WHERE pages = (SELECT MAX(pages) FROM books);

-- (F)
SELECT released_year AS 'year', COUNT(book_id), AVG(pages)  FROM books
GROUP BY year
ORDER BY year;