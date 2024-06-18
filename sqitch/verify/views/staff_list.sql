-- Verify db_design_intro:views/staff_list on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.staff_list', 'select' );

ROLLBACK;
