# Designing Databases = Refer Notes

-- Creating and Dropping Database
CREATE DATABASE IF NOT EXISTS kunjesh;
DROP DATABASE IF EXISTS kunjesh;

USe kunjesh;

DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers
(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    fist_name   VARCHAR(50)  NOT NULL,
    points      INT          NOT NULL DEFAULT 0,
    email       VARCHAR(255) NOT NULL UNIQUE
);

-- If there is a space in your columns (you shouldn't have)
-- You have to use ` `
ALTER TABLE customers
    ADD last_name VARCHAR(50) NOT NULL,
    MODIFY COLUMN fist_name VARCHAR(55) DEFAULT '',
    DROP points;


-- Foreign Key Syntax
CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    FOREIGN KEY fk_order_customers (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

-- Drop Foreign Key
ALTER TABLE orders
    ADD PRIMARY KEY (order_id),
    DROP FOREIGN KEY fk_order_customers,
    ADD FOREIGN KEY fk_orders_customers (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION;


# Character Sets & Collations
SHOW CHARACTER SET;

-- There are different character set is available in MySQL

CREATE TABLE tab1 (
    kunjesh VARCHAR(45) CHARACTER SET latin1 NOT NULL
)
CHARACTER SET latin1;


# Storage Engine
-- 2 most popular: InnoDB, MyISAM

ALTER TABLE customers
ENGINE = InnoDB;