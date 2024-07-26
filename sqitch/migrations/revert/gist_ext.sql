-- Revert pgtapme_dev:gist_ext from pg

BEGIN;

DROP EXTENSION btree_gist;

COMMIT;
