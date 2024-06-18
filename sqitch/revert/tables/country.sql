-- Revert db_design_intro:tables/country from pg

BEGIN;

DROP TABLE rental.country;

COMMIT;
