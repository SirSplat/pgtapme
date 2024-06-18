-- Deploy db_design_intro:indexes/store_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.store
    ADD CONSTRAINT store_pk PRIMARY KEY (store_id);

COMMIT;
