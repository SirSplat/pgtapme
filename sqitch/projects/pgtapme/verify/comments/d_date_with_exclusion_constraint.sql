-- Verify pgtapme_dev:comments/d_date_with_exclusion_constraint on pg

BEGIN;

SELECT
    1 / COUNT( pg_description.objoid )
FROM
    pg_catalog.pg_description
    JOIN pg_catalog.pg_class ON (
        pg_class.oid = pg_description.objoid
    )
    JOIN pg_catalog.pg_namespace ON (
        pg_namespace.oid = pg_class.relnamespace
    )
WHERE
    pg_description.classoid::REGCLASS::TEXT = 'pg_class' AND
    pg_description.objsubid::REGCLASS::TEXT = '-' AND
    pg_namespace.nspname = 'pgtapme' AND
    pg_class.relname = 'd_date_exclusion';

ROLLBACK;
