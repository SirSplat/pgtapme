-- Verify db_design_intro:functions/last_updated()-trg-func on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental.last_updated_trg_func()', 'execute' );

ROLLBACK;
