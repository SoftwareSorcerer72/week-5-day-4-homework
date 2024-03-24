INSERT INTO film (
	title, 
	description, 
	release_year, 
	language_id, 
	rental_duration, 
	rental_rate, 
	length, 
	replacement_cost, 
	rating)
VALUES ('A Weird Scifi movie', 
	'A strange tale that is almost too science-y to describe', 
	2024, 
	1, 
	3, 
	4.99, 
	120, 
	14.99, 
	'PG-13');
	
SELECT *
FROM film;

UPDATE film
SET description = 'The story of a young man discovering the power of space travel using a toaster and some WD-40'
WHERE title = 'A Weird Scifi movie';

SELECT *
FROM film;

SELECT * 
FROM film_category fc ;

CREATE OR REPLACE FUNCTION get_film_count_by_category(category_id INT)
RETURNS INT AS $$
DECLARE
    film_count INT;
BEGIN
    SELECT COUNT(*) INTO film_count
    FROM film_category
    WHERE film_category.category_id = get_film_count_by_category.category_id;
    RETURN film_count;
END;
$$ LANGUAGE plpgsql;


SELECT get_film_count_by_category(1);