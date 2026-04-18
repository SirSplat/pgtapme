-- Revert fdw_source:appschema from pg

BEGIN;

DROP SCHEMA fdw_source;

COMMIT;
