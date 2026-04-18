-- Revert pgtapme_dev:extschema_comment from pg

BEGIN;

COMMENT ON SCHEMA exts IS NULL;

COMMIT;
