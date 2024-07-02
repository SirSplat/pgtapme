-- Revert db_design_intro_data:data/film_actor from pg

BEGIN;

TRUNCATE TABLE rental.film_actor;

COMMIT;
