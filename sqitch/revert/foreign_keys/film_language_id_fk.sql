-- Revert db_design_intro:foreign_keys/film_language_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.film
    DROP CONSTRAINT film_language_id_fk;

COMMIT;
