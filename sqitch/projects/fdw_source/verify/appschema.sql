-- Verify fdw_source:appschema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege( CURRENT_USER, 'fdw_source', 'USAGE' );

ROLLBACK;
