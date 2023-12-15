/*
    Database vs Database Management System
    MySQL is DBMS not database. MySQL is used to interact with database

    When you learn MySQL, you learn SQL
    (1) MySQL
    (2) SQLite
    (3) PostgreSQL
    (4) Oracle
    All the DBMS follows the rules of SQL. They are identical when writing queries.

    The difference lies in the how they work.
*/

CREATE DATABASE soap_store;
USE soap_store;
SELECT database() -- To see which database is currently selected