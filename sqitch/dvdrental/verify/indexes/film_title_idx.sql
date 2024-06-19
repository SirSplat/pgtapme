-- Verify db_design_intro:indexes/film_title_idx on pg

BEGIN;

SELECT
    1 / COUNT( pg_indexes.indexname )
FROM
    pg_catalog.pg_indexes
WHERE
    pg_indexes.schemaname = 'rental' AND
    pg_indexes.tablename = 'film' AND
    pg_indexes.indexname = 'film_title_idx';

ROLLBACK;
