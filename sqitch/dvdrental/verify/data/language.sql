-- Verify db_design_intro_data:data/language on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.language);
    ASSERT result = 6;
END
$$;

ROLLBACK;
