-- Revert db_design_intro:functions/last_day-FUNC from pg

BEGIN;

DROP FUNCTION rental.last_day( timestamp without time zone );

COMMIT;
