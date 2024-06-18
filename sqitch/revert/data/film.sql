-- Revert db_design_intro_data:data/film from pg

BEGIN;

TRUNCATE TABLE rental.film;

COMMIT;
