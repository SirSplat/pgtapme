-- Revert db_design_intro:appschema from pg

BEGIN;

DROP SCHEMA rental;

COMMIT;
