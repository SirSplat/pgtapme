-- Verify db_design_intro_data:data/store on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.store);
    ASSERT result = 2;
END
$$;

ROLLBACK;
