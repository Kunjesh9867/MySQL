### SECURING DATABASES ###


# (2) CREATING A USER

/*
CREATE USER john@127.521.4.21
                @ {Empty: means john can connect from anywhere}
                @ip address
                @hostname
                @domain name '%.codewithkunjesh.com'

CREATE USER john IDENTIFIED BY '1234';
*/
CREATE USER john IDENTIFIED BY '1234';

# (3) VIEWING USERS
SELECT * FROM mysql.user;

/*
localhost means Have to be in the same PC
*/

# (3) DROPPING USERS
CREATE USER bob@codewithkunjesh.com IDENTIFIED BY '1234';
DROP USER bob@codewithkunjesh.com;

# (4) CHANGING PASSWORDS
-- People forgets their passwords :smile:
SET PASSWORD FOR john = '1234';

-- for you
SET PASSWORD = '1234';

# (5) GRANTING PRIVILEGES

-- 1 = Web/desktop application
CREATE USER moon_app IDENTIFIED BY '1234';

GRANT SELECT,INSERT,UPDATE,DELETE,EXECUTE
ON sql_store.*  -- sql_store.customer
TO moon_app;

/*
make a connection of moon_app
try to run query in sql_store
*/


-- 2 = admin

-- Search: `MySQL privileges` in Google
GRANT ALL
ON *.*
To john;


# (6) VIEWING PRIVILEGES

-- We can do this in 2 ways: navigator panel or Cmd
SHOW GRANTS FOR john;

-- for current user
SHOW GRANTS; -- Highest level of privileges

# (7) HOW TO REVOKE PRIVILEGES

-- Giving more privilege from MySQL
GRANT CREATE VIEW
ON sql_store.*
TO  moon_app;

-- Now we have to revoke it
REVOKE CREATE VIEW
ON sql_store.*
FROM  moon_app;
