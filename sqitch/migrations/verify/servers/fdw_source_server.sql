-- Verify pgtapme_dev:servers/fdw_source_server on pg

BEGIN;

SELECT 1 / COUNT(srvname) FROM pg_catalog.pg_foreign_server WHERE srvname = 'fdw_source_server';

ROLLBACK;
