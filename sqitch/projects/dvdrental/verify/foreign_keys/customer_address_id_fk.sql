-- Verify db_design_intro:foreign_keys/customer_address_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'customer_address_id_fk' AND
    conrelid = 'rental.customer'::regclass AND
    contype = 'f';

ROLLBACK;
