-- Verify pgtapme_dev:tables/d_date_inherit_create_partitions on pg

BEGIN;

SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m01', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m02', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m03', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m04', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m05', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m06', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m07', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m08', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m09', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m10', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m11', 'INSERT, DELETE, UPDATE' );
SELECT pg_catalog.has_table_privilege( CURRENT_USER, 'pgtapme.d_date_inherit_y0001_m12', 'INSERT, DELETE, UPDATE' );

ROLLBACK;
