-- Verify pgtapme_dev:roles/pgtapme_roles on pg

BEGIN;

SELECT rolname FROM pg_catalog.pg_roles WHERE rolname IN ('pgtapme_readonly', 'pgtapme_readwrite');

ROLLBACK;
