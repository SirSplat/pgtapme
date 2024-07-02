-- Revert db_design_intro_data:data/rental from pg

BEGIN;

TRUNCATE TABLE rental.rental;

COMMIT;
