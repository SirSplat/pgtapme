-- Revert pgtapme_dev:roles/pgtapme_roles from pg

BEGIN;

REVOKE pgtapme_readonly FROM dbo;
REVOKE pgtapme_readwrite FROM dbo;

DROP ROLE pgtapme_readwrite;
DROP ROLE pgtapme_readonly;

COMMIT;
