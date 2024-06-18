-- Verify db_design_intro:views/customer_list on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.customer_list', 'select' );

ROLLBACK;
