-- Verify db_design_intro:triggers/film_fulltext_trg on pg

BEGIN;

SELECT
    1 / COUNT( pg_trigger.tgname )
FROM
    pg_catalog.pg_trigger
    JOIN pg_catalog.pg_class ON (
        pg_class.oid = pg_trigger.tgrelid
    )
    JOIN pg_catalog.pg_namespace ON (
        pg_namespace.oid = pg_class.relnamespace
    )
    JOIN pg_catalog.pg_proc ON (
        pg_proc.oid = pg_trigger.tgfoid
    )
WHERE
    pg_namespace.nspname = 'rental' AND
    pg_class.relname = 'film' AND
    pg_trigger.tgname = 'fulltext_trg' AND
    pg_proc.proname = 'tsvector_update_trigger' AND
    NOT pg_trigger.tgisinternal;

ROLLBACK;
