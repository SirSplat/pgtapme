-- Revert db_design_intro:tables/film_actor from pg

BEGIN;

DROP TABLE rental.film_actor;

COMMIT;
