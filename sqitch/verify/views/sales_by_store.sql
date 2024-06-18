-- Verify db_design_intro:views/sales_by_store on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.sales_by_store', 'select' );

ROLLBACK;
