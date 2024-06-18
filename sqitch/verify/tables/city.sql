-- Verify db_design_intro:tables/city on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.city', 'insert' );

ROLLBACK;
