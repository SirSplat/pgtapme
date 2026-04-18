-- Verify pgtapme_dev:grants/pgtapme_grants on pg

BEGIN;

SELECT has_database_privilege('pgtapme_readonly', 'pgtapme', 'CONNECT');
SELECT has_database_privilege('pgtapme_readwrite', 'pgtapme', 'CONNECT');
SELECT has_schema_privilege('pgtapme_readonly', 'pgtapme', 'USAGE');
SELECT has_schema_privilege('pgtapme_readwrite', 'pgtapme', 'USAGE');
SELECT has_language_privilege('pgtapme_readonly', 'plpgsql', 'USAGE');
SELECT has_language_privilege('pgtapme_readwrite', 'plpgsql', 'USAGE');

ROLLBACK;
