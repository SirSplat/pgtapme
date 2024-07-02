-- Verify db_design_intro:tables/payment on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.payment', 'insert' );

ROLLBACK;
