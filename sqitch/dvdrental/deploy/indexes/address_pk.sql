-- Deploy db_design_intro:indexes/address_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.address
    ADD CONSTRAINT address_pk PRIMARY KEY (address_id);

COMMIT;
