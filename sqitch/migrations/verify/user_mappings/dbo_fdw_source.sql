-- Verify pgtapme_dev:user_mappings/dbo_fdw_source on pg

BEGIN;

SELECT 1 / COUNT(*)
FROM pg_catalog.pg_user_mappings
WHERE srvname = 'fdw_source_server'
  AND usename = 'dbo';

ROLLBACK;
