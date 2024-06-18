-- Verify db_design_intro:data/customer_customer_id_seq on pg

BEGIN;

SELECT
    1 / COUNT( sequencename )
FROM
    pg_catalog.pg_sequences
WHERE
    schemaname = 'rental' AND
    sequencename = 'customer_customer_id_seq';

ROLLBACK;
