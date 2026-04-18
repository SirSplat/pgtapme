-- Revert pgtapme_dev:user_mappings/dbo_fdw_source from pg

BEGIN;

DROP USER MAPPING FOR dbo SERVER fdw_source_server;

COMMIT;
