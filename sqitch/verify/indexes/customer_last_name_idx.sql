-- Verify db_design_intro:indexes/customer_last_name_idx on pg

BEGIN;

SELECT
    1 / COUNT( pg_indexes.indexname )
FROM
    pg_catalog.pg_indexes
WHERE
    pg_indexes.schemaname = 'rental' AND
    pg_indexes.tablename = 'customer' AND
    pg_indexes.indexname = 'customer_last_name_idx';

ROLLBACK;
