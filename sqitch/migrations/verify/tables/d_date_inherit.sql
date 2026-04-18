-- Verify pgtapme_dev:tables/d_date_inherit on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit', 'INSERT, DELETE, UPDATE' );

ROLLBACK;
