-- Verify db_design_intro:foreign_keys/film_category_film_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'film_category_film_id_fk' AND
    conrelid = 'rental.film_category'::regclass AND
    contype = 'f';

ROLLBACK;
