-- Deploy fdw_source:pgtap_ext to pg
-- requires: appschema

BEGIN;

CREATE EXTENSION IF NOT EXISTS pgtap;

COMMIT;
