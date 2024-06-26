-- Deploy pgtapme_dev:extschema_comment to pg
-- requires: extschema

BEGIN;

COMMENT ON SCHEMA pgtapme_ext IS 'Home of all pgtapme application extension DML.';

COMMIT;
