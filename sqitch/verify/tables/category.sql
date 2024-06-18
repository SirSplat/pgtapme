-- Verify db_design_intro:tables/category on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.category', 'insert' );

ROLLBACK;
