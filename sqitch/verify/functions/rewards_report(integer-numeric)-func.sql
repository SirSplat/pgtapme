-- Verify db_design_intro:functions/rewards_report(integer-numeric)-func on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental.rewards_report( integer, numeric )', 'execute' );

ROLLBACK;
