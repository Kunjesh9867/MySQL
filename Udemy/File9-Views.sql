CREATE VIEW full_reviews AS
SELECT title, released_year, genre, rating, first_name, last_name FROM reviews
JOIN series ON series.id = reviews.series_id
JOIN reviewers ON reviewers.id = reviews.reviewer_id;

-- NOW WE CAN TREAT THAT VIEW AS A VIRTUAL TABLE
-- (AT LEAST WHEN IT COMES TO SELECTING)
SELECT * FROM full_reviews;



# UPDATING VIEWS
/*
    Not all views are updatable.
    Only a Subset of views are updatable.
    Look at the documentation about it.
    Views containing Aggregate function or GROUP BY... cannot be updatable.

    If you update the view, the same effect will be applied on the table as well.

*/

# REPLACING, ALTERING & DELETING view
CREATE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

CREATE OR REPLACE VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year DESC;

ALTER VIEW ordered_series AS
SELECT * FROM series ORDER BY released_year;

DROP VIEW ordered_series;


# HAVING = Filtering GROUP BY
SELECT title, AVG(rating), COUNT(rating) AS review_count
FROM full_reviews
GROUP BY title HAVING COUNT(rating) > 1;