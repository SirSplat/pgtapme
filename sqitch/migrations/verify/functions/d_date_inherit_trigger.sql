-- Verify pgtapme_dev:functions/d_date_inherit_trigger on pg

BEGIN;

SELECT
    1 / COUNT( pg_trigger.tgname )
FROM
    pg_catalog.pg_trigger
WHERE
    pg_trigger.tgname = 'd_date_inherit_trg';

ROLLBACK;
