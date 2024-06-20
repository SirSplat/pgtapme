-- Revert pgtapme_dev:appschema from pg

BEGIN;

DROP SCHEMA pgtapme;

COMMIT;
