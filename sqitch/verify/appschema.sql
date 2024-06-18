-- Verify db_design_intro:appschema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege( 'rental', 'usage' );

ROLLBACK;
