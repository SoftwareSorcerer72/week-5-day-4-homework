CREATE OR REPLACE PROCEDURE insert_film(   -- Question 1
    in_title VARCHAR(255),
    in_description TEXT,
    in_release_year INT,
    in_language_id INT,
    in_rental_duration INT,
    in_rental_rate NUMERIC(4, 2),
    in_length INT,
    in_replacement_cost NUMERIC(5, 2),
    in_rating VARCHAR(5)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO film (
        title,
        description,
        release_year,
        language_id,
        rental_duration,
        rental_rate,
        length,
        replacement_cost,
        rating
    )
    VALUES (
        in_title,
        in_description,
        in_release_year,
        in_language_id,
        in_rental_duration,
        in_rental_rate,
        in_length,
        in_replacement_cost,
        CAST(in_rating AS mpaa_rating) -- Cast the rating to mpaa_rating type
    );
END;
$$;


SELECT *
FROM film;



CALL insert_film(
    'AHHHHHH',
    'Stereotypical Horror movie',
    2024,
    1,
    3,
    4.99,
    120,
    14.99,
    'PG-13'
);


SELECT *
FROM film;


--1005	AHHHHHH	Stereotypical Horror movie	2024	1	3	4.99	120	14.99	PG-13	2024-03-28 05:32:10.774	NULL	'ahhhhhh':1 'horror':3 'movi':4 'stereotyp':2







CREATE OR REPLACE FUNCTION get_film_count_by_categories(  -- Question 2
    in_category_ids INT[]
)
RETURNS TABLE (
    cat_id INT,
    film_count INT
)
AS $$
BEGIN
    FOR cat_id IN SELECT unnest(in_category_ids) LOOP
        RETURN QUERY
        SELECT cat_id, COUNT(*)::INT
        FROM film_category
        WHERE film_category.category_id = cat_id;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


SELECT *
FROM get_film_count_by_categories(ARRAY[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);

--1	64
--2	66
--3	60
--4	57
--5	58
--6	68
--7	62
--8	69
--9	73
--10	61
--11	56
--12	51
--13	63
--14	61
--15	74
--16	57
