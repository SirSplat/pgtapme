-- Verify pgtapme_dev:appschema_comment on pg

BEGIN;

SELECT
    1 / COUNT( * )
FROM
    pg_catalog.pg_description
    JOIN pg_catalog.pg_namespace ON (
        pg_namespace.oid = pg_description.objoid
    )
WHERE
    pg_description.classoid::REGCLASS::TEXT = 'pg_namespace' AND
    pg_description.objsubid::REGCLASS::TEXT = '-' AND
    pg_namespace.nspname = 'pgtapme';

ROLLBACK;
