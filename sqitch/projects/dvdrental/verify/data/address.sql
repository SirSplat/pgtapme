-- Verify db_design_intro_data:data/address on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.address);
    ASSERT result = 603;
END
$$;

ROLLBACK;
