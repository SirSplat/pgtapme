-- Verify db_design_intro:tables/customer on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.customer', 'insert' );

ROLLBACK;
