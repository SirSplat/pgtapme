-- Revert db_design_intro:tables/film from pg

BEGIN;

DROP TABLE rental.film;

COMMIT;
