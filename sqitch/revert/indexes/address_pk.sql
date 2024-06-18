-- Revert db_design_intro:indexes/address_pk from pg

BEGIN;

ALTER TABLE ONLY rental.address
    DROP CONSTRAINT address_pk;

COMMIT;
