-- Verify pgtapme_dev:functions/lkp_dow_populate on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( CURRENT_USER, 'pgtapme.lkp_dow_populate(date, date)', 'EXECUTE' );

ROLLBACK;
