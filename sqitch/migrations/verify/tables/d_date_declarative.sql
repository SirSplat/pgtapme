-- Verify pgtapme_dev:tables/d_date_declarative on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_declarative', 'INSERT, DELETE, UPDATE' );

ROLLBACK;
