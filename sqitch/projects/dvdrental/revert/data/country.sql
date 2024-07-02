-- Revert db_design_intro_data:data/country from pg

BEGIN;

TRUNCATE TABLE rental.country;

COMMIT;
