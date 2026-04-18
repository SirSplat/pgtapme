-- Verify pgtapme_dev:foreign_tables/remote_items on pg

BEGIN;

SELECT 1 / COUNT(*)
FROM pg_catalog.pg_foreign_table ft
JOIN pg_catalog.pg_class c ON c.oid = ft.ftrelid
JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'pgtapme' AND c.relname = 'remote_items';

ROLLBACK;
