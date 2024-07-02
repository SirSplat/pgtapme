-- Verify pgtapme_dev:functions/d_date_inherit_create_trigger_function on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_trg_func()', 'EXECUTE' );

ROLLBACK;
