/*
				Assignment 3
                  Worth 4%
                Total Assignment is out of 50 marks  
				Complete all of the questions in this SQL file and submit the file for grading
                Open this file in SQL Workbench to complete all of the statements
                
                Make sure you run the CreateDB Script to create the sample database 
				
                You will need it to create the queries based on these tables
                
                There is a .jpg file which shows the tables in the database

*/

/*
q 1,2,3 I wanted you to specify the columns not use *

q4 WHERE PRENDATE >= "20020701"; 

q6 LIKE 'AD____';

q10 Missing aliases    42/50
*/



use sample;




/*
 Question 1
 
 Write a statement to SELECT all of the columns in the DEPARTMENT table  ( 5 marks )
 
*/

# Put your answer here


select * from department;



/*
 Question 2
 
  Write a statement to SELECT all of the columns in the EMPLOYEE table but only return 5 rows   ( 5 marks )
 
*/
select * from EMPLOYEE
limit 5;




/*
 Question 3
 
  Write a statement to SELECT all of the columns from the PROJECT table where there is more than 3 PRSTAFF  ( 5 marks )
 
*/
select * from project
where PRSTAFF > 3;



/*
 Question 4
 
 Write a statement to SELECT PROJNO and RESPEMP AND the date fields from the PROJECT table where the project was still running on July 1 2002 (5 marks) 
 
*/


/*
I dont know whether to include only startdate or enddate so I included both. Please don't mind
Output is correct
there are 2 quesries, both performs similarly
*/

select PROJNO, RESPEMP, PRSTDATE,PRENDATE from PROJECT
where PRENDATE > "2002-07-01" && PRSTDATE < "2002-07-01";

select PROJNO, RESPEMP, PRSTDATE,PRENDATE from PROJECT
where PRENDATE > "2002-07-01";


/*
 Question 5
 
  Write a statement to SELECT PROJNO, PROJNAME AND DEPTNO from the PROJECT table where PROJNAME has the word PROGRAMMING in it   ( 5 marks )
 
   
 */
 
 select PROJNO, PROJNAME, DEPTNO from PROJECT
 where PROJNAME like "%PROGRAMMING%";

/*
 Question 6
 
  Write a statement to SELECT from the PROJECT table where MAJPROJ starts with AD and has 4 wildcard place holders   ( 5 marks )
 
  
 */
 select * from PROJECT
 where MAJPROJ like "AD%____";

/*
 Question 7
 
 Write a statement to SELECT from the EMPLOYEE table where that returns all the records where the JOB name is 5 characters long (make sure to remove any spaces) ( 5 marks )
  
 */
 select * from employee
 where length(trim(JOB)) = 5;

  
 
 /*
 Question 8
 
 Write a statement to SELECT the EMPNO and put the  FIRSTNME AND the LASTNAME column  together with a space in between and call it FULLNAME from the EMPLOYEE table as columns  ( 5 marks ) (HINT substring functions)
 
  
 */
 

select EMPNO, CONCAT(FIRSTNME," ",LASTNAME) AS "FULLNAME" from employee;
/*I have used the concept of concetenation*/
 
 /*
 Question 9
 
 Write a statement to SELECT the EMPNO and the first 4 characters of the FIRSTNME AND the starting at the 2nd character to the end of the LASTNAME column from  the EMPLOYEE table as columns  ( 5 marks ) (HINT substring functions)
 
  
 */
 
 
  /*
 I have make 2 different queries
 1st gives the result seperatly in different column
 2nd gives the result using concatenation
 */
 SELECT EMPNO, SUBSTRING(FIRSTNME,1,4), SUBSTRING(LASTNAME,2,LENGTH(LASTNAME)) FROM EMPLOYEE;
 SELECT EMPNO, CONCAT(SUBSTRING(FIRSTNME,1,4),SUBSTRING(LASTNAME,2,LENGTH(LASTNAME))) AS "column" FROM EMPLOYEE;
 
 
 -- I have used the alias just to make the column name more simple.
 
 
 
 
  /*
 Question 10

 Write a statement to SELECT the EMPNO and the YEAR out of the HIRE DATE and the MONTH of out of the birthdate from the EMPLOYEE table as columns  ( 5 marks ) (HINT date functions)
  
 */
 
 
 
 
 /*
 I have make 2 different queries
 1st gives the result seperatly in different column
 2nd gives the result using concatenation
 */
 select EMPNO, year(HIREDATE), month(BIRTHDATE) from employee;
 
 select EMPNO, concat(year(HIREDATE)," ",month(BIRTHDATE)) as "string" from employee;
 