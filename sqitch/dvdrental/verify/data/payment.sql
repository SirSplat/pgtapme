-- Verify db_design_intro_data:data/payment on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.payment);
    ASSERT result = 14596;
END
$$;

ROLLBACK;
