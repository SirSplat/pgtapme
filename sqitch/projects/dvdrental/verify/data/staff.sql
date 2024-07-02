-- Verify db_design_intro_data:data/staff on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.staff);
    ASSERT result = 2;
END
$$;

ROLLBACK;
