-- Deploy db_design_intro:indexes/payment_pk to pg
-- requires: db_design_intro:@v0.1-data

BEGIN;

ALTER TABLE ONLY rental.payment
    ADD CONSTRAINT payment_pk PRIMARY KEY (payment_id);

COMMIT;
