/*
				Assignment 1 
                  Worth 3%
                Total Assignment is out of 75 marks  
		Complete all of the questions in this SQL file and submit the file for grading
                Open this file in SQL Workbench to complete all of the statements

*/


# q4 Missing numeric 72/75


/*
 Question 1
 
 Write a statement to Create a database (make sure your database doesn't contain special characters)  ( 5 marks )
 
*/

# Put your answer here
create database assignment1;




/*
 Question 2
 
 Write a statement to Drop that Database you created in Question 1  ( 5 marks )
 
*/

drop database assignment1;

/*
 Question 3
 
 Write a statement to set the database you created to be the one that will be active for your session  ( 5 marks )
 
*/
create database assignment1;
use assignment1;


/*
 Question 4
 
 Write a statement to Create a table that will have columns that represent all of the basic datatypes that are available in the databse  (make sure your table and column names are describe the content of the table)  ( 15 marks )
 example
 CREATE TABLE book_info (
     id                 VARCHAR(32)     not null,
     filePath           long varchar     null,
     price		        float     null ,
     title                  null,
     author             long varchar     null,
  );
 
 
*/
create table club(
coach_id int not null primary key,
coach_name varchar(100),
age 	int,
sports varchar(100),
date_of_app date,
pay float,
sex char(1)
);



# desc club;


/*
 Question 5
 
 Write 5 statements to add data to the table you created in question 4   ( 15 marks )
 
   
 */
 insert into club 
 values 
 (1, "KUKREJA" ,35, "KARATE"     , "1996-03-27" , 1000.5  , 'M'),
 (2, "RANINA"  ,34, "KARATE"     , "1998-01-20" , 1550.25 , 'F'),
 (3, "KARAN"   ,34, "SQUASH"     , "1998-02-19" , 2000.65 , 'M'),
 (4, "TARUN"   ,33, "BASKETBALL" , "1998-01-01" , 1500    , 'M'),
 (5, "ZUBIN"   ,36, "SWIMMING"   , "1998-01-12" , 750.95  , 'M'),
 (6, "KETAKI"  ,36, "SWIMMING"   , "1998-02-24" , 800     , 'F'), 
 (7, "ANKITA"  ,38, "SQUASH"     , "1998-02-20" , 2200    , 'F'),
 (8, "ZAREEN"  ,37, "KARATE"     , "1998-02-22" , 1100.5  , 'F'),
 (9, "KUSH"    ,41, "SWIMMING"   , "1998-01-13" , 900     , 'M'),
 (10,"SHAILYA" ,37, "BASKETBALL" , "1998-02-19" , 1700    , 'M');
 


SELECT * FROM CLUB;



/*
 Question 6
 3-4 columns 
 Write 2 statements to Create two tables that have a way to force uniqueness from row to row ( make sure your table and column names are describe the content of the table)   ( 10 marks )
 
  
 */


create table softdrink(
drink_code 	int not null primary key,
dname varchar(100) not null,
price float,
calories int
);

create table gym(
ICODE varchar(10) not null primary key,
INAME varchar(200) not null, 
PRICE int,
BRANDNAME varchar(200)
);



show tables;

/*
 Question 7
 
 Write 5 statements to add to the first table you created in question 6   ( 10 marks )
 
 Write 5 statements to add to the second table you created in question 6  ( 10 marks )
  
 */
 
 insert into softdrink
 values
 (101, "Lime and Lemon"     , 20.5  ,120),
 (102, "Apple Drink"        , 18.65 ,120),
 (103, "Nature Nectar"      , 15.5  ,115),
 (104, "Green Mango"        , 20.95 ,140),
 (105, "Aam Panna"          , 25.5  ,135),
 (106, "Mango Juice Bahaar" , 30.99 ,220);
 
 insert into gym
 values
 ("G101", "Power Fit Exerciser"  , 20000 , "Power Gymea"   ),
 ("G102", "Aquafit Hand Grip"    , 1800  , "Reliable"      ),
 ("G103", "Cycle Bike"           , 14000 , "Ecobike"       ),
 ("G104", "Protoner Extreme Gym" , 30000 , "Coscore"       ),
 ("G105", "Message Belt"         , 5000  , "Message Expert"),
 ("G106", "Cross Trainer"        , 13000 , "GTC Fitness"   );
 
 -- To see all entries in the table
 select * from softdrink;
 select * from gym;
 
 
