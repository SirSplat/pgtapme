-- Verify pgtapme_dev:appschema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege( CURRENT_USER, 'pgtapme', 'USAGE' );

ROLLBACK;
