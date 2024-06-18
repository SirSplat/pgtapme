-- Verify db_design_intro:tables/inventory on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.inventory', 'insert' );

ROLLBACK;
