# DATA TYPES
/*

There are various data types in MySQL
(1) String Datatype
(2) Numeric Datatype
(3) Date and Time Datatype
(4) Blob Datatype
(5) Spatial Datatype



(1) STRING DATA TYPES
{
    CHAR(x) = fixed length
    VARCHAR(x) = Maximum length is 65_535 (~64KB)
    TINYTEXT = Max: 255 bytes
    TEXT = Max: 64KB
    MEDIUMTEXT = Max: 16MB for storing json objects, cs view string, short to medium length quotes
    LONGTEXT = Max: 4GB for storing textbook, years of log files

    Mosh said to be consistence with the data types
    Be consistent
    VARCHAR(50) for short string like Name, Password
    VARCHAR(255) for address

    All these datatypes support BYTES
    1 Bytes for English
    2 Bytes for European Middle-eastern
    3 Bytes for Asian
}



(2) INTEGER datatype
{
    TINYINT:  1 byte [-128, 127]
    UNSIGNED TINYINT: [0, 255]
    SMALLINT: 2 byte [-32K, 32K]
    MEDIUMINT: 3bytes [-8M, 8M]
    INT:  4 bytes [-2B, 2B]
    BIGINT:  8bytes  [-9Z, 9Z]

    Note: Use the smallest data type that suits your needs.
    The less data in memory => The faster will be the query
}



(3) FIXED-POINT & FLOATING-POINT TYPES
{
    DECIMAL(p,s) = (precision, scale)
                    1 to 65  , after decimal

    DECIMAL = DEC, NUMERIC, FIXED
    We also have DOUBLE & FLOAT = Float and double uses approximate value

    That's why in order to use exact value, we use DECIMAL
}



(4) BOOLEAN TYPES
{
    Convention: BOOL, BOOLEAN
    Values: 1(True), 0(False)

    UPDATE CUSTOMER
    WHERE product_id = 1  -- or 0

    UPDATE CUSTOMER
    WHERE product_id = TRUE  -- or FALSE
}


(5) ENUM TYPES
{
    Convention: ENUM('small','medium','large')

    Enum are generally bad.
    (1) If you want to rename members of the enum, mysql will rebuild the entire table. If you have millions of records, it will take a lot of time.
    (2) Enum are not reusable, if you want to reuse the value in another table, in that table we have to redefine the values
}



(6) SET TYPES
{
    Same as ENUM
}



(7) DATE & TIME TYPES
{
    Conventions:
        DATE
        TIME
        DATETIME
        TIMESTAMP (upto 2038) This is called year 2038 problem
        YEAR
}



(8) BLOB TYPES
{
    We use blob to store large amount of binary data like images, videos, word files, pretty much any binary data.

    In MySQL, we have 4 blob types, and they differ on maximum amount of data, they can store

    TINYBLOB = for storing binary data upto 255B
    BLOB = for storing binary data upto 65KB
    MEDIUMBLOB = for storing binary data upto 16MB
    LONGBLOB = for storing binary data upto 4GB

    We should avoid store binary data in the MySQL
    MySQL is relational DBMS, not the binary database.

    PROBLEMS WITH STORING FILES IN A DATABASE:
    1) Increased database size
    2) Slower backups
    3) Performance problems
    4) More code to read/write images

}


*/


-- (9) JSON Type

-- Lightweight format for storing and transferring data over the Internet
-- It is used heavily in mobile and desktop applications

-- CREATING A JSON object

select * from products;
UPDATE products
SET properties = '
{
    "dimensions": [1,2,3],
    "weight": 10,
    "manufacturer": {"name": "song"}
}' WHERE product_id = 1;

-- Upper code is used to create json object

-- In MySQL, we also have predefine json objects
UPDATE products
SET properties = JSON_OBJECT(
    'weight',10,
    'dimension',JSON_ARRAY(1,2,3),
    'manufacturer',JSON_OBJECT("name","song")
)
WHERE product_id = 1;


-- Query to extract Json objects
-- (1)
SELECT
    product_id,
    JSON_EXTRACT(properties,'$.weight') AS weight  -- $ means Current JSON document
FROM products
WHERE product_id = 1;

-- (2)  -> is a column pass operator
SELECT
    product_id,
    properties -> '$.dimensions[1]'
--             ->   ['$.manufacturer.name'] with double quotes
--             ->>  ['$.manufacturer.name'] without double quotes (This is helpful when the expression is in WHERE clause)
FROM products
WHERE product_id = 1;


-- To change the JSON attributes
UPDATE products
SET properties = JSON_SET(
    properties,
    '$.weight',20,
    '$.age',10
)
WHERE product_id = 1;

-- To change the JSON attributes
UPDATE products
SET properties = JSON_REMOVE(
    properties,
    '$.age'
)
WHERE product_id = 1;

