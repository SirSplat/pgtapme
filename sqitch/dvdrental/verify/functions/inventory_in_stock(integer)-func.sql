-- Verify db_design_intro:functions/inventory_in_stock(integer)-func on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( current_user, 'rental.inventory_in_stock(integer)', 'execute' );

ROLLBACK;
