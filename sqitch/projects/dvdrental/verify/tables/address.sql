-- Verify db_design_intro:tables/address on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( current_user, 'rental.address', 'insert' );

ROLLBACK;
