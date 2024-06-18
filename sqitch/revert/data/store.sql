-- Revert db_design_intro_data:data/store from pg

BEGIN;

TRUNCATE TABLE rental.store;

COMMIT;
