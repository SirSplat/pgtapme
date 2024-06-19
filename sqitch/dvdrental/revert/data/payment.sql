-- Revert db_design_intro_data:data/payment from pg

BEGIN;

TRUNCATE TABLE rental.payment;

COMMIT;
