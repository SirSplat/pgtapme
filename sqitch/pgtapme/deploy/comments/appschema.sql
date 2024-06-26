-- Deploy pgtapme_dev:appschema_comment to pg
-- requires: appschema

BEGIN;

COMMENT ON SCHEMA pgtapme IS 'Home of all pgtapme test dat, DDL and DML, used to test pgtapme.py test file generation functionality.';

COMMIT;
