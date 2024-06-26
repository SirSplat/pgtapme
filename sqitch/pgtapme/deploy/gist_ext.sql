-- Deploy pgtapme_dev:gist_ext to pg
-- requires: extschema

BEGIN;

CREATE EXTENSION btree_gist WITH SCHEMA pgtapme_ext;

COMMIT;
