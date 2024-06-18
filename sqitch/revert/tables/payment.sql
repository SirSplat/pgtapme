-- Revert db_design_intro:tables/payment from pg

BEGIN;

DROP TABLE rental.payment;

COMMIT;
