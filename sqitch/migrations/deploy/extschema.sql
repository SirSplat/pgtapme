-- Deploy pgtapme_dev:extschema to pg

BEGIN;

CREATE SCHEMA exts;

ALTER DEFAULT PRIVILEGES
    IN SCHEMA exts
    REVOKE ALL
    ON TABLES
    FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
    IN SCHEMA exts
    REVOKE ALL
    ON SEQUENCES
    FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
    IN SCHEMA exts
    REVOKE ALL
    ON FUNCTIONS
    FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
    IN SCHEMA exts
    REVOKE ALL
    ON TYPES
    FROM PUBLIC;

ALTER DEFAULT PRIVILEGES
    REVOKE ALL
    ON SCHEMAS
    FROM PUBLIC;

COMMIT;