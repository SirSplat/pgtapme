-- Revert pgtapme_dev:appschema_comment from pg

BEGIN;

COMMENT ON SCHEMA pgtapme IS NULL;

COMMIT;
