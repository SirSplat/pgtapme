-- Verify db_design_intro:indexes/city_country_id_idx on pg

BEGIN;

SELECT
    1 / COUNT( pg_indexes.indexname )
FROM
    pg_catalog.pg_indexes
WHERE
    pg_indexes.schemaname = 'rental' AND
    pg_indexes.tablename = 'city' AND
    pg_indexes.indexname = 'city_country_id_idx';

ROLLBACK;
