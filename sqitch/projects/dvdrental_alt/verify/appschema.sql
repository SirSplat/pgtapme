-- Verify dvdrental_alt:appschema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege( CURRENT_USER, 'rental', 'USAGE' );

ROLLBACK;
