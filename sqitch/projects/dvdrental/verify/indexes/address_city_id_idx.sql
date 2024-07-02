-- Verify db_design_intro:indexes/address_city_id_idx on pg

BEGIN;

SELECT
    1 / COUNT( pg_indexes.indexname )
FROM
    pg_catalog.pg_indexes
WHERE
    pg_indexes.schemaname = 'rental' AND
    pg_indexes.tablename = 'address' AND
    pg_indexes.indexname = 'address_city_id_idx';

ROLLBACK;
