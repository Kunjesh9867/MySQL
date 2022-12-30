/*
				Assignment 6
                  Worth 10%
                Total Assignment is out of 100 marks  
				
                Complete all of the questions in this SQL file and submit the file for grading
                
                Open this file in SQL Workbench to complete all of the statements
                
                Make sure you run the CreateDB Script to create the sample database again so you have the correct data 
				
                You will need it to create the queries based on these tables
                
                There is a .jpg file which shows the tables in the database

*/


/*
2. Missing group by and replacement for EMPNO

5. missing the join columns   89/100
*/


CREATE DATABASE ASSIGNMENT6;
# drop database ASSIGNMENT6;
USE ASSIGNMENT6;
show databases;

/*
 Question 1 (10 marks)
 
 a) Create two tables with the same numbers of columns and datatypes (mininum 3 columns in each table) (3 marks)
 
 b) Populate that table with data (3 marks)
 
 c) Create a SELECT statement for each table and UNION them together (4 marks)
 
*/





CREATE TABLE EMPLOYEE(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100) NOT NULL,
    PREVIOUS_SALARY DOUBLE(10,2) NOT NULL
);
CREATE TABLE DEPARTMENT(
    ID INT PRIMARY KEY AUTO_INCREMENT,
    DEPARTMENT_NAME VARCHAR(100) NOT NULL,
    NEW_SALARY DOUBLE(10,2) NOT NULL
);

SHOW TABLES;
DESC EMPLOYEE;

INSERT INTO EMPLOYEE(NAME, PREVIOUS_SALARY) VALUES('KUNJESH',14999.50);
INSERT INTO EMPLOYEE(NAME, PREVIOUS_SALARY) VALUES('AARSH',19999.99);
INSERT INTO EMPLOYEE(NAME, PREVIOUS_SALARY) VALUES('DAXIL',20999.50);
INSERT INTO EMPLOYEE(NAME, PREVIOUS_SALARY) VALUES('ARYAN',25999.99);
INSERT INTO EMPLOYEE(NAME, PREVIOUS_SALARY) VALUES('ANSH',20000.50);

INSERT INTO DEPARTMENT(DEPARTMENT_NAME, NEW_SALARY) VALUES ('MANAGER',24999.50);
INSERT INTO DEPARTMENT(DEPARTMENT_NAME, NEW_SALARY) VALUES ('HIRING MANAGER',29999.99);
INSERT INTO DEPARTMENT(DEPARTMENT_NAME, NEW_SALARY) VALUES ('PROJECT COORDINATOR',30999.50);
INSERT INTO DEPARTMENT(DEPARTMENT_NAME, NEW_SALARY) VALUES ('TEAM CAPTAIN',35999.99);
INSERT INTO DEPARTMENT(DEPARTMENT_NAME, NEW_SALARY) VALUES ('EMPLOYEE',30000.50);

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

SELECT * FROM EMPLOYEE UNION SELECT * FROM DEPARTMENT;

# USE ASSIGNMENT6;



/*
 Question 2 (10 marks)
 
 Create a query that lists the department number, employee number, and salaries of all employees in department D11.  
 UNION the same information , but this time sum up all the salaries to create a one line summary entry for the D11 department (hint sum the salary).  Sort the list by Salary.
 
*/



SELECT WORKDEPT, SALARY, EMPNO FROM EMPLOYEE WHERE WORKDEPT = "D11";


SELECT WORKDEPT, SUM(SALARY) AS TOTAL_SALARY, EMPNO FROM EMPLOYEE WHERE WORKDEPT = "D11"
UNION
SELECT WORKDEPT, SALARY, EMPNO FROM EMPLOYEE WHERE WORKDEPT = "D11"
ORDER BY TOTAl_SALARY;


/*
 Question 3 (10 marks)
 
a )  Write a query that uses NATURAL JOIN TO connect the EMPLOYEE and EMPPROJACT table.   Include the Employee number , First and Last name, Salary, Salary increased by 3% and Project number      ( 3 marks )
 
b) Use INNER JOIN OR JOIN with the same query with USING statement   ( 3 marks )

 
c) Use INNER JOIN OR JOIN with the same query with joined columns (hint a = a )    ( 4 marks )

*/

use sample;
#a
SELECT EMPNO, FIRSTNME, LASTNAME, SALARY, (SALARY + SALARY * 0.03) AS INCREASED_SALARY, EMPPROJACT.PROJNO FROM EMPLOYEE
NATURAL JOIN EMPPROJACT;

#b
SELECT EMPNO, FIRSTNME, LASTNAME, SALARY, (SALARY + SALARY * 0.03) AS INCREASED_SALARY, EMPPROJACT.PROJNO FROM EMPLOYEE
INNER JOIN EMPPROJACT
USING (EMPNO);

#c
SELECT EMPLOYEE.EMPNO, FIRSTNME, LASTNAME, SALARY, (SALARY + SALARY * 0.03) AS INCREASED_SALARY, EMPPROJACT.PROJNO FROM EMPLOYEE
INNER JOIN EMPPROJACT
WHERE
EMPLOYEE.EMPNO = EMPPROJACT.EMPNO;





