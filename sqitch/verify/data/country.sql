-- Verify db_design_intro_data:data/country on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.country);
    ASSERT result = 109;
END
$$;

ROLLBACK;
