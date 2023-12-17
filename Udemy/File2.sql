-- STRING functions
CREATE DATABASE book_shop;
USE book_shop;
SHOW TABLES;
CREATE TABLE books
	(
		book_id INT AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

SELECT * FROM books;


-- (1) CONCAT
SELECT CONCAT(title, ' ', author_fname,author_lname) FROM books;

-- (2) CONCAT_WS
SELECT CONCAT_WS('-', author_fname,author_lname) FROM books;

-- (3) SUBSTRING or SUBSTR
SELECT SUBSTRING('Hello World', 1,5); -- Hello
--                  string, start, total_number_of_char(optional)

-- (4) CONCAT
SELECT CONCAT(SUBSTR('Kunjesh Ramani',1), '...');  -- Kunjesh Ramani...

-- (5) REPLACE = case-sensitive = It is not use to alter/update
SELECT REPLACE('Cheese Bread Coffee Milk', ' ', ' and ');

-- (6) REVERSE
SELECT REVERSE('Kunjesh'); -- hsejnuK
SELECT REVERSE('NULL'); -- NULL

-- (7) CHAR_LENGTH
SELECT CHAR_LENGTH('Kunjesh'); -- 7 = number of character

-- (8) LENGTH
SELECT LENGTH('Kunjesh'); -- 7 = number of bytes

-- (9) UPPER or UCASE
SELECT UPPER('kunjesh');
SELECT UCASE('kunjesh');

-- (10) LOWER or LCASE
SELECT LOWER('KUNJESH');
SELECT LCASE('KUNJESH');

-- (11) INSERT
SELECT INSERT('Hello Kunjesh',7 ,0,'World '); -- Hello World Kunjesh
SELECT INSERT('Hello Kunjesh', 7, 5, 'World '); -- Hello World sh

-- (12) LEFT
SELECT LEFT('Kunjesh', 1); -- K

-- (13) RIGHT
SELECT RIGHT('Kunjesh', 1); -- h

-- (14) REPEAT
SELECT REPEAT('Kunjesh',2); -- KunjeshKunjesh

-- (15) TRIM = leading & trailing = There is also a function to specific how many leading/trailing should be removed
SELECT TRIM('    kunjesh     '); -- kunjesh


-- CHALLENGE
SELECT UCASE(REVERSE('Why does my cat look at me with such hatred?'));

-- I-like-cats
SELECT DATABASE();
SHOW TABLES;
SELECT * FROM Books;

SELECT REPLACE(title, ' ', '->') 'title'  FROM books;

SELECT author_lname AS 'forwards', REVERSE(author_lname) AS 'backwards' FROM books;

SELECT UPPER(CONCAT(author_fname, ' ', author_lname)) AS 'Full name in caps' FROM books;

SELECT CONCAT(title, ' was released in ', released_year) AS 'blurb' FROM books;

SELECT title, CHAR_LENGTH(title) AS 'character count' FROM books;

SELECT CONCAT(SUBSTR(title, 1, 10), '...') AS 'short title',
    CONCAT(author_lname, ',',author_fname),
    concat(stock_quantity, ' in stock')
FROM books