-- Revert pgtapme_dev:servers/fdw_source_server from pg

BEGIN;

DROP SERVER fdw_source_server CASCADE;

COMMIT;
