#### DATATYPES ###

# CHAR & VARCHAR
/*

    CHAR is fixed length => fills the empty character with 'space'
    These spaces are right-padded (right side)
    When you apply CHAR_LENGTH, it will count the char, but the storage in memory will be different
*/
/*
    VARCHAR is variable length
*/

# NUMBER


-- (1) INTEGER (SIGNED & UNSIGNED)

-- (2)  DECIMAL(5,2) => Maximum = 5, After decimal = 2
/*
    Eg: 999.99
    What if: 5.021 => Here, 1 will be truncated => 5.02
*/

-- (3) FLOAT & DOUBLE
/*
    Float and Double is used for precision numbers
*/

-- (4) DATE & TIME & DATETIME
/*
    DATE stores only date and not time. Format: YYYY-MM-DD
    TIME stores time. Format: HH-MM-SS
    DATETIME stores date and time.
*/
CREATE TABLE people (
	name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10');

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');

SELECT * FROM people;
SELECT NOW();
SELECT CURRENT_TIMESTAMP();
SELECT CURRENT_DATE();
SELECT CURDATE();
SELECT CURRENT_TIME();
SELECT CURTIME();

SELECT DAY(birthdate) FROM people;
SELECT MONTH(birthdate) FROM people;
SELECT YEAR(birthdate) FROM people;
SELECT DAYOFMONTH(birthdate) FROM people;
SELECT DAYOFWEEK(birthdate) FROM people;
SELECT DAYOFYEAR(birthdate) FROM people;
SELECT MINUTE(birthdate) FROM people;
-- NOTE: If the information is not present, then mysql will assume current day/time information and give wrong output.

-- Formatting Date and Time
SELECT DATE_FORMAT(birthdate, '%a %b') FROM people; -- Look documentation for Extras
SELECT TIME_FORMAT(birthdate, '%a %b') FROM people; -- Works only for time

-- Sir Code
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people;

-- DATE MATH
SELECT DATEDIFF(NOW(), birthdate) FROM people;
SELECT TIMEDIFF(NOW(), birthdate) FROM people; -- NULL because time and date, NOT SAME
SELECT DATE_ADD(NOW(), INTERVAL 1 MONTH);
SELECT DATE_SUB(NOW(), INTERVAL 1 MONTH);

-- TIMESTAMP
/*
    The difference between TIMESTAMP and DATETIME is
    TIMESTAMP is fast but has very small range: '1970-01-01' to '2038-01-19'
    DATETIME is slow but has larger range

    We also have TIMEDIFF etc just like DATEDIFF
*/

-- Sir Code
CREATE TABLE captions (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP
);

CREATE TABLE captions2 (
  text VARCHAR(150),
  created_at TIMESTAMP default CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


# EXERCISE #
SELECT DATE(NOW());
SELECT DAY(NOW());
SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%m/%d/%Y');
SELECT DATE_FORMAT(NOW(), '%M %dnd at %H:%i');

### SIR Solution ###
-- What's a good use case for CHAR?

-- Used for text that we know has a fixed length, e.g., State abbreviations,
-- abbreviated company names, etc.

CREATE TABLE inventory (
    item_name VARCHAR(100),
    price DECIMAL(8,2),
    quantity INT
);

-- What's the difference between DATETIME and TIMESTAMP?

-- They both store datetime information, but there's a difference in the range,
-- TIMESTAMP has a smaller range. TIMESTAMP also takes up less space.
-- TIMESTAMP is used for things like meta-data about when something is created
-- or updated.


SELECT CURTIME();

SELECT CURDATE();

SELECT DAYOFWEEK(CURDATE());
SELECT DAYOFWEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%w') + 1;

SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%W');

SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');

SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i');

CREATE TABLE tweets(
    content VARCHAR(140),
    username VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO tweets (content, username) VALUES('this is my first tweet', 'coltscat');
SELECT * FROM tweets;

INSERT INTO tweets (content, username) VALUES('this is my second tweet', 'co    ltscat');
SELECT * FROM tweets;