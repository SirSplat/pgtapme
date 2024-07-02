-- Verify db_design_intro:foreign_keys/payment_customer_id_fk on pg

BEGIN;

SELECT
    1 / COUNT( conname )
FROM
    pg_catalog.pg_constraint
WHERE
    conname = 'payment_customer_id_fk' AND
    conrelid = 'rental.payment'::regclass AND
    contype = 'f';

ROLLBACK;
