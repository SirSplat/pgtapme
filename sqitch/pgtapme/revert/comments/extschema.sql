-- Revert pgtapme_dev:extschema_comment from pg

BEGIN;

COMMENT ON SCHEMA pgtapme_ext IS NULL;

COMMIT;
