-- Verify db_design_intro:tables/staff on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.staff', 'insert' );

ROLLBACK;
