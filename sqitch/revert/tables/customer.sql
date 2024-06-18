-- Revert db_design_intro:tables/customer from pg

BEGIN;

DROP TABLE rental.customer;

COMMIT;
