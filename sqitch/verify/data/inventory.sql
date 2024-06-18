-- Verify db_design_intro_data:data/inventory on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.inventory);
    ASSERT result = 4581;
END
$$;

ROLLBACK;
