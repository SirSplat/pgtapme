-- Verify pgtapme_dev:appschema on pg

BEGIN;

SELECT pg_catalog.has_schema_privileges( CURRENT_USER, 'pgtapme', 'usage' );

ROLLBACK;
