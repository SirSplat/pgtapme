-- Revert db_design_intro:indexes/customer_pk from pg

BEGIN;

ALTER TABLE ONLY rental.customer
    DROP CONSTRAINT customer_pk;

COMMIT;
