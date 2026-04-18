-- Verify fdw_source:tables/remote_items on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'fdw_source.remote_items', 'INSERT, DELETE, UPDATE' );

ROLLBACK;
