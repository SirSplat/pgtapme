-- Verify db_design_intro_data:data/customer on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.customer);
    ASSERT result = 599;
END
$$;

ROLLBACK;
