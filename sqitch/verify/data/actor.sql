-- Verify db_design_intro:data/actor on pg

BEGIN;

DO
$$
DECLARE
    result INTEGER;
BEGIN
    result := (SELECT COUNT(*) FROM rental.actor);
    ASSERT result = 200;
END
$$;

ROLLBACK;
