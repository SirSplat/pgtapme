-- Deploy db_design_intro:appschema to pg

BEGIN;

CREATE SCHEMA rental;
COMMENT ON SCHEMA rental IS 'Home of all DVD rental DDL, DML and data.';

COMMIT;
