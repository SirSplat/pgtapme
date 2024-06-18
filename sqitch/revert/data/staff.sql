-- Revert db_design_intro_data:data/staff from pg

BEGIN;

TRUNCATE TABLE rental.staff;

COMMIT;
