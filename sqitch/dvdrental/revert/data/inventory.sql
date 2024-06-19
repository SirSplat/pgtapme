-- Revert db_design_intro_data:data/inventory from pg

BEGIN;

TRUNCATE TABLE rental.inventory;

COMMIT;
