-- Verify db_design_intro:foreign_keys/rental_customer_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'rental_customer_id_fk' AND
    conrelid = 'rental.rental'::regclass AND
    contype = 'f';

ROLLBACK;
