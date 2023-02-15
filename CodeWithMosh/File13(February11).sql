# DATA TYPES
/*
There are various data types in MySQL
(1) String Datatype
(1) Numeric Datatype
(1) Date and Time Datatype
(1) Blob Datatype
(1) Spatial Datatype
*/

-- (2) String Data Types
-- CHAR(x) = fixed length
-- VARCHAR(x) = Maximum length is 65_535 (~64KB)
-- MEDIUMTEXT = Max: 16MB for storing json objects, cs view string, short to medium length quotes
-- LONGTEXT = Max: 4GB for storing textbook, years of log files

-- TINYTEXT = Max: 255 bytes
# TEXT = Max: 64KB

-- Mosh said to be consistence with the data types
-- Be consistent
-- VARCHAR(50) for short string like Name, Password
-- VARCHAR(255) for address

/*
    All these datatypes support BYTES
    1 Bytes for English
    2 Bytes for European Middle-eastern
    3 Bytes for Asian
*/



# [INTEGER]
/*

TINYINT 1b [-128, 127]
UNSIGNED TINYINT [0, 255]
SMALLINT 2b [-32K, 32K]
MEDIUMINT 3b [-8M, 8M]
INT Ab [-2B, 2B]
BIGINT 8b [-9Z, 9Z]

Note: Use the smallest data type that suits your needs.

*/
# [Fixed-point and Floating-point Types]

/*
DECIMAL(p,s) = precision,scale = maximum(1,65), after decimal
DECIMAL = DEC, NUMERIC, FIXED
We also have DOUBLE & FLOAT = Float and double uses approximate value

That's why in order to use exact value, we use DECIMAL

*/


# [Boolean Types]
/*
In Boolean, We have
BOOL
BOOLEAN
--------------
UPDATE CUSTOMER
WHERE product_id = TRUE  -- or FALSE
*/

# [ENUM and SET Types]
/*
ENUM('small','medium','large')
Enum are generally bad.
(1) If you want to rename members of the enum, mysql will rebuild the entire table. If you have millions of records, it will take a lot of time.
(2) Enum are not reusable,  if you want to reuse the value in another table, in that table we have to redefine the values

SET

[DATE and TIME Types]
DATE
TIME
DATETIME
TIMESTAMP (upto 2038) This is called year 2038 problem
YEAR



[Blob Types]
We use blob to store large amount of binary data like images, videos, word files, pretty much any binary data
In MySQL, we have 4 blob types, and they differ on maximum amount of data, they can store,

TINYBLOB = for storing binary data upto 255B
BLOB = for storing binary data upto 65KB
MEDIUMBLOB = for storing binary data upto 16MB
LONGBLOB = for storing binary data upto 4GB


We should avoid store binary data in the MySQL
MySQL is relational DBMS, not the binary database

PROBLEMS WITH STORING FILES IN A DATABASE

1) Increased database size
2) Slower backups
3) Performance problems
4) More code to read/write images

[Json Types]

Lightweight format for storing and transferring data over the Internet
It is used heavily in mobile and desktop applications

Creating a json object
UPDATE products
SET properties = '
{
    "dimensions": [1,2,3],
    "weight": 10,
    "manufacturer": {"name": "song"},
}
'
WHERE product_id = 1;

Upper code is used to create json object
In MySQL, we also have predefine json objects


UPDATE products
SET properties = JSON_OBJECT(
    'weight',10,
    'dimension',JSON_ARRAY(1,2,3),
    'manufacturer',JSON_OBJECT("name","song")
)
WHERE product_id = 1;


Query to extract Json objects

(1)
SELECT
    product_id,
    JSON_EXTRACT(properties,'$.weight') AS weight
FROM products
WHERE product_id = 1;

(2)  -> is a column pass operator
SELECT
    product_id,
    properties -> '$.dimensions[index]'
               ->  ['$.manufacturer.name'] with double quotes
               ->>  ['$.manufacturer.name'] with double quotes
                   ['$.dimensions[index]']
FROM products
WHERE product_id = 1;


To change the JSON attributes
UPDATE products
SET properties = JSON_SET(
    properties,
    '$.weight',20,
    '$.age',10
)
WHERE product_id = 1;

To change the JSON attributes
UPDATE products
SET properties = JSON_REMOVE(
    properties,
    '$.age'
)
WHERE product_id = 1;









*/






