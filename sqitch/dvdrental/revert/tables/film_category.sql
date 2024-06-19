-- Revert db_design_intro:tables/film_category from pg

BEGIN;

DROP TABLE rental.film_category;

COMMIT;
