-- Revert fdw_source:tables/remote_items from pg

BEGIN;

DROP TABLE fdw_source.remote_items;

COMMIT;
