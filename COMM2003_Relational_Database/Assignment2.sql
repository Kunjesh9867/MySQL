/*
				Assignment 2 
                  Worth 3%
                Total Assignment is out of 75 marks  
				Complete all of the questions in this SQL file and submit the file for grading
                Open this file in SQL Workbench to complete all of the statements

*/

# 1. foreign key missing   6 missing in statement   65/75


/*  NOTE   Please read all the questions before creating your table in question 1 as your table and data need to be good enough quality to satisfy the conditions for Question 3 - 6 */
 CREATE DATABASE  ASSIGNMENT2;
 USE ASSIGNMENT2;
 
 
 /*
 Question 1
 
 Write 2 statements to Create two tables that have a way to force uniqueness from row to row and are related by one of their columns ( make sure you have a least 1 date column )   ( 15 marks )
 
  
 */
 
 
 -- order table is the source table here
 create table Orders(
 order_id int not null,
 customer_id int not null primary key,
 product varchar(50) not null,
 total int not null,
 date_of_stock date not null,
 item_availability char(1) not null,
 price numeric(8,2) not null,
 profit_margin float  default null
 );
 
 
 -- customers table is the dependent table here which includes foreign key
 create table customers(
 serial_number int not null primary key,
 id int references orders(customer_id),
 first_name varchar(50),
 last_name varchar(50),
 date_of_birth date,
 age int,
 country varchar(10)
 );
 
 
 
 
 /*
 Question 2
/////// NOTE rember the order of which table you insert into first is important
 
 Write 10 statements to add to the source table you created in question 1   ( 10 marks )
 
 Write 10 statements to add to the dependant table you created in question 1  ( 10 marks )
  
 */
 
 -- order table is the source table here
 insert into orders
 values
 (1,1,'Paper',500,'2022-10-20','Y',5.50,2.00),
 (2,2,'Pen',200,'2021-09-25','Y',10.52,1.99),
 (3,3,'Marker',100,'2021-10-05','N',6.35,2.56),
 (4,4,'Books',1000,'2021-01-05','Y',25.99,12.65),
 (5,5,'Erasers',1500,'2021-02-14','Y',1.99,0.50),
 (6,6,'Sharpeners',1500,'2021-02-14','N',1.99,0.50),
 (7,7,'Writing Pad',50,'2020-08-06','Y',30.25,20.55),
 (8,8,'Project Files',250,'2020-04-28','Y',3.25,1.70),
 (9,9,'Geometry Box',80,'2020-12-30','N',23.99,15.50),
 (10,10,'Fevistick',400,'2020-04-12','Y',0.99,0.33);
 
 SELECT * FROM ORDERS;
 
 
 -- customer table is the dependent table here
 insert into CUSTOMERS
 values
 (1,2,'Kunjesh','Ramani','2002-10-27',19,'CA'),
 (2,4,'Aarsh','Patel','2003-10-24',18,'CA'),
 (3,6,'Daxil','Patel','2002-09-15',19,'CA'),
 (4,8,'Aryan','Savaliya','2001-01-23',20,'IN'),
 (5,10,'Ansh','Jogani','2004-03-18',17,'IN'),
 (6,1,'Saurin','Patel','2002-05-25',19,'IN'),
 (7,3,'Lakulish','Bharadvaj','2002-07-22',19,'RU'),
 (8,5,'Sahil','Vadadoriya','2001-12-02',20,'AU'),
 (9,7,'Ansh','Patel','2004-11-09',17,'CA'),
 (10,9,'Pranav','Bhavsari','2003-02-14',18,'CA'),
 (11,2,'John','Cena','2002-10-27',38,'US'),
 (12,4,'Johnny','Depp','2003-10-24',50,'US'),
 (13,6,'Sushant ','Singh','2002-09-15',38,'IN');
 
 select  * from customers;

 

 
 /*
 Question 3
 
 Write a SELECT statement that uses the LIKE statement and a character to find some of the records in one of your tables you created in Question 1 ( Use either the % or the _ for the rest of your wildcard)   ( 10 marks )
 
  
 */
 
 -- Example 1
select * from orders
where product like '%e%';

-- Example 2
select id, product, first_name, last_name from orders, customers
where product like "%e%"  and customer_id=id;

 
  /*
 Question 4
 
 Write a SELECT statement that uses the BETWEEN statement to find some of the records in one of your tables using the date column you created in Question 1  ( 10 marks )
 
  
 */
 
 select * from orders 
 where date_of_stock between '2021-01-01' and '2022-12-31';
 
 
 /*
 Question 5
 Write a SELECT statement that uses another BETWEEN statement and sorts the data by 2 of the columns one in Ascending and one in Descending order on the tables you created in Question 1  ( 10 marks )
 */
select * from customers 
where AGE between 17 and 19
order by age asc, id desc;


 
  /*
 Question 6
 Write a SELECT statement that selects a list of values (using the IN operator) from one of your tables, then use that same query and use the NOT operator to get the opposite data on the tables you created in Question 1   ( 10 marks )
 */
 select * from customers 
 where country not in ("CA", "RU","AU");
  