-- Revert db_design_intro:indexes/payment_pk from pg

BEGIN;

ALTER TABLE ONLY rental.payment
    DROP CONSTRAINT payment_pk;

COMMIT;
