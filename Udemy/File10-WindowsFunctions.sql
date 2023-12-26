### WINDOW FUNCTIONS ###
-- Window functions perform aggregate operations on groups of rows, but they produce a result FOR EACH ROW.
-- Window functins are tricky and hard to understand.


-- Included code
CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);


SELECT emp_no, department, salary, AVG(salary) OVER() FROM employees;

SELECT
    emp_no,
    department,
    salary,
    MIN(salary) OVER(),
    MAX(salary) OVER()
FROM employees;

SELECT emp_no, department, salary, MIN(salary), MAX(salary) from employees;
-- ERROR: because we are performing some kind of group by stuff

### OVER ###
-- AVG(salary) OVER()
-- The OVER() clause constructs a window. When it's empty, the window will include all records.
SELECT AVG(salary) OVER() from employees;

### PARTITION BY ###
-- AVG(salary) OVER(PARTITION BY department)
-- Inside of the OVER(), use PARTITION BY to form rows into groups of row
SELECT
    emp_no,
    department,
    salary,
    AVG(salary) OVER(PARTITION BY department) AS dept_avg
FROM employees;

-- Getting the salary - average salary
SELECT
    emp_no,
    department,
    salary,
    AVG(salary) OVER(PARTITION BY department) AS dept_avg,
    salary - AVG(salary) OVER(PARTITION BY department)
FROM employees;

### ORDER BY ###
-- OVER(ORDER BY salary DESC)
-- Use ORDER BY inside of the OVER() clause to re-order rows within each window.

-- by using ORDER BY in the window function, we can get the ROLLING AVG, ROLLING MIN, ROLLING MAX etc.

-- The behavior of ORDER BY in WINDOW FUNCTION changes when the AGGREGATE FUNCTION changes.
SELECT
    emp_no,
    department,
    salary,
    SUM(salary) OVER(PARTITION BY department ORDER BY salary) AS rolling_dept_salary,
    SUM(salary) OVER(PARTITION BY department) AS total_dept_salary
FROM employees;

SELECT
    emp_no,
    department,
    salary,
    MIN(salary) OVER(PARTITION BY department ORDER BY salary DESC) as rolling_min
FROM employees;


### RANK() ###
-- RANK() function is used to rank data according to the given column
-- If there is tie, then RANK() skip 1
-- Look at the example below
SELECT emp_no,
       department,
       salary,
       RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank
FROM employees; -- Here, there is a tie on 7;

SELECT emp_no,
       department,
       salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC ) AS department_salary_rank,
       RANK() OVER(ORDER BY salary DESC) AS overall_salary_rank
FROM employees;



### ROW_NUMBER() ###
-- Very similar to RANK()
-- Basically, it returns the row number
SELECT
    emp_no,
    department,
    salary,
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num
FROM employees ORDER BY overall_rank;

### DENSE_RANK() ###
-- Very similar to RANK()
-- Whenever, there is a tie in RANK(), it skip that 1 value
-- But in DENSE_RANK(), it will continue through

SELECT
    emp_no,
    department,
    salary,
    RANK() OVER(ORDER BY salary DESC) as overall_rank,
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num
FROM employees ORDER BY overall_rank;


### NTILE() ###
-- NTILE() is like breaking the data into sections and given it a number, in which it belongs
-- for EXAMPLE
-- NTILE(4) => 4 difference number in a sections
SELECT
    emp_no,
    department,
    salary,
	NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile
FROM employees;


### FIRST_VALUE(), LAST_VALUE(), NTH_VALUE(exp, n) ###
-- It returns the first_value, last_value, nth_value

SELECT
    emp_no,
    department,
    salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) as highest_paid_dept,
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) as highest_paid_overall
FROM employees;


### LAG ###
-- Look for previous values
    SELECT
    emp_no,
    department,
    salary,
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) as salary_diff
FROM employees;


### LEAD ###
-- Look from next values

SELECT
    emp_no,
    department,
    salary,
    salary - LEAD(salary) OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_diff
FROM employees;