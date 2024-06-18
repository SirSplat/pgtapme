-- Revert db_design_intro:foreign_keys/film_actor_film_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.film_actor
    DROP CONSTRAINT film_actor_film_id_fk;

COMMIT;
