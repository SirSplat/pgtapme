-- Verify db_design_intro_data:data/rental on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.rental);
    ASSERT result = 16044;
END
$$;

ROLLBACK;
