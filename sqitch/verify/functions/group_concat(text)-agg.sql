-- Verify db_design_intro:functions/group_concat(text)-agg on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental.group_concat(text)', 'execute' );

ROLLBACK;
