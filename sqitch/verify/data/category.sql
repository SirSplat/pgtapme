-- Verify db_design_intro_data:data/category on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.category);
    ASSERT result = 16;
END
$$;

ROLLBACK;
