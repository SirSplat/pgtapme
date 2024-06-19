-- Verify db_design_intro:functions/last_day-FUNC on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental.last_day(timestamp without time zone)', 'execute' );

ROLLBACK;
