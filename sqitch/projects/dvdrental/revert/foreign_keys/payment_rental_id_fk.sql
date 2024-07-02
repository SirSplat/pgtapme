-- Revert db_design_intro:foreign_keys/payment_rental_id_fk from pg

BEGIN;

ALTER TABLE ONLY rental.payment
    DROP CONSTRAINT payment_rental_id_fk;

COMMIT;
