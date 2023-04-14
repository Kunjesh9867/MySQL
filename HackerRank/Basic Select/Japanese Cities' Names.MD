# Question

**Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.**

**Query all columns for a city in CITY with the ID 1661.**

| Field       | Type         |
|-------------|--------------|
| ID          | NUMBER       |
| NAME        | VARCHAR2(17) |
| COUNTRYCODE | VARCHAR2(3)  |
| DISTRICT    | VARCHAR2(20) |
| POPULATION  | NUMBER       |

# Answer

    SELECT NAME FROM CITY 
    WHERE COUNTRYCODE = 'JPN';
