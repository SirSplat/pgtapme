-- Revert db_design_intro:indexes/film_category_pk from pg

BEGIN;

ALTER TABLE ONLY rental.film_category
    DROP CONSTRAINT film_category_pk;

COMMIT;
