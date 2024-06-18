-- Revert db_design_intro:tables/address from pg

BEGIN;

DROP TABLE rental.address;

COMMIT;
