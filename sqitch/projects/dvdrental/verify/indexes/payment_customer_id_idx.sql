-- Verify db_design_intro:indexes/payment_customer_id_idx on pg

BEGIN;

SELECT
    1 / COUNT( pg_indexes.indexname )
FROM
    pg_catalog.pg_indexes
WHERE
    pg_indexes.schemaname = 'rental' AND
    pg_indexes.tablename = 'payment' AND
    pg_indexes.indexname = 'payment_customer_id_idx';

ROLLBACK;