/*
 Question 4 ( 25 marks )
 
  a) Create three tables.  Two of the tables will have PRIMARY KEYS (mininum 3 columns in each table) and the third table will have two columns that are the foreign keys to each of the PRIMARY KEYS (6 marks)
 
 b) Populate these table with data (5 marks)
 
 c) Create a SELECT statement using NATURAL JOINS to connect the three tables together (7 marks)
 
 d) Run the Reverse Engineer function in MySQL workbench on these tables and provide the .MWB file in your submission ( 7 marks )
 
*/
-- USE ASSIGNMENT6;
CREATE DATABASE RECORDS;

USE RECORDS;
CREATE TABLE STUDENT (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100) NOT NULL,
    GRADE INT NOT NULL
);
CREATE TABLE COLLEGE (
    ID INT PRIMARY KEY,
    LAST_NAME VARCHAR(100) NOT NULL,
    MARKS INT NOT NULL
);
CREATE TABLE CONNECTIONS (
    STUDENT_FK INT AUTO_INCREMENT unique,
    COLLEGE_FK INT PRIMARY KEY ,
    FOREIGN KEY (STUDENT_FK) REFERENCES STUDENT(ID),
    FOREIGN KEY (COLLEGE_FK) REFERENCES COLLEGE(ID)
);

INSERT INTO STUDENT(NAME, GRADE) VALUES ('KUNJESH',12);
INSERT INTO STUDENT(NAME, GRADE) VALUES ('AARSH',11);
INSERT INTO STUDENT(NAME, GRADE) VALUES ('DAXIL',10);
INSERT INTO STUDENT(NAME, GRADE) VALUES ('ARYAN',10);
INSERT INTO STUDENT(NAME, GRADE) VALUES ('ANSH',12);

INSERT INTO COLLEGE(ID,LAST_NAME, MARKS) VALUES (1,'RAMANI',100);
INSERT INTO COLLEGE(ID,LAST_NAME, MARKS) VALUES (2,'PATEL',95);
INSERT INTO COLLEGE(ID,LAST_NAME, MARKS) VALUES (3,'PATEL',90);
INSERT INTO COLLEGE(ID,LAST_NAME, MARKS) VALUES (4,'SAVALIYA',85);
INSERT INTO COLLEGE(ID,LAST_NAME, MARKS) VALUES (5,'JOGANI',80);

SHOW TABLES;

insert into CONNECTIONS(COLLEGE_FK) VALUES (1);
insert into CONNECTIONS(COLLEGE_FK) VALUES (2);
insert into CONNECTIONS(COLLEGE_FK) VALUES (3);
insert into CONNECTIONS(COLLEGE_FK) VALUES (4);
insert into CONNECTIONS(COLLEGE_FK) VALUES (5);

SELECT STUDENT_FK,COLLEGE_FK from CONNECTIONS natural join student natural join COLLEGE;



# DROP DATABASE RECORDS;





/*
 Question 5 (15 marks)
 
  Write a query that uses INNER JOIN TO connect the EMPLOYEE, EMPPROJACT, PROJACT and PROJECT tables.   Include the Project number , Department number, Project start and end date and AC STAFF  
WHERE They belong to department D11 , Salary is more than or equal to 65 percent of $15,000 AND Salary is less than or equal to 130 percent of $40,000 

   
*/

use sample;
SELECT PROJECT.PROJNO, PROJECT.DEPTNO,  PROJECT.PRSTDATE, PROJECT.PRENDATE, PROJACT.ACSTAFF, SALARY
FROM EMPLOYEE,EMPPROJACT,PROJACT,PROJECT
WHERE PROJECT.DEPTNO='D11'AND EMPLOYEE.SALARY >= 15000*(0.65) AND EMPLOYEE.SALARY<=40000*1.3
ORDER BY SALARY;




/*
 Question 6 (15 marks)
 
 Create a query that lists empno, projno, emptime, emendate.
 Left join the project to the empprojact table using projno and left join the act table using actno and then right join employee table using empno.
 Where projno is AD3113 and empno is 000270 and emptime is greater than 0.5
 
 
*/
use sample;
select * from empprojact;

SELECT EMPLOYEE.EMPNO, EMPPROJACT.PROJNO, EMPTIME, EMENDATE FROM PROJECT
LEFT JOIN EMPPROJACT
ON PROJECT.PROJNO = EMPPROJACT.PROJNO
LEFT JOIN ACT
ON ACT.ACTNO = EMPPROJACT.ACTNO
RIGHT JOIN EMPLOYEE
ON EMPPROJACT.EMPNO = EMPLOYEE.EMPNO
WHERE EMPPROJACT.PROJNO = "AD3113" AND EMPLOYEE.EMPNO = "000270" AND EMPPROJACT.EMPTIME > "0.5";




/*
 Question 7 (15 marks)
 
  Describe all of the relationships between the tables in the attached image file TableRelationships.jpg
  
  a) describe all the foreign key and primary keys, either by detailing them 1 by 1 or define the CREATE table statements for all the tables (10 marks)
  b) describe the relationship between each table ( 1..1 (exactly one match)  1..n (one or more matches)) (5 marks)

 
  
 */

 /*

 (a) Primary keys are =
 contacttype.id
 contact.pid
 contact.ctid
 person.id
 projectperson.prid
 projectperson.pid
 projectperson.rid
 role.id
 project.id

    Foreign keys are =
 contact.ctid
 projectperson.pid
 projectperson.prid
 projectperson.rid



 (b)
 contacttype to contact = one to one
 contact to person = many to one
 person to personproject = one to many
 projectperson to role = many to one
 projectperson to project = many to one

 */
 
 
 


 
 
 