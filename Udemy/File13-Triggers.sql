SHOW DATABASES;
/*
                        THE SYNTAX

    trigger_time        trigger_event     ON  table_name
     BEFORE               INSERT               photos
     AFTER                UPDATE               users
                          DELETE
*/

# What is Trigger?
-- SQL statements that are automatically run when a specific table is changed

DELIMITER $$
CREATE TRIGGER must_be_adult
    BEFORE INSERT ON users FOR EACH ROW
    BEGIN
        IF NEW.age < 18
        THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Must be an adult';
        END IF;

END;
$$

DELIMITER ;


-- Example
USE ig_clone;
DELIMITER $$
CREATE TRIGGER must_be_adult
    BEFORE INSERT ON follows FOR EACH ROW
    BEGIN
        IF NEW.follower_id = NEW.followee_id
        THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'You can\'t follow yourself' ;
        END IF;

END;
$$

DELIMITER ;

INSERT INTO follows(follower_id, followee_id) VALUES(4,4);



--
CREATE TABLE unfollows (
    follower_id INTEGER NOT NULL,
    followee_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);
--


-- Example 2
#part 1
DELIMITER $$
CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows(followee_id, follower_id)
            VALUES (OLD.followee_id, OLD.follower_id);
END;
$$

DELIMITER ;


-- part 2
DELIMITER $$
CREATE TRIGGER capture_unfollow
    AFTER DELETE ON follows FOR EACH ROW
    BEGIN
        INSERT INTO unfollows
            SET follower_id = OLD.follower_id,
                followee_id = OLD.followee_id;
END;
$$

DELIMITER ;