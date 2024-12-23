-- Deploy pgtapme_dev:appschema to pg

BEGIN;

CREATE SCHEMA pgtapme;

ALTER DEFAULT PRIVILEGES
    IN SCHEMA pgtapme
    REVOKE ALL
    ON TABLES
    FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
    IN SCHEMA pgtapme
    REVOKE ALL
    ON SEQUENCES
    FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
    IN SCHEMA pgtapme
    REVOKE ALL
    ON FUNCTIONS
    FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
    IN SCHEMA pgtapme
    REVOKE ALL
    ON TYPES
    FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
    REVOKE ALL
    ON SCHEMAS
    FROM PUBLIC;

COMMIT;
