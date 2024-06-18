-- Deploy db_design_intro:indexes/film_actor_film_id_idx to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

CREATE INDEX film_actor_film_id_idx ON rental.film_actor(film_id);

COMMIT;
