-- Verify db_design_intro:functions/inventory_held_by_customer(integer)-func on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental.inventory_held_by_customer( integer )', 'execute' );

ROLLBACK;
