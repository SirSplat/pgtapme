-- Verify pgtapme_dev:extschema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege( CURRENT_USER, 'exts', 'USAGE' );

ROLLBACK;