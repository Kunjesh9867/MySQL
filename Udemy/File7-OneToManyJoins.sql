-- Data can be messy. Remember IBM(protein example)

# FOREIGN KEY
CREATE DATABASE shop;
USE shop;
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email)
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');


INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);


SELECT * from customers;
SELECT * from orders;


# CROSS JOIN = Dumb JOIN = not very useful in real world

-- Way 1
SELECT id FROM customers WHERE last_name = 'George';
SELECT * FROM orders WHERE customer_id = 1;

-- Way 2
SELECT * FROM orders
WHERE customer_id = (SELECT id FROM customers WHERE last_name = 'George');

-- To perform a (kind of useless) cross join:
SELECT * FROM customers, orders;


# INNER JOIN = intersection of A and B
SELECT * FROM customers
JOIN orders ON orders.customer_id = customers.id;

SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders ON orders.customer_id = customers.id;

-- The order doesn't matter here:
SELECT * FROM orders
JOIN customers ON customers.id = orders.customer_id;



# INNER JON with GROUP BY
SELECT first_name, last_name, SUM(amount) AS total FROM customers
JOIN orders ON orders.customer_id = customers.id
GROUP BY first_name , last_name
ORDER BY total;



# LEFT JOIN = OUTER LEFT JOIN
SELECT first_name, last_name, order_date, amount FROM customers
LEFT JOIN orders ON orders.customer_id = customers.id;

# LEFT JON with GROUP BY
SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS money_spent FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name , last_name;

# RIGHT JOIN = OUTER RIGHT JOIN
SELECT first_name, last_name, order_date, amount FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;


# ON DELETE CASCADE
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8 , 2 ),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);



### EXERCISE ###
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50)
);

CREATE TABLE papers(
    student_id INT,
    title VARCHAR(100),
    grade INT,
    FOREIGN KEY(student_id) REFERENCES students(id)
);

INSERT INTO students (first_name) VALUES
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT first_name, title, grade FROM students s
JOIN papers p on s.id = p.student_id
ORDER BY grade DESC;

SELECT first_name, title, grade FROM students s
LEFT JOIN papers p on s.id = p.student_id;

SELECT first_name, IFNULL(title, 'MISSING'), IFNULL(grade, 0) FROM students s
LEFT JOIN papers p on s.id = p.student_id;


SELECT first_name, IFNULL(AVG(grade), 0)  AS average FROM students s
LEFT JOIN papers p on s.id = p.student_id
GROUP BY first_name
ORDER BY average DESC;


SELECT first_name, IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN  IFNULL(AVG(grade), 0) >= 75 THEN 'PASSING'
        ELSE
            'FAILING'
    END AS  'passing_status'
FROM students s
LEFT JOIN papers p on s.id = p.student_id
GROUP BY first_name
ORDER BY average DESC;

 ############## WE CANNOT USE ALIASES IN "CASE"