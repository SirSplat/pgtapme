-- Deploy db_design_intro:indexes/film_actor_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.film_actor
    ADD CONSTRAINT film_actor_pk PRIMARY KEY (actor_id, film_id);

COMMIT;
