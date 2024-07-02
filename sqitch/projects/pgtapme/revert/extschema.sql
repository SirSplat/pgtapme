-- Revert pgtapme_dev:extschema from pg

BEGIN;

DROP SCHEMA exts;

COMMIT;
