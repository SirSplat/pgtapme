-- Revert db_design_intro_data:data/customer from pg

BEGIN;

TRUNCATE TABLE rental.customer;

COMMIT;
