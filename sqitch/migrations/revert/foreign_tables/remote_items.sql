-- Revert pgtapme_dev:foreign_tables/remote_items from pg

BEGIN;

DROP FOREIGN TABLE pgtapme.remote_items;

COMMIT;
