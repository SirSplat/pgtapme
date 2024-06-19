-- Deploy db_design_intro:indexes/inventory_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.inventory
    ADD CONSTRAINT inventory_pk PRIMARY KEY (inventory_id);

COMMIT;
