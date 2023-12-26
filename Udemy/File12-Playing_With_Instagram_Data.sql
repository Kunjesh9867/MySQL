USE ig_clone;
SHOW TABLES;
SELECT * FROM users;

-- CHALLENGE #1 = We want to reward our users who have been around the longest.
-- Find the 5 oldest users.
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

-- CHALLENGE #2 =  What day of the week do most users register on?
-- We need to figure out when to schedule an ad campaign

SELECT  DAYNAME(created_at),COUNT(created_at) AS count FROM users
GROUP BY DAYNAME(created_at)
HAVING count = 16;

-- CHALLENGE #3 = We want to target our inactive users with an email campaign.
-- Find the users who have never posted a photo;
SHOW TABLES;
SELECT * FROM photos;

SELECT  username, image_url FROM users u
LEFT JOIN photos p on u.id = p.user_id
WHERE user_id IS NULL;


-- CHALLENGE #4 = We're running a new contest to see who can get the most likes on a single photo.
SHOW TABLES;
SELECT * FROM likes;
SELECT * FROM users;
SELECT * FROM photos;


SELECT username, COUNT(likes.user_id) AS count, photo_id  FROM likes
JOIN users ON likes.user_id = users.id
JOIN photos ON likes.photo_id = photos.id
GROUP BY photo_id
ORDER BY count DESC
LIMIT 1;

SELECT COUNT(user_id) AS count, photo_id  FROM likes
GROUP BY photo_id
ORDER BY count DESC
LIMIT 1;

-- SIR
SELECT
    username,
    photos.id,
    photos.image_url,
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- SIR
SELECT username,
       photos.id,
       photos.image_url,
       COUNT(*) AS total
FROM photos
         INNER JOIN likes
                    ON likes.photo_id = photos.id
         INNER JOIN users
                    ON photos.user_id = users.id
GROUP BY photos.id
HAVING total = (SELECT MAX(total) FROM (SELECT COUNT(*) as total FROM likes GROUP BY photo_id) as x);



