-- Revert dvdrental_alt:appschema from pg

BEGIN;

DROP SCHEMA rental;

COMMIT;
