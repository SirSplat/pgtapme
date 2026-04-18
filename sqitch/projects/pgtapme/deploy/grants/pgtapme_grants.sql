-- Deploy pgtapme_dev:grants/pgtapme_grants to pg

BEGIN;

-- Database privileges
GRANT CONNECT ON DATABASE pgtapme TO pgtapme_readonly;
GRANT CONNECT ON DATABASE pgtapme TO pgtapme_readwrite;

-- Schema privileges
GRANT USAGE ON SCHEMA pgtapme TO pgtapme_readonly;
GRANT USAGE, CREATE ON SCHEMA pgtapme TO pgtapme_readwrite;

-- Table privileges
GRANT SELECT ON ALL TABLES IN SCHEMA pgtapme TO pgtapme_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pgtapme TO pgtapme_readwrite;

-- Sequence privileges
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA pgtapme TO pgtapme_readonly;
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA pgtapme TO pgtapme_readwrite;

-- Function privileges
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA pgtapme TO pgtapme_readonly;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA pgtapme TO pgtapme_readwrite;

-- Language privileges
GRANT USAGE ON LANGUAGE plpgsql TO pgtapme_readonly;
GRANT USAGE ON LANGUAGE plpgsql TO pgtapme_readwrite;

COMMIT;
