-- Verify pgtapme_dev:policies/pgtapme_rls on pg

BEGIN;

SELECT polname FROM pg_catalog.pg_policy p
JOIN pg_catalog.pg_class c ON c.oid = p.polrelid
JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'pgtapme' AND c.relname = 'lkp_dow'
  AND polname IN ('lkp_dow_readonly_select', 'lkp_dow_readwrite_all');

ROLLBACK;
