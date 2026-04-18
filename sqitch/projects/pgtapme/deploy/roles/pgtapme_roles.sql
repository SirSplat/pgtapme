-- Deploy pgtapme_dev:roles/pgtapme_roles to pg

BEGIN;

CREATE ROLE pgtapme_readonly;
CREATE ROLE pgtapme_readwrite;

GRANT pgtapme_readonly TO dbo;
GRANT pgtapme_readwrite TO dbo;

COMMIT;
