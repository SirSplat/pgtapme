-- Deploy pgtapme_dev:comment/gist_ext to pg
-- requires: extschema
-- requires: gist_ext

BEGIN;

COMMENT ON EXTENSION btree_gist IS 'Used in exclusion constraint function.';

COMMIT;
