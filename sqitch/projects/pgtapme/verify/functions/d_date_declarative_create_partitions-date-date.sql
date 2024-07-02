-- Verify pgtapme_dev:functions/d_date_declarative_create_partitions on pg

BEGIN;

SELECT pg_catalog.has_function_privilege( CURRENT_USER, 'pgtapme.d_date_declarative_create_partitions(date, date)', 'EXECUTE' );

ROLLBACK;
