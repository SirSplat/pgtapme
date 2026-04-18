-- Revert fdw_source:pgtap_ext from pg

BEGIN;

DROP EXTENSION pgtap;

COMMIT;
