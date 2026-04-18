-- Verify pgtapme_dev:materialized_views/lkp_mth_mv on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.lkp_mth_mv', 'SELECT' );

ROLLBACK;
