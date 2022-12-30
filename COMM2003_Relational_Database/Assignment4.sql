/*
				Assignment 4
                  Worth 5%
                Total Assignment is out of 50 marks  
				Complete all of the questions in this SQL file and submit the file for grading
                Open this file in SQL Workbench to complete all of the statements
                                
                Make sure you run the CreateDB Script to create the sample database 
				
                You will need it to create the queries based on these tables
                
                There is a .jpg file which shows the tables in the database

*/


#50/50

/*
    Name = Kunjesh Kantilal Ramani
    Student ID = 200515106
*/
USE SAMPLE;
SHOW TABLES;

/*
 Question 1
 
 Write an UPDATE statement to change all of the LASTNAMEs in the EMPLOYEE table to SMITH ( 5 marks )
 
*/

# Put your answer here

SELECT * FROM employee;

UPDATE employee
SET LASTNAME = 'SMITH';

SELECT * FROM employee;



/*
 Question 2
 
 Write an UPDATE statement to change all of the MAJPROJ records in the PROJECT to AD9999 Where they don't
 have a value( 5 marks )
 */

SELECT * FROM project;

UPDATE project
SET MAJPROJ = 'AD9999'
WHERE MAJPROJ = '' ;

SELECT * FROM project;



/*
 Question 3
 
 Write a single UPDATE statement to change the QUANTITY to 200 and the LOCATION to Barrie  WHERE the PID has a 1 in the 7th position( 8 marks )
 
*/

/*
Table = inventory
QUANTITY, LOCATION, PID
Doubt = Table is not specify in the question. So I look at all the tables in the databases and find table 'inventory'
which has all the 3 columns
*/

SELECT  * FROM inventory;

UPDATE inventory
SET QUANTITY =  200,LOCATION = 'Barrie'
WHERE pid LIKE '______1%';

SELECT  * FROM inventory;




/*
 Question 4
 
 Write an UPDATE statement to change the SALARY to be increased by 10% WHERE EMPLOYEE IS older than 40 years old( 10 marks ) (hint date functions to determine age)
 
*/

SELECT * FROM employee;

update employee
set SALARY = SALARY + SALARY*0.1
where FLOOR(DATEDIFF(curdate(),BIRTHDATE) / 365.25) >40;

SELECT * FROM employee;










/*
 Question 5
 
 Write a DELETE statement to remove employee 000030 from the EMPLOYEE table  ( 5 marks )
 
   
 */

 SELECT * FROM employee;

delete from employee
where EMPNO = '000030';

SELECT * FROM employee;

/*
 Question 6
 
 Write a DELETE statement to remove records where the total of their SALARY and COMM column together is less than $40000  and they have worked for the company for less than 8 years from the STAFF table ( 7 marks )


 */
SELECT * FROM STAFF;

 DELETE FROM staff
WHERE SALARY+COMM < 40000 and YEARS < 8;

SELECT * FROM STAFF;


/*
 Question 7
 
  Write a DELETE statement to remove records WHERE the REGION has South in the name and the SALES DATE is in APRIL in the SALES table  ( 10 marks )
  
 */
SELECT * FROM SALES;

DELETE FROM sales
WHERE REGION LIKE '%South%' AND month(SALES_DATE) = 04;

SELECT * FROM SALES;





 
 
 
