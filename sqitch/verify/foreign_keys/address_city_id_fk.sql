-- Verify db_design_intro:foreign_keys/address_city_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'address_city_id_fk' AND
    conrelid = 'rental.address'::regclass AND
    contype = 'f';

ROLLBACK;
