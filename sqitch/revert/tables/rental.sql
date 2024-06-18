-- Revert db_design_intro:tables/rental from pg

BEGIN;

DROP TABLE rental.rental;

COMMIT;
