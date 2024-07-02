-- Verify pgtapme_dev:functions/lkp_mth_populate on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( CURRENT_USER, 'pgtapme.lkp_mth_populate(date, date)', 'EXECUTE' );

ROLLBACK;
