-- Verify db_design_intro_data:data/film_actor on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.film_actor);
    ASSERT result = 5462;
END
$$;

ROLLBACK;
