-- Revert db_design_intro_data:data/film_category from pg

BEGIN;

TRUNCATE TABLE rental.film_category;

COMMIT;
