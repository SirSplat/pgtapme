-- Verify fdw_source:pgtap_ext on pg

BEGIN;

SELECT 1 / COUNT(extname) FROM pg_catalog.pg_extension WHERE extname = 'pgtap';

ROLLBACK;
