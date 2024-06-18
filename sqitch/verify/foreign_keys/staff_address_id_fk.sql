-- Verify db_design_intro:foreign_keys/staff_address_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'staff_address_id_fk' AND
    conrelid = 'rental.staff'::regclass AND
    contype = 'f';

ROLLBACK;
