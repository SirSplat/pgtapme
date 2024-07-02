-- Verify db_design_intro:functions/_group_concat-FUNC on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental._group_concat(text, text)', 'execute' );

ROLLBACK;
