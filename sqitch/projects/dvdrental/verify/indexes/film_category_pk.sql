-- Verify db_design_intro:indexes/film_category_pk on pg

BEGIN;

SELECT
    1 / COUNT( pgci.relname )
FROM
    pg_catalog.pg_class
    JOIN pg_catalog.pg_namespace ON (
        pg_namespace.oid = pg_class.relnamespace
    )
    JOIN pg_catalog.pg_index ON (
        pg_index.indrelid = pg_class.oid
    )
    JOIN pg_catalog.pg_class AS pgci ON (
        pgci.oid = pg_index.indexrelid
    )
WHERE
    pg_namespace.nspname = 'rental' AND
    pg_class.relname = 'film_category' AND
    pgci.relname = 'film_category_pk' AND
    pg_index.indisprimary;

ROLLBACK;
