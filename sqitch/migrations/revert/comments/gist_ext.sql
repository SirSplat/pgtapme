-- Revert pgtapme_dev:comment/gist_ext from pg

BEGIN;

COMMENT ON EXTENSION btree_gist IS NULL;

COMMIT;
