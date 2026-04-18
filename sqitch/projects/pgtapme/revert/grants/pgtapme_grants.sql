-- Revert pgtapme_dev:grants/pgtapme_grants from pg

BEGIN;

REVOKE USAGE ON LANGUAGE plpgsql FROM pgtapme_readonly, pgtapme_readwrite;

REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA pgtapme FROM pgtapme_readonly, pgtapme_readwrite;

REVOKE USAGE, SELECT ON ALL SEQUENCES IN SCHEMA pgtapme FROM pgtapme_readonly;
REVOKE USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA pgtapme FROM pgtapme_readwrite;

REVOKE SELECT ON ALL TABLES IN SCHEMA pgtapme FROM pgtapme_readonly;
REVOKE SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pgtapme FROM pgtapme_readwrite;

REVOKE USAGE ON SCHEMA pgtapme FROM pgtapme_readonly;
REVOKE USAGE, CREATE ON SCHEMA pgtapme FROM pgtapme_readwrite;

REVOKE CONNECT ON DATABASE pgtapme FROM pgtapme_readonly, pgtapme_readwrite;

COMMIT;
