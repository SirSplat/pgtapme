-- Revert db_design_intro:indexes/film_actor_pk from pg

BEGIN;

ALTER TABLE ONLY rental.film_actor
    DROP CONSTRAINT film_actor_pk;

COMMIT;
