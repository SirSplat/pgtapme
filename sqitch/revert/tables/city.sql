-- Revert db_design_intro:tables/city from pg

BEGIN;

DROP TABLE rental.city;

COMMIT;
