-- Revert pgtapme_dev:extschema from pg

BEGIN;

DROP SCHEMA pgtapme_ext;

COMMIT;
