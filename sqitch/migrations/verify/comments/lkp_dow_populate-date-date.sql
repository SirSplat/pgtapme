-- Verify pgtapme_dev:comments/lkp_dow_populate-date-date on pg

BEGIN;

SELECT
    1 / COUNT( pg_description.description )
FROM
    pg_catalog.pg_description
    JOIN pg_catalog.pg_proc ON (
        pg_proc.oid = pg_description.objoid
    )
    JOIN pg_catalog.pg_namespace ON (
        pg_namespace.oid = pg_proc.pronamespace
    )
WHERE
    pg_namespace.nspname = 'pgtapme' AND
    pg_proc.proname = 'lkp_dow_populate' AND
    array_to_string(
        ARRAY(
            SELECT pg_catalog.format_type(t::oid, NULL)
            FROM unnest(pg_proc.proargtypes) AS t
        ),
        ', '
    ) = 'date, date';

ROLLBACK;
