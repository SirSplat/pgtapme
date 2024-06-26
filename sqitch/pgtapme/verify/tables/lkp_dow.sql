-- Verify pgtapme_dev:tables/lkp_dow on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.lkp_dow', 'INSERT, DELETE, UPDATE' );

ROLLBACK;
