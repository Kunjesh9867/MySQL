/*
    Database vs Database Management System
    MySQL is DBMS not database. MySQL is used to interact with database

    When you learn MySQL, you learn SQL
    (1) MySQL
    (2) SQLite
    (3) PostgreSQL
    (4) Oracle
    All the DBMS follows the rules of SQL. They are identical when writing queries.

    The difference lies in the how they work.
*/

CREATE DATABASE soap_store;
USE soap_store;
SELECT database(); -- To see which database is currently selected

SHOW TABLES;

CREATE TABLE cats (
    name VARCHAR(50),
    age INT
);

CREATE TABLE dogs (
    name VARCHAR(50),
    breed VARCHAR(50),
    age INT
);

-- All are same
SHOW COLUMNS FROM cats;
DESC cats;
DESCRIBE cats;

DROP TABLE cats; -- To remove the content & definition of table
TRUNCATE TABLE cats; -- To remove the content of table


CREATE TABLE pastries (
    name varchar(50),
    quantity int
);
DESC pastries;
DROP TABLE pastries;


-- DEFAULT and NOT NULL
CREATE TABLE cats3  (
    name VARCHAR(20) NOT NULL DEFAULT 'no name provided',
    age INT DEFAULT 99
);
-- NOT NULL and DEFAULT is together so that the value in the field cannot be 'NULL'
-- Programmer can set the value to be 'NULL' but with NOT NULL constraint, he cannot.

INSERT INTO cats3 () VALUES (); -- For all NULL values



-- CRUD
CREATE TABLE cats (
    cat_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    breed VARCHAR(100),
    age INT,
    PRIMARY KEY (cat_id)
);
INSERT INTO cats(name, breed, age)
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);

SELECT * FROM cats;

CREATE DATABASE shirts_db;
USE shirts_db;
CREATE TABLE shirts (
    shirt_id INT AUTO_INCREMENT PRIMARY KEY,
    article VARCHAR(30),
    color VARCHAR(20),
    shirt_size VARCHAR(1),
    last_worn int
);

INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES
	('t-shirt', 'white', 'S', 10),
	('t-shirt', 'green', 'S', 200),
	('polo shirt', 'black', 'M', 10),
	('tank top', 'blue', 'S', 50),
	('t-shirt', 'pink', 'S', 0),
	('polo shirt', 'red', 'M', 5),
	('tank top', 'white', 'S', 200),
	('tank top', 'blue', 'M', 15);


SELECT * FROM shirts;
SELECT article, color FROM shirts;

SELECt article, color, shirt_size, last_worn FROM shirts
WHERE shirt_size = 'M';

UPDATE shirts
SET shirt_size = 'L'
WHERE article = 'polo shirt';

-- TO SEE ALL THE WARNINGS
SHOW WARNINGS;
