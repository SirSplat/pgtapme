-- Verify db_design_intro:tables/language on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.language', 'insert' );

ROLLBACK;
