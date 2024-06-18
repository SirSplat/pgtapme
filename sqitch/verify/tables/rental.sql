-- Verify db_design_intro:tables/rental on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.rental', 'insert' );

ROLLBACK;
