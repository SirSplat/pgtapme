-- Revert db_design_intro_data:data/city from pg

BEGIN;

TRUNCATE TABLE rental.city;

COMMIT;
