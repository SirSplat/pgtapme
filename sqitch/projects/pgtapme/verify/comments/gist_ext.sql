-- Verify pgtapme_dev:comment/gist_ext on pg

BEGIN;

SELECT
    1 / COUNT( pg_extension.extname )
FROM
    pg_catalog.pg_extension
    JOIN pg_catalog.pg_namespace ON (
        pg_namespace.oid = pg_extension.extnamespace
    )
WHERE
    pg_namespace.nspname = 'exts' AND
    pg_extension.extname = 'btree_gist';

ROLLBACK;
