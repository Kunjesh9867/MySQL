/*
				Assignment 7
                  Worth 10%
                Total Assignment is out of 50 marks  
				
                Complete all of the questions in this SQL file and submit the file for grading
                
                Open this file in SQL Workbench to complete all of the statements

                Make sure you run the CreateDB Script to create the sample database again so you have the correct data 
				
                You will need it to create the queries based on these tables
                
                There is a .jpg file which shows the tables in the database

*/

/*
q5 You needed to normalize your tables more  45/50
*/


/*
 Question 1 (7 marks)
 
  Create a query that SELECT all of the EMPLOYEES from the EMPLOYEE TABLE that are Managers.   Include Employee ID first name, Lastname and Salary (Hint: Self Join)
 
  
*/
use sample;

Select
emp.EMPNO, emp.FIRSTNME, emp.LASTNAME, emp.SALARY
From EMPLOYEE emp
Join EMPLOYEE emp2
On emp.EMPNO = emp2.EMPNO
Where emp2.JOB = 'MANAGER';





/*
 Question 2 (6 marks)
 
 Write a query the gives the Employee ID first name, Lastname and Salary and Project Number of EMPLOYEES who aren't currently assigned to a project (hint outer join)
 
*/

use sample;

SELECT employee.EMPNO, employee.FIRSTNME, employee.LASTNAME, employee.SALARY, p.PROJNO
FROM project p
 RIGHT JOIN employee ON employee.EMPNO = p.RESPEMP
wHERE PROJNO IS NULL;




/*
 Question 3 (8 marks)
 
Create a query that lists the lastnme, edlevel , job, the number of years they've worked as of Jan 01/2002
 ( hint : year function Jan 01/2002 minus hiredate), and their salary.
Get the employees that have the same Job  as the employee named starts with J
 (hint subquery from employee) and hiredate < Jan 01/2002  Sort the listing by highest salary first.
 
*/



# I have used datediff and covert it into a whole number using floor
SELECT  e.FIRSTNME, e.LASTNAME, e.EDLEVEL, e.JOB, FLOOR(DATEDIFF('2002-01-01', e.HIREDATE) / 365)
AS Number_of_year,
e.SALARY
FROM employee e
WHERE e.JOB in (SELECT e2.JOB FROM employee e2 WHERE e2.FIRSTNME LIKE'J%') and e.HIREDATE < '2002-01-01'
ORDER BY e.SALARY DESC;



/*
 Question 4 ( 7 marks )
 
 Create a table with a COMPOSITE PRIMARY KEY (mininum 3 columns the table) and the second table will have will have a foreign keys to the PRIMARY KEY 
 
 Run the Reverse Engineer function in MySQL workbench on these tables and provide the .MWB file in your submission 


*/

CREATE DATABASE STUDENTDATABASE;
USE STUDENTDATABASE;

DROP DATABASE STUDENTDATABASE;

CREATE TABLE accounts (
   accountnumber INTEGER,
   accounttype INTEGER,
   accountdescrption CHAR(30),
   PRIMARY KEY (accountnumber, accounttype));

CREATE TABLE substitute_accounts (
   substituteaccount INTEGER PRIMARY KEY,
   referencenum INTEGER NOT NULL,
   referencetype INTEGER NOT NULL,
   sububstitutedescription CHAR(30),
   FOREIGN KEY (referencenum, referencetype) REFERENCES accounts
      (accountnumber, accounttype));

/*
 Question 5 (12 marks)
 
 Create a table in 1NF (minimum 5 columns the table).  Then transform that table into as many tables as necessary to satisfy 2NF.Then transform that table into as many tables as necessary to satisfy 3NF
  

*/
CREATE TABLE  SUBJECT
(
   SUBJECTID INT PRIMARY KEY,
   SUBJECTNAME VARCHAR(255),
   CLASS INT,
   ROLLNO INT,
   BIO VARCHAR(100)

);


CREATE TABLE STUDENT
(
   STUDENTID INT PRIMARY KEY,
   FIRSTNAME VARCHAR(100),
   LASTNAME VARCHAR(100),
   AGE INT,
   ADDRESS VARCHAR(100)
);


CREATE TABLE CONNECTION
(
   ID INT PRIMARY KEY,
   SUBJECTID INT,
   STUDENTID INT,
   FIRSTNAME VARCHAR(100),
   LASTNAME VARCHAR(100),
   GRADE INT,
   FOREIGN KEY (SUBJECTID) REFERENCES SUBJECT(SUBJECTID),
   FOREIGN KEY (STUDENTID) REFERENCES STUDENT(STUDENTID)
);







/*
 Question 6 (10 marks)
 
Create a View (V_EMP_DEPT_PROJ) statement that joins the EMPLOYEE and EMPPROJACT (join on EMPNO)
 and PROJECT table (join on PROJNO).  Limit the view to contain :
o	ID
o	Name (FirstName and Lastname)
o	WorkDept
o	Salary
o	ACTNO
o	PROJNO
o	PROJNAME
o	Where Salary < 100000

  
 */
USE sample;
CREATE VIEW V_EMP_DEPT_PROJ AS
    (SELECT employee.EMPNO, employee.FIRSTNME, employee.LASTNAME,employee.WORKDEPT, employee.SALARY, empprojact.ACTNO,
             project.projno, project.projname  FROM employee join empprojact
                               ON employee.EMPNO=empprojact.EMPNO
                               join project
                               on project.PROJNO=empprojact.PROJNO
                               where SALARY < 100000
    );

select * from V_EMP_DEPT_PROJ;
drop view V_EMP_DEPT_PROJ;
 
 
 