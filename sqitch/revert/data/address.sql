-- Revert db_design_intro_data:data/address from pg

BEGIN;

TRUNCATE TABLE rental.address;

COMMIT;
