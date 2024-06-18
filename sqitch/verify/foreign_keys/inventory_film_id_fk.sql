-- Verify db_design_intro:foreign_keys/inventory_film_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'inventory_film_id_fk' AND
    conrelid = 'rental.inventory'::regclass AND
    contype = 'f';

ROLLBACK;
