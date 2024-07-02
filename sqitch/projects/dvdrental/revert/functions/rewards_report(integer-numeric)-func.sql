-- Revert db_design_intro:functions/rewards_report(integer-numeric)-func from pg

BEGIN;

DROP FUNCTION rental.rewards_report( integer, numeric );

COMMIT;
