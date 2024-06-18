-- Revert db_design_intro_data:data/category from pg

BEGIN;

TRUNCATE TABLE rental.category;

COMMIT;
