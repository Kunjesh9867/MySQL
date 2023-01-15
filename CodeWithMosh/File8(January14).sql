###### Essential MySQL Functions ######

### Numeric Functions ###

-- ROUND() = ROUND(value) or ROUND(value,precision)
SELECT ROUND(3.72);
SELECT ROUND(5.7345,2);

-- TRUNCATE() = TRUNCATE(value)
SELECT TRUNCATE(5.7345,2);

-- CEILING() OR CEIL() = greater than or equal to
SELECT CEIL(5.1);

-- FLOOR() = smaller than or equal to
SELECT FLOOR(5.2);

-- ABS()
SELECT ABS(-5.2);

-- RAND() = to generate a random floating point number
SELECT RAND();

-- These are the common ones: If you want to learn more search "mysql numeric functions"

### String Functions ###

-- LENGTH() = to get the number of characters
SELECT LENGTH('kunjesh');

-- UPPER() = convert to uppercase
SELECT UPPER('sky');

-- LOWER() = convert to lowercase
SELECT LOWER('Sky');

-- LTRIM() = Left Trim
SELECT LTRIM('    Kunjesh');

-- RTRIM() = Right Trim
SELECT RTRIM('Kunjesh         ');

-- TRIM() = Left+Right
SELECT TRIM('   Kunjesh   ');

-- LEFT(string, start, stop)
SELECT LEFT('Kindergarten',4);

-- RIGHT(string, start, stop)
SELECT RIGHT('Kindergarten',6);

-- SUBSTRING()
SELECT SUBSTRING('Kindergarten',3,5);  -- start from 3 till 5
SELECT SUBSTRING('Kindergarten',3);  -- start from 3 till end

-- LOCATE() = gives you the 1st occurrence of the character
-- NOTE: It is case-sensitive
SELECT LOCATE('n','Kindergarten');

SELECT LOCATE('q','Kindergarten');  -- 0 = If string does not exists in the string

SELECT LOCATE('garten','Kindergarten'); -- 7

-- REPLACE(string, old string, new string)
SELECT REPLACE('Kindergarten','garten','garden');  -- Kindergarden
SELECT REPLACE('Kindergarten','gartn','garden');  -- Kindergarten

-- CONCAT()
SELECT CONCAT('Kunjesh','Ramani');
SELECT CONCAT('Kunjesh',' ','Ramani');
SELECT 'Kunjesh'+'Ramani';  -- 0

-- These are the common ones: If you want to learn more search "mysql string functions"

### Date Functions ###

-- NOW() = to get current date and time
SELECT NOW() AS 'Current time and date';

-- CURDATE() = to get current date
SELECT CURDATE();

-- CURTIME() = to get current Time
SELECT CURTIME();

SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT DAY(NOW());
SELECT HOUR(NOW());
SELECT MINUTE(NOW());
SELECT SECOND(NOW());
SELECT DAYNAME(NOW());
SELECT MONTHNAME(NOW());

SELECT EXTRACT(YEAR FROM NOW());


#Exercise
-- Screenshot
use sql_store;
SELECT * FROM orders
WHERE YEAR(order_date) = YEAR(NOW());


### Formatting Date & Times Functions ###
#  2019-03-11
SELECT NOW();
SELECT DATE_FORMAT(NOW(),'%y');  -- YY
SELECT DATE_FORMAT(NOW(),'%Y');  -- YYYY
SELECT DATE_FORMAT(NOW(),'%m %Y');  -- MM YYYY
SELECT DATE_FORMAT(NOW(),'%M %Y');  -- StringName YYYY
SELECT DATE_FORMAT(NOW(),'%M %d %Y');  -- StringName 14 YYYY
SELECT DATE_FORMAT(NOW(),'%M %D %Y');  -- StringName 14th YYYY

SELECT TIME_FORMAT(NOW(), '%H:%i %p');   -- %p = PM
-- These are the common ones: If you want to learn more search "mysql date functions"


### Calculating Date & Times ###
SELECT DATE_ADD(NOW(),INTERVAL 1 YEAR ); -- 1 year ahead
SELECT DATE_ADD(NOW(),INTERVAL -1 YEAR ); -- 1 year behind
SELECT DATE_SUB(NOW(),INTERVAL 1 YEAR ); -- 1 year behind

-- Difference between 2 dates = VERY IMP
SELECT DATEDIFF('2022-02-05','2022-01-01'); -- 35 (difference in days)
SELECT DATEDIFF('2022-02-05 09:00','2022-01-01 17:00'); -- 35 (difference in days) It does not include time!

-- Swap the order = negative value
SELECT DATEDIFF('2022-01-01','2022-02-05'); -- 35 (difference in days)


SELECT TIME_TO_SEC('09:00');

SELECT TIME_TO_SEC('09:00') - TIME_TO_SEC('09:02');


### The IFNULL and COALESCE Functions ###
USE sql_store;

SELECT order_id,
       IFNULL(shipper_id, 'not assigned') AS shipper
       FROM orders;

SELECT order_id,
       COALESCE(shipper_id,comments,'not assigned')
       FROM orders;
-- In the COALESCE, you can add another column from the table as the value
-- Here, comments column


#Exercise
-- Question = Output
SELECT CONCAT(first_name,' ',last_name) AS customer,
       IFNULL(phone, 'Unknown') AS phone
    FROM customers;


### The IF Functions ###
USE sql_store;
SELECT order_id,
       order_date,
       IF( YEAR(order_date)=YEAR(NOW()), 'Active', 'Archieved' ) AS category
    FROM orders;

#Exercise
SELECT product_id,
       name,
       (SELECT COUNT(product_id) FROM order_items
        WHERE products.product_id = order_items.product_id) AS orders,
    IF((SELECT orders)=1,'Once','Many times') AS frequency
    FROM products
WHERE product_id IN (SELECT product_id FROM order_items);

-- You can also use joint


### The CASE operator ###
USE sql_store;
SELECT order_id,
       CASE
           WHEN YEAR(order_date) = YEAR(NOW()) THEN 'Active'
           WHEN YEAR(order_date) = YEAR(NOW())-1 THEN 'Last Year'
           WHEN YEAR(order_date) < YEAR(NOW()) THEN 'Archieved'
           ELSE 'Future'
      END AS category
    FROM orders;


#Exercise
-- Question = output
SELECT CONCAT(first_name,' ',last_name) AS customers,
       points,
       CASE
           WHEN points > 3000 THEN 'Gold'
           WHEN (points >= 2000 AND points <=3000)  THEN 'Silver'
           ELSE 'Bronze'
      END AS category
    FROM customers
ORDER BY points DESC ;


