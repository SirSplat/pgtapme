-- Revert db_design_intro:foreign_keys/film_category_film_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.film_category
    DROP CONSTRAINT film_category_film_id_fk;

COMMIT;
