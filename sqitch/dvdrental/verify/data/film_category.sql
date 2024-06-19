-- Verify db_design_intro_data:data/film_category on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.film_category);
    ASSERT result = 1000;
END
$$;

ROLLBACK;
