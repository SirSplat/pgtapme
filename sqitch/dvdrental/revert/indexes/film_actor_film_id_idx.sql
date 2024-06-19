-- Revert db_design_intro:indexes/film_actor_film_id_idx from pg

BEGIN;

DROP INDEX rental.film_actor_film_id_idx;

COMMIT;
