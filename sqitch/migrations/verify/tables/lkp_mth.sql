-- Verify pgtapme_dev:tables/lkp_mth on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.lkp_mth', 'INSERT, DELETE, UPDATE' );

ROLLBACK;
