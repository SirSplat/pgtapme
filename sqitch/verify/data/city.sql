-- Verify db_design_intro_data:data/city on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.city);
    ASSERT result = 600;
END
$$;

ROLLBACK;
