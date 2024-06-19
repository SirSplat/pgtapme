-- Verify db_design_intro_data:data/film on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.film);
    ASSERT result = 1000;
END
$$;

ROLLBACK;
