-- Revert db_design_intro:foreign_keys/payment_customer_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.payment
    DROP CONSTRAINT payment_customer_id_fk;

COMMIT;
