-- Deploy db_design_intro:indexes/customer_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.customer
    ADD CONSTRAINT customer_pk PRIMARY KEY (customer_id);

COMMIT;
