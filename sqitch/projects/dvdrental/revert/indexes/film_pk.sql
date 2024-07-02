-- Revert db_design_intro:indexes/film_pk from pg

BEGIN;

ALTER TABLE ONLY rental.film
    DROP CONSTRAINT film_pk;

COMMIT;
