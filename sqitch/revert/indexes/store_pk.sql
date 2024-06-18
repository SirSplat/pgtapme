-- Revert db_design_intro:indexes/store_pk from pg

BEGIN;

ALTER TABLE ONLY rental.store
    DROP CONSTRAINT store_pk;

COMMIT;
