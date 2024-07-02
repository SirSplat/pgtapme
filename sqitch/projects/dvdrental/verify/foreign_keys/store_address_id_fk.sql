-- Verify db_design_intro:foreign_keys/store_address_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'store_address_id_fk' AND
    conrelid = 'rental.store'::regclass AND
    contype = 'f';

ROLLBACK;
