-- Verify pgtapme_dev:tables/d_date_with_exclusion_constraint on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_exclusion', 'INSERT, DELETE, UPDATE' );

ROLLBACK;
