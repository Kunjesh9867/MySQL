/*
				Assignment 5
                  Worth 5%
                Total Assignment is out of 50 marks  
				Complete all of the questions in this SQL file and submit the file for grading
                Open this file in SQL Workbench to complete all of the statements
                
                Make sure you run the CreateDB Script to create the sample database 
				
                You will need it to create the queries based on these tables
                
                There is a .jpg file which shows the tables in the database

*/

/*
q1 firsttable is not a good table name 

q3 Date is not a valid column name 

q7 Update needed to be more detailed  40/50
*/

SHOW databases ;
USE SAMPLE;



/*
 Question 1
 
Write a CREATE table statement that has a PRIMARY KEY column and have that column auto generate a value on INSERT ( 5 marks )
 
*/

# Put your answer here
CREATE TABLE FIRST_TABLE
(
    SERIAL_NO INT PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME VARCHAR(100) NOT NULL,
    LAST_NAME VARCHAR(100) NOT NULL,
    DIVISION CHAR(2) NOT NULL,
    MARKS INT,
    ADDRESS VARCHAR(200)
);


SHOW TABLES;





/*
 Question 2
 
 Write 5 INSERT statements that add data to the table from Question 1 but doesn't include the PRIMARY KEY to test the auto numbering ( 5 marks )


*/
INSERT INTO FIRST_TABLE(FIRST_NAME, LAST_NAME, DIVISION, MARKS, ADDRESS)
VALUES
    ("KUNJESH","RAMANI","12",100,"WILLIAM PADDSON"),
    ("AARSH","PATEL","12",100,"GROVE STREET"),
    ("DAXIL","PATEL","12",100,"YOUNG STREET"),
    ("ARYAN","SAVALIYA","11",95,"NIKOL"),
    ("SAURIN","PATEL","10",90,"NARODA");

SELECT * FROM FIRST_TABLE;




/*
 Question 3
 
 Write an ALTER statment to add a date column to the table from Question 1 and set a default of January 1 2020 ( 7 marks )
 
*/

ALTER TABLE FIRST_TABLE
ADD DATE date default "2020-01-01";

select * from FIRST_TABLE;



/*
 Question 4
 
 Write an ALTER statement to remove the date column you just added to your table (7 marks)
 
 
*/
ALTER TABLE FIRST_TABLE
DROP COLUMN DATE;

SELECT * FROM FIRST_TABLE;



/*
 Question 5
 
  Write a single ALTER statement to modify the name and datatype of two of your columns in your table from Question 1   ( 8 marks )
 
  
 */

ALTER TABLE FIRST_TABLE
CHANGE COLUMN FIRST_NAME FIRST VARCHAR(500),
CHANGE COLUMN LAST_NAME LAST VARCHAR(500);

desc first_table;


/*
 Question 6
 
  Write a single ALTER statement to add two columns to your table from Question 1, the first column needs a DEFAULT value, the second column needs to be put in between your first and second column of the table ( 8 marks )
 
   
 */
 ALTER table FIRST_TABLE
    Add column PASS_FAIL VARCHAR(10) DEFAULT "PASS",
    ADD COLUMN GENDER CHAR(1) AFTER SERIAL_NO;


select * from FIRST_TABLE;


/*
 Question 7
 
  Write a CREATE table statement that has an ID column (with a PRIMARY KEY and an AUTO generating number) and a description column.
  ALTER the table from Question 1 to have that ID column added to it and make a FOREIGN KEY reference 
  INSERT records into the new table AND UPDATE the table from Question 1 with the new ID fields
  ( 10 marks )

 
 */
 CREATE TABLE SECOND_TABLE
(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    DESCRIPTION VARCHAR(500)
 );

ALTER TABLE FIRST_TABLE
add column id int,
ADD FOREIGN KEY (id) REFERENCES SECOND_TABLE(ID);

INSERT INTO SECOND_TABLE(DESCRIPTION) VALUES
("Good Student"),
("Very Good Student"),
("Excellent Student"),
("Outstanding Student"),
("Fabulous Student");

UPDATE FIRST_TABLE
SET ID = SERIAL_NO;
#  HERE I SET ID = SERIAL NO  BECAUSE SERIAL NO IS PRIMART AS WELL AS ID REFEERENCE

SELECT * FROM FIRST_TABLE;
 