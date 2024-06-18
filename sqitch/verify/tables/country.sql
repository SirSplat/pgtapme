-- Verify db_design_intro:tables/country on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.country', 'insert' );

ROLLBACK;
